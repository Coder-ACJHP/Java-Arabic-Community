package com.community.web.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.community.web.entity.Acomment;
import com.community.web.entity.Answer;
import com.community.web.entity.Question;
import com.community.web.service.CommunityService;
import com.community.web.util.VerifyRecaptcha;

@Controller
public class AnswerController {

	@Autowired
	private CommunityService communityService;

	// REQUIRED VARIABLES OF ANSWER VOTE
	private int tempAnswerId = 0;
	private int nextAnswerId = 0;
	private boolean answerIsUpVoted = false;
	private boolean answerIsDownVoted = false;

	@PostMapping("/AddAnswer")
	public String postAnswerToQuestion(@ModelAttribute("answer") Answer answer,
			@RequestParam("g-recaptcha-response") String gRecaptchaResponse, RedirectAttributes rediectAtt, Model model)
			throws IOException {

		boolean verify = VerifyRecaptcha.verify(gRecaptchaResponse);
		if (verify) {
			int Id = answer.getQUESTIONSID();
			int responderId = answer.getUSERID();

			communityService.saveAnswer(answer);
			communityService.updateUserAnswerCount(responderId);
			communityService.setQuestionIsAnswered(Id);
			communityService.upVoteUser(responderId, 5);
			Answer theAnswer = new Answer();
			model.addAttribute("answer", theAnswer);
			return "redirect:Question?questionId=" + Id;
		}
		rediectAtt.addFlashAttribute("error", "You missed the Captcha!, It must be used or It returned false!");
		return "redirect:Question";

	}

	@GetMapping("/AcceptAnswer")
	public String accepAnswer(@RequestParam("answerId") int Id, 
			@RequestParam("questionId") int theId,
			@RequestParam("answerOwnerId") int answerOwnerId,HttpServletRequest request, 
			RedirectAttributes redirectAttributes) throws IOException {
		
		String address = "redirect:Question?questionId=" + theId;
		
		//First step get logged user Id...
		int loggedInUserId = (int) request.getSession().getAttribute("loggedInUserId");
		//Second step get asker user Id...
		Question question = communityService.getQuestionById(theId);
		//Get all answers for this question and check any answer is accepted!
		List<Answer> answerList = communityService.getAnswersList(question.getID());
		//Create an variable to count accepted answers..
		int count = 0;
		for(Answer a: answerList) {
			if(a.isISACCEPTED()){
				count++;
			}	
		}
		//Return the status...
		if(loggedInUserId != question.getUSERID()) {
			redirectAttributes.addFlashAttribute("errorOne", "error!");
		}else if(loggedInUserId == question.getUSERID() && count == 1){
			redirectAttributes.addFlashAttribute("errorTwo", "error!");
		}else {
			communityService.acceptAnswer(Id);
			communityService.upVoteUser(answerOwnerId, 15);
		}
		return address;
	}

/*--------------------------------------------------------------
	if('${counter}' == 1){alert('Every question can only be one correct answer!');}
	else if('${sessionScope[userId]}' != '${question.USERID }'){alert('This is not your own question!');}
	else{window.location='${acceptAnswer}'}" />
----------------------------------------------------------------*/
	@GetMapping("/UpVoteAnswer")
	public String upVoteAnswer(@RequestParam("answerId") int Id, @RequestParam("questionId") int theId,
			@RequestParam("respondedId") int respondedId, Model model) {

		if (answerIsDownVoted == true && nextAnswerId == Id) {
			communityService.upVoteAnswer(Id, 2);
			communityService.upVoteUser(respondedId, 2);
			tempAnswerId = Id;
			answerIsUpVoted = true;
		} else if (tempAnswerId != Id) {
			communityService.upVoteAnswer(Id, 1);
			communityService.upVoteUser(respondedId, 2);
			tempAnswerId = Id;
			answerIsUpVoted = true;
		} else {
			communityService.downVoteAnswer(Id, 1);
			tempAnswerId = 0;
			answerIsUpVoted = false;
		}

		return "redirect:Question?questionId=" + theId;
	}

	@GetMapping("/DownVoteAnswer")
	public String downVoteAnswer(@RequestParam("answerId") int Id, @RequestParam("questionId") int theId,
			@RequestParam("respondedId") int respondedId, Model model) {

		if (answerIsUpVoted == true && tempAnswerId == Id) {
			communityService.downVoteAnswer(Id, 2);
			communityService.downVoteUser(respondedId, 2);
			nextAnswerId = Id;
			answerIsDownVoted = true;
		} else if (nextAnswerId != Id) {
			communityService.downVoteAnswer(Id, 1);
			communityService.downVoteUser(respondedId, 2);
			answerIsDownVoted = true;
		} else {
			communityService.upVoteAnswer(Id, 1);
			nextAnswerId = 0;
			answerIsDownVoted = false;
		}

		return "redirect:Question?questionId=" + theId;
	}

	@GetMapping("/EditAnswer")
	public String editAnswer(@RequestParam("answerId") int theId, Model model) {

		Answer answer = communityService.getAnswerById(theId);
		model.addAttribute("answer", answer);
		return "answer-from";
	}

	@PostMapping("/UpdateAnswer")
	public String updateAnswer(@ModelAttribute("answer") Answer answer,
			@RequestParam("g-recaptcha-response") String gRecaptchaResponse, RedirectAttributes redirectAttributes,
			HttpServletRequest request) throws IOException {

		boolean verify = VerifyRecaptcha.verify(gRecaptchaResponse);
		if (verify) {
			communityService.saveAnswer(answer);
			return "redirect:" + request.getParameter("from");
		}
		redirectAttributes.addFlashAttribute("error_message",
				"You missed the Captcha!, It must be used or It returned false!");
		return "redirect:EditAnswer";
	}

	@GetMapping("/DeleteAnswer")
	public String deleteAnswer(@RequestParam("answerId") int theId, @RequestParam("questionId") int Id,
			RedirectAttributes redirectAtt) {
		Answer answer = communityService.getAnswerById(theId);

		communityService.deleteAnswerById(theId);
		communityService.deleteAcommentByAnswerId(theId);
		communityService.downVoteUser(answer.getUSERID(), 15);
		redirectAtt.addFlashAttribute("question_error",
				"Your answer deleted successfully but you losted 15 reputations.");
		return "redirect:Question?questionId=" + Id;
	}

	@PostMapping("/answerComment")
	public String addCommentToAnswer(@ModelAttribute("acomment") Acomment acomment, Model model) {

		Answer findAnswer = communityService.getAnswerById(acomment.getANSWERID());
		int Id = findAnswer.getQUESTIONSID();
		if (!acomment.getCOMMENT().isEmpty()) {
			communityService.saveAcomment(acomment);
			Acomment theAcomment = new Acomment();
			model.addAttribute("acomment", theAcomment);
			return "redirect:Question?questionId=" + Id;
		} else {
			model.addAttribute("answer_error", "Comment can not be blank!");
			Acomment theAcomment = new Acomment();
			model.addAttribute("acomment", theAcomment);
			return "redirect:Question?questionId=" + Id;
		}
	}
}

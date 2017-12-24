package com.community.web.controller;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.codec.binary.Base64;
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
import com.community.web.entity.Qcomment;
import com.community.web.entity.Question;
import com.community.web.entity.Users;
import com.community.web.service.CommunityService;
import com.community.web.util.VerifyRecaptcha;

@Controller
public class QuestionController {

	@Autowired
	private CommunityService communityService;

	// REQUIRED VARIABLES OF QUESTION VOTE
	private int tempQuestionId = 0;
	private int nextQuestionId = 0;
	private boolean isUpVoted = false;
	private boolean isDownVoted = false;

	@GetMapping("/Question")
	public String getQuestionWithId(@RequestParam("questionId") int theId, Model model) {

		//For new actions prepare objects and add to attribute.
		final Qcomment qcomment = new Qcomment();
		final Acomment acomment = new Acomment();
		final Answer answer = new Answer();
		
		
		final Question theQuestion = communityService.getQuestionById(theId);
		final List<Qcomment> theCommentList = communityService.getCommentList(theQuestion.getID());
		final Users qUser = communityService.getUserById(theQuestion.getUSERID());
		byte[] qEncodeBase64 = Base64.encodeBase64(qUser.getPICTURE());
		String qBase64Encoded = new String(qEncodeBase64);
		boolean status = theQuestion.isISANSWERED();
		
		if (status == true) {

			final List<Answer> theAnswerList = communityService.getAnswersList(theQuestion.getID());
			final Map<Integer, List<Acomment>> mapList = new HashMap<>();
			final Map<Users, String> userMap = new HashMap<>();
			
			for (Answer a : theAnswerList) {
				
				final List<Acomment> theAcommentList = communityService.getAcommentList(a.getID());
				Users aUser = communityService.getUserById(a.getUSERID());
				byte[] aEncodeBase64 = Base64.encodeBase64(aUser.getPICTURE());
				String aBase64Encoded = new String(aEncodeBase64);
				mapList.put(a.getID(), theAcommentList);
				userMap.put(aUser, aBase64Encoded);
				model.addAttribute("answer", a);
			}
			
			model.addAttribute("userMap", userMap);
			model.addAttribute("acommentList", mapList);
			model.addAttribute("answerList", theAnswerList);
			model.addAttribute("acomment", acomment);

		}

		model.addAttribute("askerImage", qBase64Encoded);
		model.addAttribute("askerUser", qUser);
		model.addAttribute("qcomment", qcomment);
		model.addAttribute("answer", answer);
		model.addAttribute("commentList", theCommentList);
		model.addAttribute("question", theQuestion);

		return "question-page";
	}

	@GetMapping("/UpdateQuestion")
	public String UpdateQuestion(@RequestParam("questionId") int theId, Model model) {
		Question question = communityService.getQuestionById(theId);
		model.addAttribute("question", question);
		return "question-form";
	}

	@GetMapping("/DeleteQuestion")
	public String DeleteQuestion(@RequestParam("questionId") int theId, RedirectAttributes redirectAttributes) {

		final Question question = communityService.getQuestionById(theId);
		final List<Answer> answerList = communityService.getAnswersList(question.getID());

		for (Answer a : answerList) {
			communityService.deleteAcommentByAnswerId(a.getID());
		}

		communityService.deleteQuestion(theId);
		communityService.deleteQcommentByQuestionId(question.getID());
		communityService.deleteAnswerByQuestionId(question.getID());
		communityService.downVoteUser(theId, 20);
		redirectAttributes.addFlashAttribute("message", "Your question deleted successfully but you lost 20 reputation.");
		return "redirect:AllQuestions";
	}

	@GetMapping("/Question-form")
	public String askQuestion(Model model) {
		final Question question = new Question();
		model.addAttribute("question", question);
		return "question-form";
	}

	@PostMapping("SaveQuestion")
	public String addQuestion(@ModelAttribute("question") Question question,
			@RequestParam("g-recaptcha-response") String gRecaptchaResponse, RedirectAttributes rediectAtt)
			throws IOException {

		boolean verify = VerifyRecaptcha.verify(gRecaptchaResponse);

		if (verify) {
			question.setCREATIONDATE(LocalDateTime.now().toString());
			communityService.saveQuestion(question);
			communityService.updateUserQuestionCount(question.getUSERID());
			rediectAtt.addFlashAttribute("message", "Your question saved successfully.");
			return "redirect:AllQuestions";
		} else {
			rediectAtt.addFlashAttribute("error", "You missed the Captcha!, It must be used or It returned false!");
			return "redirect:Question-form";
		}
	}

	@PostMapping("/questionComment")
	public String addCommentToQuestion(@ModelAttribute("qcomment") Qcomment qcomment, Model model) {

		String sendTo = "";
		int Id = qcomment.getQUESTIONID();

		if (!qcomment.getCOMMENT().isEmpty()) {
			
			communityService.saveQcomment(qcomment);
			Qcomment theComment = new Qcomment();
			model.addAttribute("qcomment", theComment);
			sendTo = "redirect:Question?questionId=" + Id;
			
		} else {
			
			model.addAttribute("question_error", "Comment can not be blank!");
			Qcomment theComment = new Qcomment();
			model.addAttribute("qcomment", theComment);
			sendTo = "redirect:Question?questionId=" + Id;
		}
		return sendTo;
	}

	@GetMapping("/UpVoteQuestion")
	public String upVoteQuestion(@RequestParam("questionId") int theId, @RequestParam("qUserId") int qUserId,
			Model model, HttpServletRequest request) {

		if (isDownVoted == true && nextQuestionId == theId) {
			communityService.upVoteQuestion(theId, 2);
			communityService.upVoteUser(qUserId, 2);
			tempQuestionId = theId;
			isUpVoted = true;
		} else if (tempQuestionId != theId) {
			communityService.upVoteQuestion(theId, 1);
			communityService.upVoteUser(qUserId, 2);
			tempQuestionId = theId;
			isUpVoted = true;

		} else {
			communityService.downVoteQuestion(theId, 1);
			tempQuestionId = 0;
			isUpVoted = false;
		}

		return "redirect:Question?questionId=" + theId;
	}

	@GetMapping("/DownVoteQuestion")
	public String downVoteQuestion(@RequestParam("questionId") int theId, @RequestParam("qUserId") int qUserId,
			Model model) {
		if (isUpVoted == true && tempQuestionId == theId) {
			communityService.downVoteQuestion(theId, 2);
			communityService.downVoteUser(qUserId, 2);
			nextQuestionId = theId;
			isDownVoted = true;
		} else if (nextQuestionId != theId) {
			communityService.downVoteQuestion(theId, 1);
			communityService.downVoteUser(qUserId, 2);
			nextQuestionId = theId;
			isDownVoted = true;

		} else {
			communityService.upVoteQuestion(theId, 1);
			nextQuestionId = 0;
			isDownVoted = false;
		}

		return "redirect:Question?questionId=" + theId;
	}

}

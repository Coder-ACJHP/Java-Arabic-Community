package com.community.web.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.community.web.entity.Answer;
import com.community.web.entity.AnswerComment;
import com.community.web.entity.AnswerVote;
import com.community.web.entity.Question;
import com.community.web.entity.UserMessages;
import com.community.web.service.CommunityService;

@Controller
public class AnswerController {

	@Autowired
	private CommunityService communityService;

	//Set the initBinder StringTrimmer for validate white spaces in the form.
	@InitBinder
	public void initBinder(WebDataBinder databinder) {
		StringTrimmerEditor sEditor = new StringTrimmerEditor(true);
		databinder.registerCustomEditor(String.class, sEditor);
	}
	
	@PostMapping("/AddAnswer")
	public String postAnswerToQuestion(Model model, @ModelAttribute("answer") 
							Answer answer, RedirectAttributes redirectAttributes) {

		int Id = answer.getQUESTIONSID();
		final String address = "redirect:Question?questionId=" + Id;
		
		if(answer.getANSWER().contains("Write your answer here!") || answer.getANSWER().isEmpty()) {
			redirectAttributes.addFlashAttribute("emptyField", "Answer is required and cannot be empty!");
			return address;
			
		} else {
			
			int responderId = answer.getUSERID();
			communityService.saveAnswer(answer);
			communityService.updateUserAnswerCount(responderId);
			communityService.setQuestionIsAnswered(Id);
			communityService.upVoteUser(responderId, 5);
			final Question question = communityService.getQuestionById(answer.getQUESTIONSID());
			final UserMessages message = new UserMessages(
					question.getUSERID(), "New answer!", 
					"Question?questionId="+question.getID(), answer.getANSWER(), false);
			communityService.sendMessageToUser(message);
			model.addAttribute("answer", new Answer());
			return  address;
		}

	}

	@GetMapping("/AcceptAnswer")
	public String accepAnswer(@RequestParam("answerId") int answerId, 
			@RequestParam("questionId") int questionId, 
			@RequestParam("answerOwnerId") int answerOwnerId,
			@RequestParam("currentUserId") int currentUserId,  
			RedirectAttributes redirectAttributes) {
				
		//Second step get asker user Id...
		Question question = communityService.getQuestionById(questionId);
		//Get all answers for this question and check any answer is accepted!
		List<Answer> answerList = communityService.getAnswersList(question.getID());
		//Create an variable to count accepted answers..
		boolean isAccepted = false;
		for(Answer a: answerList) {
			if(a.isISACCEPTED()){
				isAccepted = true;
			}	
		}
                
		//Return the status...
		if(currentUserId != question.getUSERID()) {
			redirectAttributes.addFlashAttribute("error", "This is not your own question!You cannot accept or reject it.");
		}else if(currentUserId == question.getUSERID() && isAccepted){
			redirectAttributes.addFlashAttribute("error", "The answer already accepted!");
		}else {
			communityService.acceptAnswer(answerId);
			communityService.upVoteUser(answerOwnerId, 15);
		}
		
		return "redirect:Question?questionId=" + questionId;
	}

	@PostMapping(value="UpVoteAnswer")
	public @ResponseBody String upVoteAnswer(
			@ModelAttribute("answerId") int answerId, @ModelAttribute("answerOwnerId") int answerOwnerId,
			@ModelAttribute("currentUserId") int currentUserId) {
		
		int result = communityService.checkTheAnswerVoteIsThere(currentUserId, answerId);
		
		if(result == 0) {
			communityService.addAnswerVote(new AnswerVote(currentUserId, answerId, 1));
			communityService.upVoteAnswer(answerId, 1);
			communityService.upVoteUser(answerOwnerId, 1);
			final Answer answer = communityService.getAnswerById(answerId);
			return String.valueOf(answer.getVOTE());
			
		} else if(result == -1) {
			communityService.updateAnswerVote(currentUserId, answerId, 1);
			communityService.upVoteAnswer(answerId, 2);
			communityService.upVoteUser(answerOwnerId, 1);
			final Answer answer = communityService.getAnswerById(answerId);
			return String.valueOf(answer.getVOTE());
			
		} else {
			return "You already upvoted this answer!";
		}
	}

	@PostMapping(value="DownVoteAnswer")
	public @ResponseBody String downVoteAnswer(
			@ModelAttribute("answerId") int answerId, @ModelAttribute("answerOwnerId") int answerOwnerId,
			@ModelAttribute("currentUserId") int currentUserId) {

		int result = communityService.checkTheAnswerVoteIsThere(currentUserId, answerId);
		
		if(result == 0) {
			communityService.addAnswerVote(new AnswerVote(currentUserId, answerId, -1));
			communityService.downVoteAnswer(answerId, 1);
			communityService.downVoteUser(answerOwnerId, 1);
			final Answer answer = communityService.getAnswerById(answerId);
			return String.valueOf(answer.getVOTE());
			
		} else if(result == 1) {
			communityService.updateAnswerVote(currentUserId, answerId, -1);
			communityService.downVoteAnswer(answerId, 2);
			communityService.downVoteUser(answerOwnerId, 1);
			final Answer answer = communityService.getAnswerById(answerId);
			return String.valueOf(answer.getVOTE());
			
		} else {
			return "You already downvoted this answer!";
		}
	}

	@GetMapping("/EditAnswer")
	public String editAnswer(@RequestParam("answerId") int theId, Model model) {

		Answer answer = communityService.getAnswerById(theId);
		model.addAttribute("answer", answer);
		return "answer-from";
	}

	@PostMapping("/UpdateAnswer")
	public String updateAnswer(@ModelAttribute("answer") Answer answer,
									RedirectAttributes redirectAttributes) {

		final String failAddress = "redirect:EditAnswer?answerId=" + answer.getID();
		final String successAddress = "redirect:Question?questionId=" + answer.getQUESTIONSID();
		
		if(answer.getANSWER() == null || answer.getANSWER().contains("Write your answer here!")) {
			redirectAttributes.addFlashAttribute("error", "Answer is required and cannot be empty!");
			return failAddress;
			
		} else {
			
			communityService.saveAnswer(answer);
			return successAddress;
		}
			
	}

	@GetMapping("/DeleteAnswer")
	public String deleteAnswer(@RequestParam("answerId") int theId, @RequestParam("questionId") int Id,
			RedirectAttributes redirectAtt) {
		Answer answer = communityService.getAnswerById(theId);

		communityService.deleteAnswerById(theId);
		
		if(communityService.getAnswersList(Id).isEmpty()) {
			communityService.setQuestionUnAnswered(Id);
		}
		communityService.deleteAcommentByAnswerId(theId);
		communityService.downVoteUser(answer.getUSERID(), 15);
		redirectAtt.addFlashAttribute("message", "Your answer deleted successfully but you losted 15 reputations.");
		return "redirect:Question?questionId=" + Id;
	}

	@PostMapping("/answerComment")
	public String addCommentToAnswer(@ModelAttribute("acomment") AnswerComment answerComment, Model model) {

		Answer findAnswer = communityService.getAnswerById(answerComment.getANSWERID());
		int Id = findAnswer.getQUESTIONSID();
		if (!answerComment.getCOMMENT().isEmpty()) {
			communityService.saveAcomment(answerComment);
			
			final Answer answer = communityService.getAnswerById(answerComment.getANSWERID());
			final UserMessages message = new UserMessages(
					answer.getUSERID(), "New comment!", 
					"Question?questionId="+answer.getQUESTIONSID(), answerComment.getCOMMENT(), false);
			communityService.sendMessageToUser(message);
			
			model.addAttribute("acomment", new AnswerComment());
			return "redirect:Question?questionId=" + Id;
		} else {
			model.addAttribute("error", "Comment can not be blank!");
			AnswerComment theAcomment = new AnswerComment();
			model.addAttribute("acomment", theAcomment);
			return "redirect:Question?questionId=" + Id;
		}
	}
}

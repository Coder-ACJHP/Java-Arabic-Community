package com.community.web.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.apache.commons.codec.binary.Base64;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.community.web.entity.Answer;
import com.community.web.entity.AnswerComment;
import com.community.web.entity.Favorities;
import com.community.web.entity.Question;
import com.community.web.entity.QuestionComment;
import com.community.web.entity.QuestionVote;
import com.community.web.entity.UserMessages;
import com.community.web.entity.Users;
import com.community.web.service.CommunityService;

@Controller
public class QuestionController {

	@Autowired
	private CommunityService communityService;


	@GetMapping("/Question")
	public String getQuestionWithId(@RequestParam("questionId") int theId, HttpServletRequest request, Model model) {

		String qBase64Encoded = null;
		boolean isFavorite = false;
		
		final Question theQuestion = communityService.getQuestionById(theId);
		final List<QuestionComment> theCommentList = communityService.getCommentList(theQuestion.getID());
		final Users askerUser = communityService.getUserById(theQuestion.getUSERID());
		
		//convert the user id to integer if its present else assign it with zero
		int currentUserId = request.getSession().getAttribute("loggedInUserId") != null ? Integer.parseInt(request.getSession().getAttribute("loggedInUserId").toString()) : 0;

		//add condition if currentuserId bigger than zero search about the question is favorite?
		if(currentUserId > 0) {
			final Users principal = communityService.getUserById(currentUserId);
			final List<Favorities> favoritiesList = principal.getFavorities();
			
			
			for(Favorities fav: favoritiesList) {
				
				if(fav.getFavQuestionId() == theId)
					isFavorite = true;
			}
			
		}
		
		if(askerUser != null) {
			byte[] qEncodeBase64 = Base64.encodeBase64(askerUser.getPICTURE());
			qBase64Encoded = new String(qEncodeBase64);
		}
		
		//add condition if the question is answered fetch the answers and answers comments.
		if (theQuestion.isISANSWERED()) {

			final List<Answer> theAnswerList = communityService.getAnswersList(theQuestion.getID());
			final Map<Integer, List<AnswerComment>> mapList = new HashMap<>();
			final Map<Users, String> userMap = new HashMap<>();
			
                        theAnswerList.forEach((a) -> {
                            List<AnswerComment> theAcommentList = communityService.getAcommentList(a.getID());
                            Users aUser = communityService.getUserById(a.getUSERID());
                            String aBase64Encoded = new String(Base64.encodeBase64(aUser.getPICTURE()));
                            mapList.put(a.getID(), theAcommentList);
                            userMap.put(aUser, aBase64Encoded);
                            model.addAttribute("answer", a);
                        });
			
			model.addAttribute("userMap", userMap);
			model.addAttribute("acommentList", mapList);
			model.addAttribute("answerList", theAnswerList);
			model.addAttribute("acomment", new AnswerComment());

		}
		
		//everything O.K. now we have to add some attributes to model.
		model.addAttribute("askerImage", qBase64Encoded);
		model.addAttribute("askerUser", askerUser);
		model.addAttribute("qcomment", new QuestionComment());
		model.addAttribute("answer", new Answer());
		model.addAttribute("commentList", theCommentList);
		model.addAttribute("question", theQuestion);
		model.addAttribute("isFavorite", isFavorite);
		
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

		final List<Answer> answerList = communityService.getAnswersList(theId);

                answerList.forEach((a) -> {
                    communityService.deleteAcommentByAnswerId(a.getID());
                });

		communityService.deleteQuestion(theId);
		communityService.deleteQcommentByQuestionId(theId);
		communityService.deleteAnswerByQuestionId(theId);
		communityService.deleteFavoriteByQuestionId(theId);
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
	public String addQuestion(Model model, @ModelAttribute("question") @Valid Question question, 
				BindingResult bindingResult, RedirectAttributes redirectAttributes) {
		
		if(bindingResult.hasErrors()) {
			model.addAttribute("org.springframework.validation.BindingResult.question", bindingResult);
			return "question-form";
			
		} else {
			
			communityService.saveQuestion(question);
			communityService.updateUserQuestionCount(question.getUSERID());
			redirectAttributes.addFlashAttribute("message", "Your question saved successfully.");
			return "redirect:AllQuestions";
		}
	}

	
	
	@PostMapping("/questionComment")
	public String addCommentToQuestion(@ModelAttribute("qcomment") QuestionComment questionComment, Model model) {

		String sendTo = "";
		int Id = questionComment.getQUESTIONID();

		if (!questionComment.getCOMMENT().isEmpty()) {
			
			communityService.saveQcomment(questionComment);
			final Question question = communityService.getQuestionById(questionComment.getQUESTIONID());
			final UserMessages message = new UserMessages(
					question.getUSERID(), "New comment!",
					"Question?questionId="+questionComment.getQUESTIONID(), questionComment.getCOMMENT(),  false);
			communityService.sendMessageToUser(message);
			model.addAttribute("qcomment", new QuestionComment());
			sendTo = "redirect:Question?questionId=" + Id;
			
		} else {
			
			model.addAttribute("error", "Comment can not be blank!");
			QuestionComment theComment = new QuestionComment();
			model.addAttribute("qcomment", theComment);
			sendTo = "redirect:Question?questionId=" + Id;
		}
		return sendTo;
	}

	@PostMapping(value="UpVoteQuestion")
	public @ResponseBody String upVoteQuestion(@ModelAttribute("questionId") int questionId, 
			@ModelAttribute("currentUserId") int currentUserId, @ModelAttribute("questionOwnerId") int questionOwnerId) {
		
		int result = communityService.checkTheQuestionVoteIsThere(currentUserId, questionId);
				
            switch (result) {
                case 0:
                {
                    communityService.addQuestionVote(new QuestionVote(currentUserId, questionId, 1));
                    communityService.upVoteQuestion(questionId, 1);
                    communityService.upVoteUser(questionOwnerId, 1);
                    final Question question = communityService.getQuestionById(questionId);
                    return String.valueOf(question.getVOTE());
                    
                }
                case -1:
                {
                    communityService.updateQuestionVote(currentUserId, questionId, 1);
                    communityService.upVoteQuestion(questionId, 2);
                    communityService.upVoteUser(questionOwnerId, 1);
                    final Question question = communityService.getQuestionById(questionId);
                    return String.valueOf(question.getVOTE());
                    
                }
                default:
                    return "You already upvoted this question!";
            }
		
	}

	@PostMapping(value="DownVoteQuestion")
	public @ResponseBody String downVoteQuestion(@ModelAttribute("questionId") int questionId, 
			@ModelAttribute("currentUserId") int currentUserId, @ModelAttribute("questionOwnerId") int questionOwnerId) {
		
		int result = communityService.checkTheQuestionVoteIsThere(currentUserId, questionId);

            switch (result) {
                case 0:
                {
                    communityService.addQuestionVote(new QuestionVote(currentUserId, questionId, -1));
                    communityService.downVoteQuestion(questionId, 1);
                    communityService.downVoteUser(questionOwnerId, 1);
                    final Question question = communityService.getQuestionById(questionId);
                    return String.valueOf(question.getVOTE());
                    
                }
                case 1:
                {
                    communityService.updateQuestionVote(currentUserId, questionId, -1);
                    communityService.downVoteQuestion(questionId, 2);
                    communityService.downVoteUser(questionOwnerId, 1);
                    final Question question = communityService.getQuestionById(questionId);
                    return String.valueOf(question.getVOTE());
                    
                }
                default:
                    return "You already downvoted this question!";
            }

	}

	@PostMapping(value="AddToFav")
	public @ResponseBody String addTheQuestionToFavorite(RedirectAttributes redirectAttributes,
                @ModelAttribute("questionId") int theId, @ModelAttribute("userId") int userId) {
		
		final Users users = communityService.getUserById(userId);
		final Favorities favority = new Favorities(theId);
		users.addFavority(favority);
		communityService.saveFavorite(favority);
		redirectAttributes.addFlashAttribute("isFavorite", true);
		return "success";
	}

	@PostMapping("/RemoveFromFav")
	public @ResponseBody String removeTheQuestionFromFavorite(RedirectAttributes redirectAttributes,
                @ModelAttribute("questionId") int theId, @ModelAttribute("userId") int userId) {
		
		communityService.deleteFavorite(userId, theId);
                redirectAttributes.addFlashAttribute("isFavorite", false);
		return "success";
	}

}

package com.community.web.controller;

import java.io.IOException;
import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;
import java.util.UUID;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.codec.binary.Base64;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.MailException;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.community.web.entity.Answer;
import com.community.web.entity.Question;
import com.community.web.entity.Users;
import com.community.web.service.CommunityService;
import com.community.web.util.PasswordResetMessage;

@Controller
public class MainSpringController {

	@Autowired
	private JavaMailSender mailSender;
	
	@Autowired
	private CommunityService communityService;
	
	//inject country list form properties file.
	@Value("#{countriesOption}") 
	private Map<String, String> countryOptions;

	private final String EMAIL = "java.arabic.community@gmail.com";
	
	@GetMapping(value={"/", "/AllQuestions"}) //HOMEPAGE
	public String showQuestionlist(Model model) {
		
		Integer offset = 1;
		final Integer maxresults = 100; // questions limit per page.
		Long maxQC = 0L;
		
		final List<Question> questionsList = communityService.getQuestionsListByLimit(offset, maxresults);
		final Map<Users, String> userInfoMap = new HashMap<>();
		for (Question q : questionsList) {
			maxQC++;
			Users users = communityService.getUserById(q.getUSERID());
			byte[] encodeBase64 = Base64.encodeBase64(users.getPICTURE());
			String base64Encoded = new String(encodeBase64);
			userInfoMap.put(users, base64Encoded);
		}
		
		final List<Answer> answerList = communityService.getAnswersList();
		model.addAttribute("questionList", questionsList);
		model.addAttribute("answerList", answerList);
		model.addAttribute("userMap", userInfoMap);
		model.addAttribute("questionCount", maxQC);
		model.addAttribute("offset", offset);
		return "home-page";
	}

	@GetMapping("/TopQuestions")
	public String getTopQuestions(Model model) {
		
		final List<Question> questionsList = communityService.getTopQuestions();
		final Map<Users, String> userInfoMap = new HashMap<>();
		Long maxQC = 0L;
		
		for (Question q : questionsList) {
			maxQC++;
			Users users = communityService.getUserById(q.getUSERID());
			byte[] encodeBase64 = Base64.encodeBase64(users.getPICTURE());
			String base64Encoded = new String(encodeBase64);
			userInfoMap.put(users, base64Encoded);
		}
		
		final List<Answer> answerList = communityService.getAnswersList();
		model.addAttribute("questionList", questionsList);
		model.addAttribute("answerList", answerList);
		model.addAttribute("userMap", userInfoMap);
		model.addAttribute("questionCount", maxQC);
		model.addAttribute("Label", "Top Questions");
		return "home-page";
	}
	
	@GetMapping("/SignIn")
	public String singIn(Model model) {
		
		final Users users = new Users();
		model.addAttribute("user", users);
		return "user-signIn";
	}

	@GetMapping("/SignUp")
	public String singUp(Model model) {
		
		final Users theUser = new Users();
		final Map<String, String> treeMap = new TreeMap<>(countryOptions);
		model.addAttribute("countriesOption", treeMap);
		model.addAttribute("user", theUser);
		return "user-register";
	}

	@GetMapping("LoginForm")
	public String Login(Principal principal, Model model, HttpServletRequest request,
			final RedirectAttributes redirectAttributes) {

			
			final Users theUser = communityService.getUserByEmail(principal.getName());
			byte[] encodeBase64 = Base64.encodeBase64(theUser.getPICTURE());
			final String base64Encoded = new String(encodeBase64);
			request.getSession().setAttribute("loggedInUserPicture", base64Encoded);
			request.getSession().setAttribute("loggedInUserId", theUser.getID());
			request.getSession().setAttribute("loggedInUserNickname", theUser.getNICKNAME());
			request.getSession().setAttribute("loggedInUserRegDate", theUser.getREGISTERDATE().substring(0, 10));
			request.getSession().setAttribute("loggedInUserVote", theUser.getVOTE());

			return "redirect:AllQuestions";
	}

	@PostMapping("/j_spring_security_logout")
	public String Logout(HttpServletResponse response, HttpServletRequest request, RedirectAttributes redirectAttributes) {
		
		final Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if (auth != null){
            new SecurityContextLogoutHandler().logout(request, response, auth);
		}
		
		request.removeAttribute("loggedInUser");
		redirectAttributes.addFlashAttribute("message", "We hope to see you again as soon.");
		return "redirect:AllQuestions";
	}

	@GetMapping("DeleteAccount")
	public String deleteAccout(@RequestParam("ID") int theId, Model model) throws IOException {
		
		final List<Question> ql = communityService.getQuestionListByUserId(theId);
		for(Question q:ql) {
			communityService.changeQuestionAsGuess(q.getID());
			List<Answer> al = communityService.getAnswersList(q.getID());
			for(Answer a: al) {
				communityService.changeAnswerAsGuess(a.getID());
			}
		}
		communityService.deleteUser(theId);
		model.addAttribute("message", "Your account is deleted so after this you are anonymous!");
		return "redirect:Loguot";
	}

	@GetMapping("/ForgotPassword")
	public String forgotPassword(Model model) {
		model.addAttribute("user", new Users());
		return "send-email";
	}

	@PostMapping("/Search")
	public String searchQuestion(@RequestParam("theSearchName") String theSearchName, Model model) {
		
		final List<Question> theQuestion = communityService.searchQuestion(theSearchName);
		final Map<Users, String> userInfoMap = new HashMap<>();
		Long maxQC = 0L;
		
		for (Question q : theQuestion) {
			maxQC++;
			Users users = communityService.getUserById(q.getUSERID());
			byte[] encodeBase64 = Base64.encodeBase64(users.getPICTURE());
			String base64Encoded = new String(encodeBase64);
			userInfoMap.put(users, base64Encoded);
		}
		
		final List<Answer> answerList = communityService.getAnswersList();
		model.addAttribute("questionList", theQuestion);
		model.addAttribute("answerList", answerList);
		model.addAttribute("userMap", userInfoMap);
		model.addAttribute("questionList", theQuestion);
		model.addAttribute("questionCount", maxQC);
		return "home-page";
	}

	@PostMapping("/SendEmail")
	public String sendEmail(@ModelAttribute("user") Users users, RedirectAttributes redirectAttrs) {
		
		if (users.getEMAIL() != null) {
			
			final Users usr = communityService.getUserByEmail(users.getEMAIL());
			
			if (usr != null) {
				//Generate an unique code and send to user.
				final UUID uuid = UUID.randomUUID();
				//Save it in user profile in database.
				communityService.setUUIDofUser(usr.getID(), uuid.toString());
				//Generate body of email to send...
				String body = new PasswordResetMessage().getMessageBody(usr.getNICKNAME(), uuid.toString(), usr.getID());
				
				try {
					
					mailSender.send((MimeMessage mimeMessage) -> {
						MimeMessageHelper message = new MimeMessageHelper(mimeMessage, true, "UTF-8");
						message.setFrom(EMAIL);
						message.setTo(usr.getEMAIL());
						message.setSubject("Java Arabic Community Reset Password");
						message.setText(body, true);
					});
					
				} catch (MailException e) {
					redirectAttrs.addFlashAttribute("error", e.getLocalizedMessage());
				}
				
				redirectAttrs.addFlashAttribute("success", "Thank you "+usr.getNICKNAME()+", your email has been sent please check your mailbox.");
				
			} else { redirectAttrs.addFlashAttribute("error", "The email you entered is not registered! Please be sure.");}
		} else { redirectAttrs.addFlashAttribute("error", "Please enter your email in the blank!");}
		
		return "redirect:ForgotPassword";
	}

	@GetMapping("/Info-page")
	public String infoPage() {
		return "info";
	}
	
	@GetMapping("/Suggestion")
	public String suggestionPage(Model model) {
		
		final Map<String, String> treeMap = new TreeMap<>(countryOptions);
		model.addAttribute("countriesOption", treeMap);
		return "suggestion-page";
	}

	@PostMapping("/SendSuggest")
	public String sendSuggest(@RequestParam("name") String name, @RequestParam("email") String email,
			@RequestParam("country") String country, @RequestParam("category") String category,
			@RequestParam("subject") String subject, @RequestParam("message") String message,
			Model model, RedirectAttributes redirectAttrs) {
		
		final String messageBody = "<p>Sender : "+name+"</p><p>Email : "+email+"</p>"
                        + "<p>Country : "+country+"</p><p>Category : "+category+"</p><pre>"+message+"</pre>";
		
		try {
			mailSender.send((MimeMessage mimeMessage)-> {
				MimeMessageHelper messageHelper = new MimeMessageHelper(mimeMessage, true, "UTF-8");
				messageHelper.setFrom(EMAIL);
				messageHelper.setTo("onur.isik@codeforiraq.org");
				messageHelper.setSubject(subject);
				messageHelper.setText(messageBody, true);
			});
			
			redirectAttrs.addFlashAttribute("success", "Thank you "+name+", your "+category+" has been sent successfully.");
			
		} catch (MailException e) {
			redirectAttrs.addFlashAttribute("error", e.getLocalizedMessage());
		}
		
		return "redirect:Suggestion";
	}
}

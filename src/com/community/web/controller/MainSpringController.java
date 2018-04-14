package com.community.web.controller;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.TreeMap;
import java.util.UUID;
import java.util.concurrent.atomic.AtomicLong;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.apache.commons.codec.binary.Base64;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.mail.MailException;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.community.web.entity.Answer;
import com.community.web.entity.LoginUser;
import com.community.web.entity.Question;
import com.community.web.entity.Suggestion;
import com.community.web.entity.UserMessages;
import com.community.web.entity.Users;
import com.community.web.service.CommunityService;
import com.community.web.util.ErrorMessage;
import com.community.web.util.PasswordResetMessage;
import com.community.web.util.SuggestionMessage;
import com.community.web.util.ValidationResponse;

@Controller
public class MainSpringController {

	@Autowired
	private JavaMailSender mailSender;
	
	@Autowired
	private CommunityService communityService;
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
	//inject country list form properties file.
	@Value("#{countriesOption}") 
	private Map<String, String> countryOptions;

	private final static String SENDER_MAIL = "java.arabic.community@gmail.com";
	private final static String RECIEVER_MAIL = "onur.isik@codeforiraq.org";
	private final SuggestionMessage suggestionMessageHelper = new SuggestionMessage();
	
	
	//Set the initBinder StringTrimmer for validate white spaces in the form.
	@InitBinder
	public void initBinder(WebDataBinder databinder) {
		StringTrimmerEditor sEditor = new StringTrimmerEditor(true);
		databinder.registerCustomEditor(String.class, sEditor);
	}
	
	@GetMapping(value={"/", "/AllQuestions"}) //HOMEPAGE
	public String showQuestionlist(Model model, Integer offset, Integer maxResults) {

		List<Question> questionsList = communityService.getQuestionsListByLimit(offset, maxResults);
		
		if(questionsList.isEmpty()) {
			
			model.addAttribute("info", suggestionMessageHelper.getNoQuestionMessage());
			model.addAttribute("suggestions", suggestionMessageHelper.getNoQuestionSuggestionList());
			model.addAttribute("questionCount", 0);
			
		} else {
			
			uploadUsersDetail(model, questionsList);			
			List<Answer> answerList = communityService.getAnswersList();
			model.addAttribute("questionList", questionsList);
			model.addAttribute("answerList", answerList);
			model.addAttribute("questionCount", questionsList.size());
		}

		return "home-page";
	}

	@GetMapping("/TopQuestions")
	public String getTopQuestions(Model model, Integer offset, Integer maxResults) {
		
		List<Question> questionsList = communityService.getTopQuestions(offset, maxResults);
		
		if(questionsList.isEmpty()) {
			model.addAttribute("info", suggestionMessageHelper.getNoQuestionMessage());
			model.addAttribute("suggestions", suggestionMessageHelper.getNoQuestionSuggestionList());
			model.addAttribute("questionCount", 0);
			
		} else {
			
			uploadUsersDetail(model, questionsList);
	
			final List<Answer> answerList = communityService.getAnswersList();
			model.addAttribute("questionList", questionsList);
			model.addAttribute("answerList", answerList);
			model.addAttribute("questionCount", questionsList.size());
			model.addAttribute("Label", "Top Questions");
		}
		return "home-page";
	}

	@GetMapping("/SignIn")
	public String singIn(Model model) {
		
		if(!model.containsAttribute("user")) {
			model.addAttribute("user", new LoginUser());
		}
		return "user-signIn";
	}

	@PostMapping("LoginForm")
	public String Login(@ModelAttribute("user") @Valid LoginUser user, BindingResult bindingResult,
			RedirectAttributes redirectAttributes, HttpServletRequest request) {

		if (bindingResult.hasErrors()) {

			redirectAttributes.addFlashAttribute("org.springframework.validation.BindingResult.user", bindingResult);
			redirectAttributes.addFlashAttribute("user", new LoginUser());
			return "redirect:/SignIn";

		} else {
			// final Users theUser =
			// communityService.getUserByEmail(principal.getEMAIL());
			final Optional<Users> theUser = communityService.findUserByEmailOptional(user.getEmail());

			if (theUser.isPresent()) {

				if (theUser.get().getAuthority().isENABLED()) {

					if (passwordEncoder.matches(user.getPassword(), theUser.get().getPASSWORD())) {

						uploadUserAttributesToSession(theUser, request);

						String referer = request.getHeader("Referer");
						if (referer == null || referer.endsWith("SignIn") || referer.endsWith("SignIn?error=true")) {
							referer = "AllQuestions";
						}

						return "redirect:" + referer;

					} else {
						redirectAttributes.addFlashAttribute("email", theUser.get().getEMAIL());
						redirectAttributes.addFlashAttribute("error", "Incorrect password!");
						return "redirect:SignIn";
					}

				} else {
					redirectAttributes.addFlashAttribute("error", "Your account not activated yet!");
					return "redirect:SignIn";
				}

			} else {
				redirectAttributes.addFlashAttribute("error", "Incorrect email or password!");
				return "redirect:SignIn";
			}
		}

	}

	
	@PostMapping(value = "ModalLogin")
	public @ResponseBody ValidationResponse loginViaAjax(Model model,
			@ModelAttribute(value = "user") @Valid LoginUser user, BindingResult result, HttpServletRequest request) {

		ValidationResponse res = new ValidationResponse();

		if (result.hasErrors()) {

			res.setStatus("FAIL");
			List<FieldError> allErrors = result.getFieldErrors();
			final List<ErrorMessage> errorMesages = new ArrayList<>();
			allErrors.forEach((objectError) -> {
				errorMesages.add(new ErrorMessage(objectError.getField(), objectError.getDefaultMessage()));
			});
			res.setErrorMessageList(errorMesages);

		} else {

			Optional<Users> theUser = communityService.findUserByEmailOptional(user.getEmail());
			final List<ErrorMessage> errorMessagelist = new ArrayList<>();

			if (theUser.isPresent()) {

				if (passwordEncoder.matches(user.getPassword(), theUser.get().getPASSWORD())) {
					uploadUserAttributesToSession(theUser, request);
					res.setStatus("SUCCESS");

				} else {

					res.setStatus("FAIL");
					errorMessagelist.add(new ErrorMessage("password", "Invalid password!"));
				}

			} else {
				res.setStatus("FAIL");
				errorMessagelist.add(new ErrorMessage("FORM FAIL", "Incorrect Email or Password!"));
			}

			res.setErrorMessageList(errorMessagelist);
		}
		return res;
	}
	
	@RequestMapping(value="/Logout", method={RequestMethod.GET, RequestMethod.POST})
	public String Logout(HttpServletResponse response, HttpServletRequest request,
							final RedirectAttributes redirectAttributes) {
		
		request.getSession().removeAttribute("loggedInUser");
		request.getSession().invalidate();
		redirectAttributes.addFlashAttribute("message", "We hope to see you again as soon.");
		return "redirect:AllQuestions";
	}

	@PostMapping("/Search")
	public String searchQuestion(Model model, HttpServletRequest request) {

		String query = request.getParameter("theSearchName");

		if (query.equals("") || query.trim().length() <= 0) {

			model.addAttribute("info", suggestionMessageHelper.getNoResultMessage());
			model.addAttribute("suggestions", suggestionMessageHelper.getNoResultSuggestionList());
			model.addAttribute("questionCount", 0);

		} else {

			List<Question> questionList = communityService.searchQuestion(query);
			final Map<Users, String> userInfoMap = new HashMap<>();
			AtomicLong maxQC = new AtomicLong(0);

			questionList.forEach(question -> {
				Users users = communityService.getUserById(question.getUSERID());
				String base64Encoded = new String(Base64.encodeBase64(users.getPICTURE()));
				userInfoMap.put(users, base64Encoded);

				maxQC.incrementAndGet();
			});

			model.addAttribute("questionList", questionList);
			model.addAttribute("userMap", userInfoMap);
			model.addAttribute("questionCount", maxQC.get());
		}

		return "home-page";
	}


	@GetMapping("/ForgotPassword")
	public String forgotPassword(Model model) {
		model.addAttribute("user", new Users());
		return "send-email";
	}
	
	@PostMapping("/SendEmail")
	public String sendEmail(@ModelAttribute("user") Users users, final RedirectAttributes redirectAttrs) {
		
		if (users.getEMAIL() != null) {
			
			final Users theUser = communityService.getUserByEmail(users.getEMAIL());
			
			if (theUser != null) {
				//Generate an unique code and send to user.
				final UUID uuid = UUID.randomUUID();
				final LocalDateTime expirationDate = LocalDateTime.now().plusHours(6);
				//Save it in user profile in database.
				communityService.setUUIDofUser(theUser.getID(), uuid.toString(), String.valueOf(expirationDate));
				
				//Generate body etc. of email to send...
				final String subject = "Java Arabic Community Reset Password";
				final String messageBody = new PasswordResetMessage().getMessageBody(theUser.getNICKNAME(), uuid.toString(), theUser.getID());
				final String successMessage = "Thank you "+theUser.getNICKNAME()+", your email has been sent please check your mailbox.";
				
				sendEmail(SENDER_MAIL, theUser.getEMAIL(), subject, messageBody, successMessage, redirectAttrs);
				
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
		
		if(!model.containsAttribute("suggestion") && !model.containsAttribute("countriesOption")) {
			final Map<String, String> treeMap = new TreeMap<>(countryOptions);
			model.addAttribute("countriesOption", treeMap);
			model.addAttribute("suggestion", new Suggestion());
		}
		return "suggestion-page";
	}

	@PostMapping("/SendSuggest")
	public String sendSuggest(Model model, @ModelAttribute("suggestion") @Valid Suggestion suggestion,
			BindingResult bindingResult, RedirectAttributes redirectAttributes) {

		if(bindingResult.hasErrors()) {
			
			final Map<String, String> treeMap = new TreeMap<>(countryOptions);
			model.addAttribute("countriesOption", treeMap);
			model.addAttribute("suggestion", new Suggestion());
			model.addAttribute("org.springframework.validation.BindingResult.suggestion", bindingResult);
			return "suggestion-page";
		
		} else {
			
			final String messageBody = "<p>Sender : "+suggestion.getName()+"</p><p>Email : "+suggestion.getEmail()+"</p>"
                    + "<p>Country : "+suggestion.getCountry()+"</p><p>Category : "+suggestion.getCategory()+"</p><pre>"+suggestion.getMessage()+"</pre>";
			final String successMessage = "Thank you "+suggestion.getName()+", your "+suggestion.getCategory()+" has been sent successfully.";
			sendEmail(SENDER_MAIL, RECIEVER_MAIL, suggestion.getSubject(), messageBody, successMessage, redirectAttributes);
			return "redirect:AllQuestions";
		}
		
	}

	
	/* Custom methods */
	private void sendEmail(String from, String sendTo, String subject, final String messageBody,
			final String successMessage, RedirectAttributes redirectAttributes) {
		try {
			mailSender.send((MimeMessage mimeMessage)-> {
				MimeMessageHelper messageHelper = new MimeMessageHelper(mimeMessage, true, "UTF-8");
				messageHelper.setFrom(from);
				messageHelper.setTo(sendTo);
				messageHelper.setSubject(subject);
				messageHelper.setText(messageBody, true);
			});
			
			redirectAttributes.addFlashAttribute("message", successMessage);
			
		} catch (MailException e) {
			redirectAttributes.addFlashAttribute("error", e.getLocalizedMessage());
		}
	}

	private void uploadUserAttributesToSession(Optional<Users> theUser, HttpServletRequest request) {
		
		final List<UserMessages> userMessageList = communityService.fetchUserMessageList(theUser.get().getID());
		
		request.getSession().setAttribute("loggedInUserPicture", new String(Base64.encodeBase64(theUser.get().getPICTURE())));
		request.getSession().setAttribute("loggedInUserId", theUser.get().getID());
		request.getSession().setAttribute("loggedInUserNickname", theUser.get().getNICKNAME());
		request.getSession().setAttribute("loggedInUserRegDate", theUser.get().getREGISTERDATE().substring(0, 10));
		request.getSession().setAttribute("loggedInUserVote", theUser.get().getVOTE());
		request.getSession().setAttribute("loggedInUserMessages", userMessageList);
	}
	
	private void uploadUsersDetail(Model model, List<Question> questionsList) { 

            final Map<Users, String> userInfoMap = new HashMap<>();

            questionsList.forEach(question -> {
                final Users user = communityService.getUserById(question.getUSERID());
                final byte[] arr = Base64.encodeBase64(user.getPICTURE());
                final String base64Encoded = new String(arr);
                userInfoMap.put(user, base64Encoded);
            });

            model.addAttribute("userMap", userInfoMap);
        }
}

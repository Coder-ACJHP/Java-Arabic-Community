package com.community.web.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;
import java.util.UUID;

import javax.mail.internet.MimeMessage;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.apache.commons.codec.binary.Base64;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.community.web.entity.Answer;
import com.community.web.entity.Authorities;
import com.community.web.entity.Question;
import com.community.web.entity.UserComment;
import com.community.web.entity.Users;
import com.community.web.service.CommunityService;
import com.community.web.util.AccountConfirmationMessage;

@Controller
public class UserController {

	@Autowired
	private CommunityService communityService;

	@Autowired
	private ServletContext servletContext;

	@Autowired
	private JavaMailSender mailSender;

	@Value("#{countriesOption}")
	private Map<String, String> countryOptions;

	@Autowired
	private BCryptPasswordEncoder passwordEncoder;

	private final static String SENDER_MAIL = "java.arabic.community@gmail.com";

	@GetMapping("/Users")
	public String showUserCV(@RequestParam("answerUserId") int theId, Model model) {

		Users theUser = communityService.getUserById(theId);
		String base64Encoded = new String(Base64.encodeBase64(theUser.getPICTURE()));
		final Map<String, String> treeMap = new TreeMap<>(countryOptions);
		model.addAttribute("countriesOption", treeMap);
		model.addAttribute("userImage", base64Encoded);
		model.addAttribute("user", theUser);
		return "user-form";
	}

	@GetMapping("/UserCV")
	public String userCv(@RequestParam("privateId") int theId, Model model) {

		Users theUser = communityService.getUserById(theId);

		List<Question> questionList = communityService.getQuestionListByUserId(theId);
		List<Answer> answerList = null;
		for (Question q : questionList) {
			answerList = communityService.getAnswersList(q.getID());
		}

		final String base64Encoded = new String(Base64.encodeBase64(theUser.getPICTURE()));
		List<UserComment> ucommentsList = theUser.getUserComments();
		if (ucommentsList.isEmpty()) {
			ucommentsList.add(new UserComment("SYSTEM", "No comments yet"));
		}

		model.addAttribute("questionList", questionList);
		model.addAttribute("answerList", answerList);
		model.addAttribute("profilePicture", base64Encoded);
		model.addAttribute("ucommentsList", ucommentsList);
		model.addAttribute("userComment", new UserComment());
		model.addAttribute("users", theUser);
		return "user-cv";
	}

	@PostMapping("/AddUserComment")
	public String addUserComment(@ModelAttribute("userComment") UserComment comment, @RequestParam("userId") int theId) {

		final Users theUser = communityService.getUserById(theId);
		theUser.addComments(comment);
		communityService.saveUserComment(comment);
		return "redirect:UserCV?privateId=" + theUser.getID();
	}

	@PostMapping(value="UserMessageSetAsRead")
	public @ResponseBody String setMessageAsRead(Model model, @ModelAttribute("messageId") int messageId) {
		
		boolean status = communityService.setUserMessageAsReadById(messageId);
		if(status) {
			return "Success";
		} else {
			return "Fail";
		}
	}
	
	@GetMapping("SignUp")
	public String signUp(Model model) {

		if (!model.containsAttribute("user") && !model.containsAttribute("countriesOption")) {
			model.addAttribute("countriesOption", new TreeMap<>(countryOptions));
			model.addAttribute("user", new Users());
		}
		return "user-register";
	}

	@PostMapping("/RegisterUser")
	public String registerUser(Model model, @ModelAttribute("user") @Valid Users users, BindingResult bindingResult,
			@RequestParam("fileUpload") MultipartFile fileUpload, HttpServletRequest request,
			RedirectAttributes redirectAttrs) throws IOException {

		String sendTo = "";

		if (bindingResult.hasErrors()) {

			model.addAttribute("countriesOption", new TreeMap<>(countryOptions));
			model.addAttribute("user", new Users());
			model.addAttribute("org.springframework.validation.BindingResult.user", bindingResult);
			return "user-register";

		} else {

			if (communityService.getUserByEmail(users.getEMAIL()) != null) {
				model.addAttribute("error", "There is an account with that email adress.\nPlease login with your email.");
				return "user-register";

			} else {

				// if user doesn't upload profile picture
				if (fileUpload.isEmpty()) {

					File theFile = new File(servletContext.getRealPath("/resources/images/nouser.jpg"));
					users.setPICTURE(Files.readAllBytes(theFile.toPath()));

				} else {
					users.setPICTURE(fileUpload.getBytes());
				}

				// Generate an unique code and send to user.
				final UUID uuid = UUID.randomUUID();
				final LocalDateTime expirationDate = LocalDateTime.now().plusHours(6);

				users.setPASSWORD(passwordEncoder.encode(users.getPASSWORD()));
				users.setAuthority(new Authorities("ROLE_USER", false));
				users.setUUID(uuid.toString());
				users.setUUIDEXPDATE(String.valueOf(expirationDate));
				communityService.saveUser(users);

				sendConfirmationEmail(users.getEMAIL(), users.getID(), uuid.toString());

				redirectAttrs.addFlashAttribute("success", "Thank you for signing up with J.A.C. To "
						+ "complete your registration you must confirm the email we sent to you.");
				sendTo = "redirect:SignIn";
			}
		}

		return sendTo;
	}

	@GetMapping("/RegistrationConfirm")
	public String confirmRegistration(Model model, @RequestParam("UserId") int userId,
			@RequestParam("Token") String UUIDkey, RedirectAttributes redirectAttributes) {

		final Users activationUser = communityService.getUserById(userId);

		if (activationUser == null) {
			model.addAttribute("headerError", "404");
			model.addAttribute("error", "Bad credentials or invalid token !");
			return "error-page";

		} else {

			LocalDateTime expireDate = stringToLocalDateTime(activationUser.getUUIDEXPDATE());

			
			if(expireDate == null || activationUser.getUUID() == null) {
				redirectAttributes.addFlashAttribute("error", "Are you sure to you already registered?");
				return "redirect:SignUp";
			} else {
				
				/** Now we have to compare the parameters are equals ? */
				if (UUIDkey.equals(activationUser.getUUID()) && LocalDateTime.now().isBefore(expireDate)) {

					activationUser.setUUID(null);
					activationUser.setUUIDEXPDATE(null);
					activationUser.setAuthority(new Authorities("ROLE_USER", true));
					communityService.updateUser(activationUser);

					redirectAttributes.addFlashAttribute("success",
							"Your account activated successfully.\nYou can log in right now.");
					return "redirect:SignIn";

				} else {
					redirectAttributes.addFlashAttribute("error", "Bad credentials or token has been expired!.");
					return "redirect:SignUp";
				}
			}
			
		}

	}

	@PostMapping("/UpdateUser")
	public String saveUser(@ModelAttribute("user") Users users, @RequestParam("fileUpload") MultipartFile fileUpload,
			HttpServletRequest request, RedirectAttributes redirectAttrs) throws Exception {

		Users oldUser = communityService.getUserById(users.getID());

		if (!fileUpload.isEmpty()) {
			oldUser.setPICTURE(fileUpload.getBytes());
		}

		communityService.updateUser(oldUser);
		redirectAttrs.addFlashAttribute("message", "Your profile updated successfully.");
		return "redirect:" + request.getParameter("from");

	}

	// Update password from user form
	@PostMapping("/UpdatePwdForm")
	public String updatePasswordFromUserForm(@RequestParam("newPsw") String newPsw,
			@RequestParam("confirmPsw") String confirmPsw, HttpSession httpSession, RedirectAttributes redirectAtt) {

		// fetch logged in user id form session
		int currentUserId = (int) httpSession.getAttribute("loggedInUserId");
		final Users resetUser = communityService.getUserById(currentUserId);

		// Check those two passwords are equals
		if (newPsw.equals(confirmPsw)) {

			resetUser.setPASSWORD(passwordEncoder.encode(newPsw));
			communityService.updateUser(resetUser);
			redirectAtt.addFlashAttribute("message", "Your password changed successfully.");
		} else {

			redirectAtt.addFlashAttribute("error", "Passwords are doesn't match!");
		}

		return "redirect:Users?answerUserId=" + currentUserId;
	}

	@GetMapping("/Resetpassword")
	public String resetPassword(Model model, @RequestParam("userId") int theId) {
		final Users usr = communityService.getUserById(theId);
		model.addAttribute("user", usr);
		return "renew-password";
	}

	@PostMapping("/UpdatePwdWithUdid")
	public String updatePasswordWithUdid(@ModelAttribute("user") Users theUser, @RequestParam("newPsw") String newPsw,
			@RequestParam("confirmPsw") String confirmPsw, @RequestParam("UUID") String UUIDkey,
			RedirectAttributes redirectAtt) {

		// fetch the user for updating...
		final Users resetUser = communityService.getUserById(theUser.getID());
		final LocalDateTime expireDate = stringToLocalDateTime(resetUser.getUUIDEXPDATE());

		// check the unique key is equals and it's not expired.
		if (UUIDkey.equals(resetUser.getUUID()) && LocalDateTime.now().isBefore(expireDate)) {

			// Check those two passwords are equals
			if (newPsw.equals(confirmPsw)) {
				// Remove the token from database for blocking second use.
				resetUser.setUUID(null);
				resetUser.setUUIDEXPDATE(null);
				resetUser.setPASSWORD(passwordEncoder.encode(newPsw));
				communityService.updateUser(resetUser);

				redirectAtt.addFlashAttribute("success", "Your password changed successfully.");
				return "redirect:SignIn";

			} else {
				redirectAtt.addFlashAttribute("error", "Passwords are doesn't match!");
			}

		} else {
			redirectAtt.addFlashAttribute("error", "Invalid or expired unique key!");
		}

		return "redirect:Resetpassword?userId=" + theUser.getID();
	}

	@PostMapping("/SearchUser")
	public String searchUser(@RequestParam("theSearchUser") String searchName, Model model) {
		final List<Users> allUsersList = communityService.searchUser(searchName);
		final List<String> pictureList = new ArrayList<>();

		allUsersList.stream().map((users) -> Base64.encodeBase64(users.getPICTURE()))
				.map((encodeBase64) -> new String(encodeBase64)).forEachOrdered((base64Encoded) -> {
					pictureList.add(base64Encoded);
				});

		model.addAttribute("pictureList", pictureList);
		model.addAttribute("userList", allUsersList);
		return "users-list";
	}

	@GetMapping("/Users-list")
	public String usersList(Model model) {
		final List<Users> allUsersList = communityService.getUserList();
		final List<String> pictureList = new ArrayList<>();

		allUsersList.stream().map((users) -> Base64.encodeBase64(users.getPICTURE()))
				.map((encodeBase64) -> new String(encodeBase64)).forEachOrdered((base64Encoded) -> {
					pictureList.add(base64Encoded);
				});
		model.addAttribute("pictureList", pictureList);
		model.addAttribute("userList", allUsersList);
		return "users-list";
	}

	@GetMapping("DeleteAccount")
	public String deleteAccout(@RequestParam("ID") int theId, Model model, RedirectAttributes redirectAttributes) {

		final List<Question> questionsList = communityService.getQuestionListByUserId(theId);
		questionsList.stream().map((q) -> {
			communityService.changeQuestionAsGuess(q.getID());
			return q;
		}).map((q) -> communityService.getAnswersList(q.getID())).forEachOrdered((al) -> {
			al.forEach((a) -> {
				communityService.changeAnswerAsGuess(a.getID());
			});
		});
		communityService.deleteUser(theId);
		redirectAttributes.addFlashAttribute("message", "Your account is deleted so after this you are anonymous!");
		return "redirect:Logout";
	}

	@GetMapping("/ResumeBuilder")
	public String sendToResumeBuilder() {
		return "resume-builder";
	}
	
	private void sendConfirmationEmail(String email, int userId, String token) {

		String messageBody = new AccountConfirmationMessage().getMessageBody(userId, token);
		mailSender.send((MimeMessage mimeMessage) -> {
			MimeMessageHelper messageHelper = new MimeMessageHelper(mimeMessage, true, "UTF-8");
			messageHelper.setFrom(SENDER_MAIL);
			messageHelper.setTo(email);
			messageHelper.setSubject("Account activation");
			messageHelper.setText(messageBody, true);
		});

	}

	private LocalDateTime stringToLocalDateTime(String date) {
		
		final DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.S");
		return LocalDateTime.parse(date, formatter);
	}
}

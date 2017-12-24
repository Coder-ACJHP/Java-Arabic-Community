package com.community.web.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.codec.binary.Base64;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.community.web.entity.Answer;
import com.community.web.entity.Question;
import com.community.web.entity.Ucomment;
import com.community.web.entity.Users;
import com.community.web.service.CommunityService;
import com.community.web.util.VerifyRecaptcha;

@Controller
public class UserController {

	@Autowired
	private CommunityService communityService;

	@Autowired
	private ServletContext servletContext;

	@Value("#{countriesOption}")
	private Map<String, String> countryOptions;

	@GetMapping("/Users")
	public String showUserCV(@RequestParam("answerUserId") int theId, Model model) {
		
		final Users theUser = communityService.getUserById(theId);
		byte[] encodeBase64 = Base64.encodeBase64(theUser.getPICTURE());
		String base64Encoded = new String(encodeBase64);
		theUser.setPASSWORD(""); //reset the password because is already encoded and force the user write it again
		final Map<String, String> treeMap = new TreeMap<>(countryOptions);
		model.addAttribute("countriesOption", treeMap);
		model.addAttribute("userImage", base64Encoded);
		model.addAttribute("user", theUser);
		return "user-form";
	}

	@GetMapping("/UserCV")
	public String userCv(@RequestParam("privateId") int theId, Model model) {
		final Users users = communityService.getUserById(theId);
		final List<Question> questionList = communityService.getQuestionListByUserId(theId);

		byte[] encodeBase64 = Base64.encodeBase64(users.getPICTURE());
		final String base64Encoded = new String(encodeBase64);
		final Ucomment ucomment = new Ucomment();
		
		final List<Ucomment> ucommentsList = communityService.getAllCommentsById(theId);
		
		model.addAttribute("questionList", questionList);
		model.addAttribute("profilePicture", base64Encoded);
		model.addAttribute("ucommentsList", ucommentsList);
		model.addAttribute("userComment", ucomment);
		model.addAttribute("users", users);
		return "user-cv";
	}

	@PostMapping("/AddUserComment")
	public String addUserComment(@ModelAttribute("userComment") Ucomment ucomment) {
		communityService.saveUserComment(ucomment);
		return "redirect:UserCV?privateId="+ucomment.getUSERID();
	}
	
	@PostMapping("/RegisterUser")
	public String registerUser(@ModelAttribute("user") Users users, @RequestParam("fileUpload") MultipartFile fileUpload,
			@RequestParam("g-recaptcha-response") String gRecaptchaResponse, HttpServletRequest request,
			final RedirectAttributes redirectAttrs) throws Exception {
				
		String sendTo = "";
		final String ErrorMessage = "There is an account with that email adress: ";
		
		if(communityService.getUserByEmail(users.getEMAIL()) != null) {
			
			redirectAttrs.addFlashAttribute("error", ErrorMessage + users.getEMAIL());
			sendTo = "redirect:SignUp";
			
		}else {
			
			boolean verify = VerifyRecaptcha.verify(gRecaptchaResponse);

			if(verify) {
				if (fileUpload.isEmpty()) {
					
					File theFile = new File(servletContext.getRealPath("/resources/images/nouser.jpg"));
					byte[] array = Files.readAllBytes(theFile.toPath());
					users.setPICTURE(array);
					
				} else {users.setPICTURE(fileUpload.getBytes());}
				
				users.setENABLED(true);
                users.setREGISTERDATE(LocalDateTime.now().toString());
				communityService.saveUser(users);      
				redirectAttrs.addFlashAttribute("success", "Your registration has been completed successfully");
				redirectAttrs.addFlashAttribute("email", users.getEMAIL());
				sendTo = "redirect:SignIn";
				
			}else {
				
				redirectAttrs.addFlashAttribute("error", "You missed the Captcha!, It must be used or maybe It returned false!");
				sendTo = "redirect:SignUp";
			}
		}
		return sendTo;
	}
	
	@PostMapping("/UpdateUser")
	public String saveUser(@ModelAttribute("user") Users users, @RequestParam("fileUpload") MultipartFile fileUpload,
			@RequestParam("g-recaptcha-response") String gRecaptchaResponse, HttpServletRequest request,
			RedirectAttributes redirectAttrs) throws Exception {

		
		boolean verify = VerifyRecaptcha.verify(gRecaptchaResponse);

		if (verify) {
			if (fileUpload.isEmpty()) {
				final File theFile = new File(servletContext.getRealPath("/resources/images/nouser.jpg"));
				byte[] array = Files.readAllBytes(theFile.toPath());
				users.setPICTURE(array);
				
			} else {users.setPICTURE(fileUpload.getBytes());}

			communityService.saveUser(users);
			redirectAttrs.addFlashAttribute("message", "Your profile updated successfully.");
			return "redirect:" + request.getParameter("from");
		}

		redirectAttrs.addFlashAttribute("message", "You missed the Captcha!, It must be used!");
		return "redirect:Users?answerUserId="+users.getID();

	}

	@PostMapping("/UpdatePassword")
	public String updatePassword(@ModelAttribute("user") Users theUser, @RequestParam("newPsw") String newPsw,
			@RequestParam("confirmPsw") String confirmPsw, @RequestParam("UUID") String UUIDkey, RedirectAttributes redirectAtt) {
		
		String sendTo = "";
		
		if (theUser != null) {
			Users usr = communityService.getUserById(theUser.getID());
			
			if (UUIDkey.equalsIgnoreCase(usr.getUUID())) {
				if (newPsw.equals(confirmPsw)) {

					communityService.updateUserPassword(usr.getID(), newPsw);
					redirectAtt.addFlashAttribute("success", "Your password changed successfully.");
					sendTo = "redirect:AllQuestions";
				}else {
					redirectAtt.addFlashAttribute("error", "Passwords are doesn't match!");
					sendTo = "redirect:Resetpassword?userId="+theUser.getID();
				}
			}else {
				redirectAtt.addFlashAttribute("error", "Invalid or expired unique key");
				sendTo = "redirect:Resetpassword?userId="+theUser.getID();
			}
		}
		return sendTo;
	}

	@GetMapping("/Resetpassword")
	public String resetPassword(Model model, @RequestParam("userId") int theId) {
		Users usr = communityService.getUserById(theId);
		model.addAttribute("user", usr);
		return "renew-password";
	}
	
	@PostMapping("/SearchUser")
	public String searchUser(@RequestParam("theSearchUser") String searchName, Model model) {
		final List<Users> allUsersList = communityService.searchUser(searchName);
		final List<String> pictureList = new ArrayList<>();

		for (Users users : allUsersList) {
			byte[] encodeBase64 = Base64.encodeBase64(users.getPICTURE());
			String base64Encoded = new String(encodeBase64);
			pictureList.add(base64Encoded);
		}

		model.addAttribute("pictureList", pictureList);
		model.addAttribute("userList", allUsersList);
		return "users-list";
	}

	@GetMapping("/Users-list")
	public String usersList(Model model) {
		final List<Users> allUsersList = communityService.getUserList();
		final List<String> pictureList = new ArrayList<>();

		for (Users users : allUsersList) {
			byte[] encodeBase64 = Base64.encodeBase64(users.getPICTURE());
			String base64Encoded = new String(encodeBase64);
			pictureList.add(base64Encoded);
		}
		model.addAttribute("pictureList", pictureList);
		model.addAttribute("userList", allUsersList);
		return "users-list";
	}

	@GetMapping("DeleteAccount")
	public String deleteAccout(@RequestParam("ID") int theId, Model model, 
							RedirectAttributes redirectAttributes) throws IOException {
		
		final List<Question> ql = communityService.getQuestionListByUserId(theId);
		for(Question q:ql) {
			communityService.changeQuestionAsGuess(q.getID());
			List<Answer> al = communityService.getAnswersList(q.getID());
			for(Answer a: al) {
				communityService.changeAnswerAsGuess(a.getID());
			}
		}
		communityService.deleteUser(theId);
		redirectAttributes.addFlashAttribute("message", "Your account is deleted so after this you are anonymous!");
		return "redirect:j_spring_security_logout";
	}
}

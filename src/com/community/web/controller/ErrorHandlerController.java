package com.community.web.controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ErrorHandlerController {
	
	@ExceptionHandler({SQLException.class, DataAccessException.class})
	public void databaseErrorsHandler(Model model, 
			HttpServletRequest request, HttpServletResponse response) throws IOException {
				
		model.addAttribute("headerError", "SQL or DataAccess Exception");
		model.addAttribute("error", "An unexpected error has occurred, please try again.");
		
		
		//Send user to same page with error message.
		response.sendRedirect(request.getHeader("Referer"));
	}
	
	@GetMapping("/400")
	public String error400(Model model) {
		model.addAttribute("headerError", "400");
		model.addAttribute("error", "I guess I could not figure out what you mean :)");
		return "error-page";
	}
	
	@GetMapping("/404")
	public String error404(Model model) {
		model.addAttribute("headerError", "404");
		model.addAttribute("error", "The requested URL was not found on J.A.C's server.");
		return "error-page";
	}
	
	@GetMapping("/405")
	public String error405(Model model) {
		model.addAttribute("headerError", "405");
		model.addAttribute("error", "The request method is not supported!");
		return "error-page";
	}
	
	@GetMapping("/500")
	public String error500(Model model) {
		model.addAttribute("headerError", "500");
		model.addAttribute("error", "It's my foult :(\nThe server encountered an internal error or misconfiguration"
				+ " and was unable to complete your request.Please contact the server administrator, "
				+ "you{at}your.address and inform them of the time the error occurred, and anything "
				+ "you might have done that may have caused the error.");
		return "error-page";
	}
	
	@GetMapping("/error")
	public String error(Model model) {
		model.addAttribute("headerError", "Error");
		model.addAttribute("error", "Unknown error!.");
		return "error-page";
	}
}

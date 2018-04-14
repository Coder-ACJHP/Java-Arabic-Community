package com.community.web.util;

import java.util.Arrays;
import java.util.List;


public final class SuggestionMessage {
	
	private final String noResultMessage = "Your search returned no matches.";
	private final String noQuestionMessage = "There is no question(s)";
	
	private final List<String> noResultSuggestionList = Arrays.asList("Try fewer keywords.", "Try different keywords.", "Try more general keywords.");
	private final List<String> noQuestionSuggestionList = Arrays.asList("Try to ask a new question", "Maybe encountered error?! Try to refresh the page.");
	
	public SuggestionMessage() {}
	
	public String getNoResultMessage() {
		return noResultMessage;
	}
	public String getNoQuestionMessage() {
		return noQuestionMessage;
	}
	public List<String> getNoResultSuggestionList() {
		return noResultSuggestionList;
	}
	public List<String> getNoQuestionSuggestionList() {
		return noQuestionSuggestionList;
	}

	
}

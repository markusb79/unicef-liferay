package com.rhizome.util;

import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Component;

@Component
public class MessageUtil {
	
	private static MessageSource messageSource;	
	@Autowired
	MessageUtil(MessageSource messageSource) {
		MessageUtil.messageSource = messageSource;
	}
	
	public static String get(String key,String val,Locale locale){
		
		return messageSource.getMessage(key, null, val,locale);
	}
}

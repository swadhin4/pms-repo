package com.web.service;

import org.springframework.mail.MailException;

import com.app.mail.EmailTemplate;
import com.web.util.RestResponse;

public interface EmailService {


	public void sendEmail(EmailTemplate emailTemplate) throws MailException;
	public RestResponse sendEmail(String to, String message) throws Exception;


}

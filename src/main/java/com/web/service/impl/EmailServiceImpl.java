package com.web.service.impl;

import java.io.IOException;
import java.util.Date;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.mail.Message;
import javax.mail.Multipart;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.util.ByteArrayDataSource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.mail.MailException;
import org.springframework.stereotype.Service;

import com.app.mail.EmailTemplate;
import com.web.service.EmailService;
import com.web.util.RestResponse;

@Service("emailService")
public class EmailServiceImpl implements EmailService {

	private static Logger logger = LoggerFactory.getLogger(EmailServiceImpl.class);


	// Supply your SMTP credentials below. Note that your SMTP credentials are different from your AWS credentials.
	static final String SMTP_USERNAME = "AKIAJTMTMZPEPLFHEV5A";  // Replace with your SMTP username.
	static final String SMTP_PASSWORD = "Attc9Ity8FHmBtxSBBgkj7VzLbz5u3Y1HMtqxvLVHg6v";  // Replace with your SMTP password.

	// Amazon SES SMTP host name. This example uses the US West (Oregon) Region.
	static final String HOST = "email-smtp.us-west-2.amazonaws.com";

	@Override
	public void sendEmail(final EmailTemplate emailTemplate) throws MailException { 

	}

	@Override
	public RestResponse sendEmail(final String to, final String message)
			throws Exception {
		// Create a Properties object to contain connection configuration information.
		final RestResponse response = new RestResponse();
		Properties props = System.getProperties();
		props.put("mail.transport.protocol", "smtps");
		props.put("mail.smtp.port", 25); 

		// Set properties indicating that we want to use STARTTLS to encrypt the connection.
		// The SMTP session will begin on an unencrypted connection, and then the client
		// will issue a STARTTLS command to upgrade to an encrypted connection.
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.starttls.required", "true");

		// Create a Session object to represent a mail session with the specified properties. 
		Session session = Session.getDefaultInstance(props);


		// Create a message with the specified information. 
		final MimeMessage mimeMessage = new MimeMessage(session);
		String toMailIds =to;
		String ccMailIds="swadhin4@gmail.com,malay18@gmail.com,ranjankiitbbsr@gmail.com";
		mimeMessage.setFrom(new InternetAddress("swadhin4@gmail.com"));
		mimeMessage.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toMailIds ));
		mimeMessage.setRecipients(Message.RecipientType.CC, InternetAddress.parse(ccMailIds ));
		mimeMessage.setSubject("PMS, IT-SUPPORT:Thanks for registration","utf-8");

		// Create a transport.        
		Transport transport = session.getTransport();

		// Send the message.
		try
		{
			System.out.println("Attempting to send an email through the Amazon SES SMTP interface...");
			StringBuilder messageContent = new StringBuilder();
			messageContent.append("<table width='90%' border='0' cellspacing='0' cellpadding='0'>");
			messageContent.append("<tr><td align='center'>");
			messageContent.append("<div style='height: 60px; line-height: 60px; font-size: 10px;'> </div>");
			messageContent.append("<div style='line-height: 44px;'>");
			messageContent.append("<font face='Arial, Helvetica, sans-serif' size='5' color='#57697e' style='font-size: 34px;'>");
			messageContent.append("<span style='font-family: Arial, Helvetica, sans-serif; font-size: 34px; color: #57697e;'>");
			messageContent.append("Email Service from PMS App");
			messageContent.append("</span></font>");
			messageContent.append("</div><div style='height: 40px; line-height: 40px; font-size: 10px;'> </div>");
			messageContent.append("</td></tr><tr><td align='center'>");
			messageContent.append("<div style='line-height: 24px;'>");
			messageContent.append("<font face='Arial, Helvetica, sans-serif' size='4' color='#57697e' style='font-size: 15px;'>");
			messageContent.append("<span style='font-family: Arial, Helvetica, sans-serif; font-size: 15px; color: #57697e;'>");
			messageContent.append(message);
			messageContent.append("</span></font></div>");
			messageContent.append("<div style='height: 40px; line-height: 40px; font-size: 10px;'> </div>");
			messageContent.append("</td></tr><tr><td align='center'>");
			messageContent.append("<div style='line-height: 24px;'>");
			messageContent.append("<a href='#' target='_blank' style='color: #596167; font-family: Arial, Helvetica, sans-serif; font-size: 13px;'>");
			messageContent.append("<font face='Arial, Helvetica, sans-seri; font-size: 13px;' size='3' color='#596167'></font></a>");
			messageContent.append("</div><div style='height: 60px; line-height: 60px; font-size: 10px;'> </div>");
			messageContent.append("</td></tr></table>");

			MimeBodyPart mbp1 = new MimeBodyPart();
			try {
				mbp1.setDataHandler(new DataHandler(
						new ByteArrayDataSource(message.toString(), "text/html")));
			} catch (IOException e1) {
				e1.printStackTrace();
			}
			mbp1.setHeader("Content-Type","text/plain; charset=\"utf-8\""); 
			mbp1.setContent( messageContent.toString(), "text/html; charset=utf-8" ); 
			mbp1.setHeader("Content-Transfer-Encoding", "quoted-printable");

			// create the second message part
			/*MimeBodyPart mbp2 = new MimeBodyPart();

			// attach the file to the message
			try {
			mbp2.attachFile(fileName);
			    } catch (IOException e) {
			   e.printStackTrace();
			}*/

			Multipart mp = new MimeMultipart();
			mp.addBodyPart(mbp1);
			//mp.addBodyPart(mbp2);
			mimeMessage.setContent(mp, "text/html");

			// Connect to Amazon SES using the SMTP username and password you specified above.
			if (!transport.isConnected()){//make sure the connection is alive
				transport.connect(HOST, SMTP_USERNAME, SMTP_PASSWORD);
			}

			// Send the email.O
			mimeMessage.setSentDate(new Date());
			// Send the email.
			transport.sendMessage(mimeMessage, mimeMessage.getAllRecipients());
			System.out.println("Email sent!");
			response.setStatusCode(200);
		}
		catch (Exception ex) {
			response.setStatusCode(500);
			logger.error("The email was not sent.", ex);
		}
		finally
		{
			// Close and terminate the connection.
			transport.close();        	
		}
		return response;
	}

	/** The mail sender. *//*
	@Autowired
	private  JavaMailSender mailSender;

	@Value(value = "classpath:mailTemplate.html")
	private Resource mailTemplate;

	@Override
	public void sendEmail(final EmailTemplate emailTemplate) throws MailException {
		// TODO Auto-generated method stub

	}

	@Override
	@Async
	public RestResponse sendEmail(final String from, final String message1) throws MailException {
		final RestResponse response = new RestResponse();
		mailSender.send(new MimeMessagePreparator() {
			@Override
			public void prepare(final MimeMessage mimeMessage) throws MessagingException {

				Properties props = System.getProperties();
				props.put("mail.transport.protocol", "smtps");
				props.put("mail.smtp.port",25); 

				// Set properties indicating that we want to use STARTTLS to encrypt the connection.
				// The SMTP session will begin on an unencrypted connection, and then the client
				// will issue a STARTTLS command to upgrade to an encrypted connection.
				props.put("mail.smtp.auth", "true");
				props.put("mail.smtp.starttls.enable", "true");
				props.put("mail.smtp.starttls.required", "true");
				Session session = Session.getDefaultInstance(props);

				MimeMessageHelper message = new MimeMessageHelper(mimeMessage, true, "text/html;charset=UTF-8");
				message.setFrom(from);
				//message.setTo("malay18@gmail.com,swadhin4@gmail.com,shibasishmohanty@gmail.com,ranjankiitbbsr@gmail.com");
				String toMailIds ="malay18@gmail.com,shibasishmohanty@gmail.com,ranjankiitbbsr@gmail.com";
				String ccMailIds="swadhin4@gmail.com";
				mimeMessage.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toMailIds ));
				mimeMessage.setRecipients(Message.RecipientType.CC, InternetAddress.parse(ccMailIds ));
				message.setSubject("AWS - EMAIL SERVICE :Thanks for registration");

			        helper.setTo(to);
			        helper.setText("How are you?");
			        helper.setSubject("Hi");

			        ClassPathResource file = new ClassPathResource("cat.jpg");
			        helper.addAttachment("cat.jpg", file);


					String s1=null;
				MimeMultipart rootMixedMultipart = new MimeMultipart("mixed");
				mimeMessage.setContent(rootMixedMultipart);

				MimeMultipart nestedRelatedMultipart = new MimeMultipart("related");
				MimeBodyPart relatedBodyPart = new MimeBodyPart();
				relatedBodyPart.setContent(nestedRelatedMultipart);
				rootMixedMultipart.addBodyPart(relatedBodyPart);

				MimeMultipart messageBody = new MimeMultipart("alternative");
				MimeBodyPart bodyPart = null;
				for (int i = 0; i < nestedRelatedMultipart.getCount(); i++) {
					BodyPart bp = nestedRelatedMultipart.getBodyPart(i);
					if (bp.getFileName() == null) {
						bodyPart = (MimeBodyPart) bp;
					}
				}
				if (bodyPart == null) {
					MimeBodyPart mimeBodyPart = new MimeBodyPart();
					nestedRelatedMultipart.addBodyPart(mimeBodyPart);
					bodyPart = mimeBodyPart;
				}
				bodyPart.setContent(messageBody, "text/alternative");
				try {
					//s1 = IOUtils.toString(classLoader.getResourceAsStream("template/subscription-reply.html"));
					//s1 = IOUtils.toString(mailTemplate.getInputStream());
					StringBuilder messageContent = new StringBuilder();
					messageContent.append("<table width='90%' border='0' cellspacing='0' cellpadding='0'>");
					messageContent.append("<tr><td align='center'>");
					messageContent.append("<div style='height: 60px; line-height: 60px; font-size: 10px;'> </div>");
					messageContent.append("<div style='line-height: 44px;'>");
					messageContent.append("<font face='Arial, Helvetica, sans-serif' size='5' color='#57697e' style='font-size: 34px;'>");
					messageContent.append("<span style='font-family: Arial, Helvetica, sans-serif; font-size: 34px; color: #57697e;'>");
					messageContent.append("Email Service from PMS App");
					messageContent.append("</span></font>");
					messageContent.append("</div><div style='height: 40px; line-height: 40px; font-size: 10px;'> </div>");
					messageContent.append("</td></tr><tr><td align='center'>");
					messageContent.append("<div style='line-height: 24px;'>");
					messageContent.append("<font face='Arial, Helvetica, sans-serif' size='4' color='#57697e' style='font-size: 15px;'>");
					messageContent.append("<span style='font-family: Arial, Helvetica, sans-serif; font-size: 15px; color: #57697e;'>");
					messageContent.append(message1);
					messageContent.append("</span></font></div>");
					messageContent.append("<div style='height: 40px; line-height: 40px; font-size: 10px;'> </div>");
					messageContent.append("</td></tr><tr><td align='center'>");
					messageContent.append("<div style='line-height: 24px;'>");
					messageContent.append("<a href='#' target='_blank' style='color: #596167; font-family: Arial, Helvetica, sans-serif; font-size: 13px;'>");
					messageContent.append("<font face='Arial, Helvetica, sans-seri; font-size: 13px;' size='3' color='#596167'></font></a>");
					//messageContent.append("<img src='http://artloglab.com/metromail/images/trial.gif' width='193' height='43' alt='30-DAYS FREE TRIAL border='0' style='display: block;' />");
					messageContent.append("</div><div style='height: 60px; line-height: 60px; font-size: 10px;'> </div>");
					messageContent.append("</td></tr></table>");

					MimeBodyPart htmlTextPart = new MimeBodyPart();
					htmlTextPart.setContent(messageContent.toString(),"text/html;charset=UTF-8");
					messageBody.addBodyPart(htmlTextPart);
					Transport transport = session.getTransport();

					System.out.println("Attempting to send an email through the Amazon SES SMTP interface...");

					// Connect to Amazon SES using the SMTP username and password you specified above.
					transport.connect(props.getProperty("spring.mail.host"), props.getProperty("spring.mail.username"), props.getProperty("spring.mail.password"));
					mimeMessage.setSentDate(new Date());
					mimeMessage.setText(messageContent.toString(),"text/html;charset=UTF-8");
					// Send the email.
					transport.sendMessage(mimeMessage, mimeMessage.getAllRecipients());
					System.out.println("Email sent!");

					response.setStatusCode(200);
					response.setMessage("Email sent successfully");

				} catch (Exception e) {
					e.printStackTrace();
					response.setStatusCode(500);
					response.setMessage("Exception while sending email");
				}


			}
		});

		return response;
	}
	 */

}

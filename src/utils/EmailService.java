package utils;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import models.UserProfile;

public class EmailService {
	
	public static void main(String[] args) {
		sendActivationEmail(new UserProfile());
	}

	/**
	 * Sends user an activation link to their email
	 * 
	 * our project gmail account
	 * email address: unswbook@gmail.com
	 * password: unswbookpassword
	 */
	public static void sendActivationEmail(UserProfile profile){
		Properties props = new Properties();
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.port", "587");

		Session session = Session.getInstance(props,
		  new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication("unswbook@gmail.com", "unswbookpassword");
			}
		  });

		try {

			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress("unswbook@gmail.com"));
			message.setRecipients(Message.RecipientType.TO,
				InternetAddress.parse("soprogopro97@gmail.com"));
			message.setSubject("Account Activation");
			message.setText("Please Activate your account by clicking the link below: \nlocalhost:8080/COMP9321-ass2/API?userId=" + 9);

			Transport.send(message);

			System.out.println("Done");

		} catch (MessagingException e) {
			throw new RuntimeException(e);
		}
	}
}

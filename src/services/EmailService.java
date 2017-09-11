package services;

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
	
	private static Session session;
	
	/**
	 * Sends user an activation link to their email
	 * 
	 * our project gmail account
	 * email address: unswbook@gmail.com
	 * password: unswbookpassword
	 */
	public static void sendActivationEmail(UserProfile profile){
		init();
		try {
			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress("unswbook@gmail.com"));
			message.setRecipients(Message.RecipientType.TO,
				InternetAddress.parse(profile.getEmail()));
			message.setSubject("Account Activation");
			message.setText("Please Activate your account by clicking the link below: \nlocalhost:8080/COMP9321-ass2/API?action=activateAccount&userId=" + profile.getId());

			Transport.send(message);

			System.out.println("Done");

		} catch (MessagingException e) {
			throw new RuntimeException(e);
		}
	}
	
	public static void sendFriendRequest(UserProfile fromUser, UserProfile toUser){
		init();
		try {
			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress("unswbook@gmail.com"));
			message.setRecipients(Message.RecipientType.TO,
				InternetAddress.parse(toUser.getEmail()));
			message.setSubject("Account Activation");
			message.setText("Hi there! You have a friend request from " + fromUser.getFirstname() + " " + fromUser.getLastname() 
			+ "\n Accept their friend request by clicking this link!\n localhost:8080/COMP9321-ass2/API?action=acceptFriendRequest&fromUser=" + fromUser.getId() + "&toUser=" + toUser.getId());

			Transport.send(message);

			System.out.println("Done");

		} catch (MessagingException e) {
			throw new RuntimeException(e);
		}
	}
	private static void init(){
		Properties props = new Properties();
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.port", "587");

		session = Session.getInstance(props,
		  new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication("unswbook@gmail.com", "unswbookpassword");
			}
		  });
	}
	
}

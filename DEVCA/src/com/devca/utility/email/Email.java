package com.devca.utility.email;

import java.io.UnsupportedEncodingException;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeUtility;

public class Email {
	public static void sendEmail(String email, String authNum) {
		String host = "smtp.gmail.com";
		String subject = "DEVCA 인증번호 전달";
		String fromName = "DEVCA 관리자";
		String from = "ancsbbc@gmail.com";
		String to1 = email;
		
		String content = "<div style='background-color: black; color: white;'>인증번호 [" + authNum + "]</div>";
		
		Properties props = new Properties();
		
		// G-Mail SMTP 사용시
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.transport", "smtp");
		props.put("mail.smtp.host", host);
		props.setProperty("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		props.put("mail.smtp.port", "465");
		props.put("mail.smtp.user", from);
		props.put("mail.smtp.auth", "true");
		
		Session mailSession = Session.getInstance(props, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication("ancsbbc@gmail.com", "tjamnjikpaapdwpu");
			}
		});
		
		Message msg = new MimeMessage(mailSession);
		try {
			msg.setFrom(new InternetAddress(from, MimeUtility.encodeText(fromName, "UTF-8", "B")));
			
			InternetAddress[] address1 = {new InternetAddress(to1)};
			msg.setRecipients(Message.RecipientType.TO, address1);
			msg.setSubject(subject);
			msg.setSentDate(new java.util.Date());
			msg.setContent(content, "text/html; charset=utf-8");
			
			
			Transport.send(msg);
		} catch (UnsupportedEncodingException | MessagingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	public static void sendPwEmail(String email, String member_name) {
		String host = "smtp.gmail.com";
		String subject = "DEVCA 비밀번호 재설정 안내";
		String fromName = "DEVCA 관리자";
		String from = "ancsbbc@gmail.com";
		String to1 = email;
		
		String content = "<div>"
				+ "<h1>DEVCA</h1>"
				+ "<h2>비밀번호 재설정 안내</h2>"
				+ "<p>안녕하세요 " + member_name + "님</p>"
				+ "<p>본 메일은 비밀번호 재설정을 위해 DEVCA에서 발송하는 메일입니다. 본인이 요청한 메일이 아니라면 개인정보 보호를 위해 비밀번호를 재설정해주세요. 비밀번호를 다시 설정하려면 '비밀번호 재설정' 링크를 클릭해주세요.</p>"
				+ "<a href='http://qclass.iptime.org:8787/DEVCA/member/privacypasswordresetemailpage.do'>비밀번호 재설정</a>"
				+ "</div>";
		
		Properties props = new Properties();
		
		// G-Mail SMTP 사용시
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.transport", "smtp");
		props.put("mail.smtp.host", host);
		props.setProperty("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		props.put("mail.smtp.port", "465");
		props.put("mail.smtp.user", from);
		props.put("mail.smtp.auth", "true");
		
		Session mailSession = Session.getInstance(props, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication("ancsbbc@gmail.com", "tjamnjikpaapdwpu");
			}
		});
		
		Message msg = new MimeMessage(mailSession);
		try {
			msg.setFrom(new InternetAddress(from, MimeUtility.encodeText(fromName, "UTF-8", "B")));
			
			InternetAddress[] address1 = {new InternetAddress(to1)};
			msg.setRecipients(Message.RecipientType.TO, address1);
			msg.setSubject(subject);
			msg.setSentDate(new java.util.Date());
			msg.setContent(content, "text/html; charset=utf-8");
			
			
			Transport.send(msg);
		} catch (UnsupportedEncodingException | MessagingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	public static void sendInviteEmail(String email, String member_name, int study_code, String study_title, String study_content) {
		String host = "smtp.gmail.com";
		String subject = "DEVCA '" + study_title + "' 스터디 초대 안내";
		String fromName = "DEVCA 관리자";
		String from = "ancsbbc@gmail.com";
		String to1 = email;
		
		String content = "<div>"
				+ "<h1>DEVCA</h1>"
				+ "<h2>스터디 초대 안내</h2>"
				+ "<p>" + member_name + "님에게 온 스터디 초대권 입니다.</p>"
				+ "<div style='background-color: pink;'>"
				+ "<h1>" + study_title + "</h1>"
				+ "<p>" + study_content + "<p>"
				+ "<p>본 메일은 스터디 초대 알림을 위해 DEVCA에서 발송하는 메일입니다. '스터디 보러가기' 링크를 클릭해주세요.</p>"
				+ "<a href='http://qclass.iptime.org:8787/DEVCA/study/studydetailpage.do?STUDY_CODE=" + study_code + "'>스터디 보러가기</a>"
				+ "</div>";
		
		Properties props = new Properties();
		
		// G-Mail SMTP 사용시
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.transport", "smtp");
		props.put("mail.smtp.host", host);
		props.setProperty("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		props.put("mail.smtp.port", "465");
		props.put("mail.smtp.user", from);
		props.put("mail.smtp.auth", "true");
		
		Session mailSession = Session.getInstance(props, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication("ancsbbc@gmail.com", "tjamnjikpaapdwpu");
			}
		});
		
		Message msg = new MimeMessage(mailSession);
		try {
			msg.setFrom(new InternetAddress(from, MimeUtility.encodeText(fromName, "UTF-8", "B")));
			
			InternetAddress[] address1 = {new InternetAddress(to1)};
			msg.setRecipients(Message.RecipientType.TO, address1);
			msg.setSubject(subject);
			msg.setSentDate(new java.util.Date());
			msg.setContent(content, "text/html; charset=utf-8");
			
			
			Transport.send(msg);
		} catch (UnsupportedEncodingException | MessagingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
}

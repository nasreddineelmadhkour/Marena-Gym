package com.bezkoder.springjwt.Services;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import lombok.AllArgsConstructor;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import java.nio.charset.StandardCharsets;

@Service
@AllArgsConstructor

public class ServiceEmail implements IServiceEmail{

    JavaMailSender emailSender;
    @Override
    public void setMessage(String to,String subject,String token) throws MessagingException {

        MimeMessage message= emailSender.createMimeMessage();
        MimeMessageHelper mailHelper = new MimeMessageHelper(message,MimeMessageHelper.MULTIPART_MODE_MIXED_RELATED, StandardCharsets.UTF_8.name());
        mailHelper.setFrom("hibalahbib5@gmail.com");
        mailHelper.setTo(to);
        mailHelper.setSubject("Reset Password !");

        mailHelper.setText("", "" +
                "<!DOCTYPE html>\n" +
                "<html>\n" +
                "<head>\n" +
                "<title>Page Title</title>\n" +
                "</head>\n" +
                "<body>\n" +
                "\n" +
                "<h1>Code reset password : "+token+"</h1>\n" +
                "\n" +
                "</body>\n" +
                "</html>");

        this.emailSender.send(message);

    }


}

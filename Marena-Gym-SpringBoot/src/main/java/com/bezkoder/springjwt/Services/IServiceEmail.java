package com.bezkoder.springjwt.Services;

import jakarta.mail.MessagingException;

public interface IServiceEmail {
    void setMessage(String to,String subject,String token) throws MessagingException;

}

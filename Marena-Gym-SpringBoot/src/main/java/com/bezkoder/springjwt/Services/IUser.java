package com.bezkoder.springjwt.Services;

import com.bezkoder.springjwt.models.Cours;
import com.bezkoder.springjwt.models.TypeCour;
import com.bezkoder.springjwt.models.User;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.Date;

public interface IUser {
    public String resetPassword(String token, String password);

    public String forgotPassword(String email);


    public User registreUser(MultipartFile file,
                             String username,
                             String email,
                             String password,
                             Date birth_date,
                             String adresse,
                             int taille,
                             int poids,
                             int age,
                             String telephone) throws IOException;

    public Cours addCours(String nom, String description, Date dateSeance, TypeCour type, MultipartFile file) throws IOException;


    public User updateUser(MultipartFile file, String name, int taille, int poids, int age, Long idUser) throws IOException;

    public boolean verifyCode(String code , String identity);

    public boolean SendCodeReset(String identity) ;
    public boolean ChangePasswordAfterVerification(String newPassword , String identity);

    User updateE(MultipartFile file, String name, String email, String password, Date date, String adresse, Long idUser) throws IOException;


    public User registreAdmin(MultipartFile file,
            String username ,
            String email,
            String password ,
            Date birth_date ,
            String adresse,
            int taille,
            int poids,
            int age,
            String telephone) throws IOException ;
}

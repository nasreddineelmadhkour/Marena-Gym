package com.bezkoder.springjwt.Services;
import com.bezkoder.springjwt.Dto.ReclamationDto;
import com.bezkoder.springjwt.Utils.ImageUtils;
import jakarta.mail.MessagingException;

import com.bezkoder.springjwt.models.*;
import com.bezkoder.springjwt.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.temporal.TemporalAdjusters;
import java.util.*;

@Service
public class uService implements IUser{


    private static final long EXPIRE_TOKEN_AFTER_MINUTES = 30;

    @Autowired
     UserRepository userRepository;
    @Autowired
    CoursRepository coursRepository;
    @Autowired
    ReclamationRepository reclamationRepository;
    @Autowired
    InscritCourRepository inscritCourRepository;
    @Autowired 
    RoleRepository roleRepository;
    @Autowired 
    AvisRepository avisRepository;
    @Autowired
    ReservationRepository reservationRepository;
    @Autowired
    private CalendrierRepository calendrierRepository;
    @Autowired
    PasswordEncoder encoder;
  
    @Autowired IServiceEmail iServiceEmail;

    public String forgotPassword(String email) {

        Optional<User> userOptional = Optional
                .ofNullable(userRepository.findByEmail(email));

        if (!userOptional.isPresent()) {
            return "Invalid email id.";
        }

        User user = userOptional.get();
        user.setToken(generateToken());
        user.setTokenCreationDate(LocalDateTime.now());

        user = userRepository.save(user);

        return user.getToken();
    }

    public String resetPassword(String token, String password) {

        Optional<User> userOptional = Optional
                .ofNullable(userRepository.findByToken(token));

        if (!userOptional.isPresent()) {
            return "Invalid token.";
        }

        LocalDateTime tokenCreationDate = userOptional.get().getTokenCreationDate();

        if (isTokenExpired(tokenCreationDate)) {
            return "Token expired.";

        }

        User user = userOptional.get();

        user.setPassword(password);
        user.setToken(null);
        user.setTokenCreationDate(null);

        userRepository.save(user);

        return "Your password successfully updated.";
    }

    /**
     * Generate unique token. You may add multiple parameters to create a strong
     * token.
     *
     * @return unique token
     */
    private String generateToken() {
        StringBuilder token = new StringBuilder();

        return token.append(UUID.randomUUID().toString())
                .append(UUID.randomUUID().toString()).toString();
    }

    /**
     * Check whether the created token expired or not.
     *
     * @param tokenCreationDate
     * @return true or false
     */
    private boolean isTokenExpired(final LocalDateTime tokenCreationDate) {

        LocalDateTime now = LocalDateTime.now();
        Duration diff = Duration.between(tokenCreationDate, now);

        return diff.toMinutes() >= EXPIRE_TOKEN_AFTER_MINUTES;
    }

    public Cours updateCours(Long courId, Cours updatedCours) {
        Cours cours = coursRepository.findById(courId).orElse(null);
        if (cours != null) {
            cours.setNom(updatedCours.getNom());
            cours.setDescription(updatedCours.getDescription());
            cours.setType(updatedCours.getType());
            cours.setDateSeance(updatedCours.getDateSeance());

            return coursRepository.save(cours);
        }
        return null;
    }
    public User updateusers(Long userId, User updatedUsers) {
        User user = userRepository.findById(userId).orElse(null);
        if (user != null) {
            user.setUsername(updatedUsers.getUsername());
            user.setAdresse(updatedUsers.getAdresse());
            user.setEmail(updatedUsers.getEmail());
            user.setBirth_date(updatedUsers.getBirth_date());

            return userRepository.save(user);
        }
        return null;
    }
    public Reclamation updateReclamation(Long recId, Reclamation updatedrec) {
        Reclamation rec = reclamationRepository.findById(recId).orElse(null);
        if (rec != null) {
            rec.setReponcereclamations(updatedrec.getReponcereclamations());
            rec.setContenu(rec.getContenu());


            return reclamationRepository.save(rec);
        }
        return null;
    }

    public InscriptionCours AddInscription(InscriptionCours inscrit, Long courid) {

        Cours cours = coursRepository.findById(courid).orElse(null);
        inscrit.setCours(cours);


        return  inscritCourRepository.save(inscrit);
    }
    public Reservationcourprive AddReservation(Reservationcourprive reservation, Long courid) {
        Cours cours = coursRepository.findById(courid).orElse(null);
        reservation.setCourss(cours);
        return  reservationRepository.save(reservation);
    }
    public List<LocalDateTime> getDatesForCurrentWeek( Long userid) {
        List<LocalDateTime> datesOfThisWeek = calendrierRepository.findAllLocalDateTimes(userid);
        LocalDate startOfWeek = LocalDate.now().with(TemporalAdjusters.previousOrSame(java.time.DayOfWeek.MONDAY));
        LocalDate endOfWeek = startOfWeek.plusDays(6);

        LocalDateTime startDateTime = startOfWeek.atStartOfDay();
        LocalDateTime endDateTime = endOfWeek.atTime(23, 59, 59);

        return datesOfThisWeek.stream()
                .filter(dateTime -> !dateTime.isBefore(startDateTime) && !dateTime.isAfter(endDateTime))
                .toList();
    }
    
    
    
    
    
    
    
    
    
    
    
    


    @Override
    public User registreUser(MultipartFile file,
                             String username ,
                             String email,
                             String password ,
                             Date birth_date ,
                             String adresse,
                             int taille,
                             int poids,
                             int age,
                             String telephone) throws IOException {

        User user = new User();
        user.setPhoto(ImageUtils.compressImage(file.getBytes()));
        user.setNamePhoto(file.getOriginalFilename());
        user.setTypePhoto(file.getContentType());
        user.setUsername(username);
        user.setEmail(email);
        user.setPassword(encoder.encode(password));
        user.setBirth_date(birth_date);
        user.setAdresse(adresse);
        user.setTaille(taille);
        user.setPoids(poids);
        user.setAge(age);
        user.setTelephone(telephone);


        return userRepository.save(user);


    }



    public ReclamationDto getRandomReclamation(){
        List<Avis> reclamations = avisRepository.findAll();
        ReclamationDto reclamationDto = new ReclamationDto();

        int randomWithMathRandom = (int) ((Math.random() * (reclamations.size() - 0)) + 0);

        System.out.println("random : "+randomWithMathRandom);
        reclamationDto.setContenu(reclamations.get(randomWithMathRandom).getContenuavis());
        reclamationDto.setNameUser(reclamations.get(randomWithMathRandom).getUseravis().getName());

        return reclamationDto;
    }




    @Override
    public Cours addCours(String nom, String description, Date dateSeance, TypeCour type, MultipartFile file)throws IOException {

        Cours cours = new Cours();

        cours.setNom(nom);
        cours.setDescription(description);
        cours.setType(type);

        cours.setPhoto(ImageUtils.compressImage(file.getBytes()));
        cours.setNamePhoto(file.getOriginalFilename());
        cours.setTypePhoto(file.getContentType());

        cours.setDateSeance(dateSeance);

        return coursRepository.save(cours);
    }

    @Override
    public User updateUser(MultipartFile file, String name, int taille, int poids, int age,Long idUser) throws IOException {

        User user = userRepository.findById(idUser).orElse(null);
        if(user!=null){

            user.setPhoto(ImageUtils.compressImage(file.getBytes()));
            user.setName(name);
            user.setPoids(poids);
            user.setTaille(taille);
            user.setAge(age);

            return userRepository.save(user);
        }
        return null;
    }










    @Override
    public boolean SendCodeReset(String identity) {

        User account = userRepository.findByEmail(identity);

        if(account!= null){

            account.setToken(String.valueOf(generateCode()));
            System.out.println(account.getToken());
            userRepository.save(account);


            try {
                iServiceEmail.setMessage(account.getEmail(),"Reset password!",account.getToken());
            } catch (MessagingException e) {
                throw new RuntimeException(e);
            }

            String m = "Your Code verification code is: "+account.getToken();
            System.out.println(m);




            return true;
        }


        return false;
    }

    public int generateCode(){
        Random random = new Random();
        return 100000 + random.nextInt(999999 - 100000);

    }


    @Override
    public boolean verifyCode(String code , String identity){
        User account = userRepository.findByEmail(identity);

        if(account != null){
            if(account.getToken().equals(code)){
                account.setToken(null);
                userRepository.save(account);
                return true;
            }
        }

        return false;
    }

    @Override
    public boolean ChangePasswordAfterVerification(String newPassword , String identity){
        User account = userRepository.findByEmail(identity);
        if(account!=null){
            account.setPassword(encoder.encode(newPassword));
            userRepository.save(account);
            return true;
        }


        return false;
    }

    @Override
    public User updateE(MultipartFile file, String name, String email, String password, Date date, String adresse, Long idUser)throws IOException {

        User user = userRepository.findById(idUser).orElse(null);

        if(user!= null){

            user.setPhoto(ImageUtils.compressImage(file.getBytes()));
            user.setName(name);
            user.setEmail(email);
            //user.setPassword(encoder.encode(password));
            user.setBirth_date(date);
            user.setAdresse(adresse);

            return userRepository.save(user);
        }


        return null;


    }


	
	@Override
    public User registreAdmin(MultipartFile file,
                             String username ,
                             String email,
                             String password ,
                             Date birth_date ,
                             String adresse,
                             int taille,
                             int poids,
                             int age,
                             String telephone) throws IOException {

        User user = new User();
        user.setPhoto(ImageUtils.compressImage(file.getBytes()));
        user.setNamePhoto(file.getOriginalFilename());
        user.setTypePhoto(file.getContentType());
        user.setUsername(username);
        user.setEmail(email);
        user.setPassword(encoder.encode(password));
        user.setBirth_date(birth_date);
        user.setAdresse(adresse);
        user.setTaille(taille);
        user.setPoids(poids);
        user.setAge(age);
        user.setTelephone(telephone);
        
        Role role = roleRepository.findById(1).orElse(null);
        
        if(role != null) {
        	user.getRoles().add(role);
        }
        return userRepository.save(user);


    }


}

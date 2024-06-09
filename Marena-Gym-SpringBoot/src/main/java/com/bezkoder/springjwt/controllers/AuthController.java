package com.bezkoder.springjwt.controllers;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.stream.Collectors;
import java.util.zip.DataFormatException;
import java.util.zip.Deflater;
import java.util.zip.Inflater;

import com.bezkoder.springjwt.Dto.UserDto;
import com.bezkoder.springjwt.Services.IUser;
import com.bezkoder.springjwt.Services.uService;
import com.bezkoder.springjwt.Utils.ImageUtils;
import com.bezkoder.springjwt.models.*;
import com.bezkoder.springjwt.repository.AvisRepository;
import com.bezkoder.springjwt.repository.CoursRepository;
import com.bezkoder.springjwt.repository.ImageRepository;
import jakarta.validation.Valid;

import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

import com.bezkoder.springjwt.payload.request.LoginRequest;
import com.bezkoder.springjwt.payload.request.SignupRequest;
import com.bezkoder.springjwt.payload.response.JwtResponse;
import com.bezkoder.springjwt.payload.response.MessageResponse;
import com.bezkoder.springjwt.repository.RoleRepository;
import com.bezkoder.springjwt.repository.UserRepository;
import com.bezkoder.springjwt.security.jwt.JwtUtils;
import com.bezkoder.springjwt.security.services.UserDetailsImpl;
import org.springframework.web.multipart.MultipartFile;

import static com.bezkoder.springjwt.models.ERole.Role_client;

@CrossOrigin(origins = "*", maxAge = 3600)
@RestController
@RequestMapping("/api/auth")
@RequiredArgsConstructor
public class AuthController {
  @Autowired
  AuthenticationManager authenticationManager;

  @Autowired
  AvisRepository avisRepository;
  @Autowired
  UserRepository userRepository;

  @Autowired
  RoleRepository roleRepository;
  @Autowired
  uService service;
  @Autowired
  PasswordEncoder encoder;

  @Autowired
  JwtUtils jwtUtils;
  @Autowired
  private IUser userService;
  @Autowired
  CoursRepository coursRepository;
@Autowired
ImageRepository imagerepo ;




@GetMapping("/registreAdmin")
public User addAdmin(
         @RequestParam("image") MultipartFile file
        ,@RequestParam("username") String username
        ,@RequestParam("email") String email
        ,@RequestParam("password") String password
        ,@RequestParam("birth_date") String birth_date
        ,@RequestParam("adresse") String adresse
        ,@RequestParam("taille") int taille
         ,@RequestParam("poids") int poids
         ,@RequestParam("age") int age
        ,@RequestParam("telephone") String telephone
) throws IOException{

  SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
 try {
   Date date = dateFormat.parse(birth_date);
   return userService.registreAdmin( file,  username ,  email,  password ,  date ,  adresse,  taille, poids,age,telephone) ;

 }
 catch (ParseException e){

 }
 return null;
}


  @GetMapping("/registre")
  public User addUser(
           @RequestParam("image") MultipartFile file
          ,@RequestParam("username") String username
          ,@RequestParam("email") String email
          ,@RequestParam("password") String password
          ,@RequestParam("birth_date") String birth_date
          ,@RequestParam("adresse") String adresse
          ,@RequestParam("taille") int taille
           ,@RequestParam("poids") int poids
           ,@RequestParam("age") int age
          ,@RequestParam("telephone") String telephone
  ) throws IOException{

    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
   try {
     Date date = dateFormat.parse(birth_date);
     return userService.registreUser( file,  username ,  email,  password ,  date ,  adresse,  taille, poids,age,telephone) ;

   }
   catch (ParseException e){

   }
   return null;
  }

    @GetMapping("/getDetailUser/{id}")
    public UserDto getDetailUser(@PathVariable Long id)throws IOException{
      User user = userRepository.findById(id).orElse(null);
      UserDto userDto = new UserDto();
      if(user!=null){
        userDto.setId(user.getId());
        userDto.setName(user.getName());
        userDto.setAdresse(user.getAdresse());
        userDto.setPoids(user.getPoids());
        userDto.setTaille(user.getTaille());
        userDto.setEmail(user.getEmail());
        userDto.setAdresse(user.getAdresse());
        userDto.setAge(user.getAge());
        userDto.setBirth_date(user.getBirth_date());
        userDto.setRoles(user.getRoles().stream().map(role -> role.getName().name()).toList());
        userDto.setTelephone(user.getTelephone());
        userDto.setPhoto(ImageUtils.decompressImage(user.getPhoto()));
        userDto.setAbonnementcreation(user.getAbonnementcreation());
        userDto.setAbonnementexpiration(user.getAbonnementexpiration());
        userDto.setUsername(user.getUsername());
        userDto.setPassword(user.getPassword());
        userDto.setNamePhoto(user.getNamePhoto());

        userDto.setTypePhoto(user.getTypePhoto());
      }
      
      return userDto;
    }


    @PostMapping("/updateUser/{id}")
    public User updateUser(@RequestParam("image") MultipartFile file,@RequestParam("name") String name,@RequestParam("poids") int taille,@RequestParam("taille") int poids,@RequestParam("age") int age,@PathVariable("id") Long idUser) throws IOException {
      return userService.updateUser(file,name,taille,poids,age,idUser);
  }

      @PostMapping("/signin")//Flutter (sign in)
  public ResponseEntity<?> authenticateUser(@Valid @RequestBody LoginRequest loginRequest) {

    Authentication authentication = authenticationManager.authenticate(
        new UsernamePasswordAuthenticationToken(loginRequest.getUsername(), loginRequest.getPassword()));

    SecurityContextHolder.getContext().setAuthentication(authentication);
    String jwt = jwtUtils.generateJwtToken(authentication);
    
    UserDetailsImpl userDetails = (UserDetailsImpl) authentication.getPrincipal();    
    List<String> roles = userDetails.getAuthorities().stream()
        .map(item -> item.getAuthority())
        .collect(Collectors.toList());

    return ResponseEntity.ok(new JwtResponse(jwt, 
                         userDetails.getId(), 
                         userDetails.getUsername(), 
                         userDetails.getEmail(), 
                         roles));

    

  }
      
      
  @PostMapping("/registerEntreuneur")
  public User registerEntreuneur(@RequestParam("image") MultipartFile file,@RequestParam("email") String email,@RequestParam("username") String username,@RequestParam("password") String password,@RequestParam("address")String address,@RequestParam("birth_date")String birth_date)throws IOException{

	    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	   try {
	     Date date = dateFormat.parse(birth_date);

	     
	     Role role= roleRepository.findByName(ERole.Role_Entreneur).orElse(null);
	     if(role!=null) {
		  User signUpRequest = new User();
		  signUpRequest.setEmail(email);
		  signUpRequest.setUsername(username);
		  signUpRequest.setName(username);
		  signUpRequest.setAdresse(address);
		  signUpRequest.setBirth_date(date);
		  signUpRequest.getRoles().add(role);
		  signUpRequest.setPassword(encoder.encode(password));
		  signUpRequest.setPhoto(ImageUtils.compressImage(file.getBytes()));
		  signUpRequest.setTypePhoto(file.getContentType());
		  signUpRequest.setNamePhoto(file.getOriginalFilename());
		  return userRepository.save(signUpRequest);
	     }
	     
	     
	     
	     
	   }
	   catch (ParseException e){

	   }
	   return null;
	  }
  
  
  @GetMapping("/getAllAvis")
  public List<Avis> getAllAvis(){
	  return avisRepository.findAll();
  }
  
  

  
  @PostMapping("/registerClient")
  public User registerEntreuneur(@RequestParam("image") MultipartFile file,
		  @RequestParam("email") String email,
		  @RequestParam("username") String username,
		  @RequestParam("password") String password,
		  @RequestParam("address")String address,
		  @RequestParam("birth_date")String birth_date ,
		  @RequestParam("abonnementcreation")String abonnementcreation 
		  ,@RequestParam("abonnementexpiration")String abonnementexpiration
		  ,@RequestParam("telephone")String telephone

		  )throws IOException{

	  
	  
	  
	    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	   try {
	     Date date = dateFormat.parse(birth_date);

	     Date dateCreation = dateFormat.parse(abonnementcreation);
	     Date dateExpiration = dateFormat.parse(abonnementexpiration);

	     Role role= roleRepository.findByName(ERole.Role_client).orElse(null);
	     if(role!=null) {
		  User signUpRequest = new User();
		  signUpRequest.setEmail(email);
		  signUpRequest.setUsername(username);
		  signUpRequest.setName(username);
		  signUpRequest.setAdresse(address);
		  signUpRequest.setBirth_date(date);
		  signUpRequest.getRoles().add(role);
		  signUpRequest.setPassword(encoder.encode(password));
		  signUpRequest.setPhoto(ImageUtils.compressImage(file.getBytes()));
		  signUpRequest.setTypePhoto(file.getContentType());
		  signUpRequest.setNamePhoto(file.getOriginalFilename());
		  
		  signUpRequest.setTelephone(telephone);
		  signUpRequest.setAbonnementcreation(dateCreation);
		  signUpRequest.setAbonnementexpiration(dateExpiration);
		  
		  
		  return userRepository.save(signUpRequest);
	     }
	     
	     
	     
	     
	   }
	   catch (ParseException e){

	   }
	   return null;
	  }
	  

	  
  @GetMapping("/getAllEntreneur")
  public List<User> getAllEntreneur(){
	  List<User> entreuneurs = new ArrayList<>();
	  for(User user : userRepository.findAll()) {
		  for(Role role : user.getRoles()) {
			  if(role.getName().equals(ERole.Role_Entreneur)) {
				  entreuneurs.add(user);
			  }
		  }
	  }
	  
	  return entreuneurs;
  }
	  
	  
  
/*
  @PostMapping("/signup")//angular
  public ResponseEntity<?> registerUser(@RequestParam("image") MultipartFile file,@RequestParam("username") String username,@RequestParam("password") String password,@RequestParam("address")String address,@RequestParam("image"),@RequestParam("image"),@RequestParam("birth_date")String birth_date,@RequestParam("role") String role) {
    
	  
	  SignupRequest signUpRequest = new SignupRequest();
	  signUpRequest.setEmail(email);
	  signUpRequest.setUsername(username);
	  signUpRequest.set
	  
	  if (userRepository.existsByUsername(signUpRequest.getUsername())) {
      return ResponseEntity
          .badRequest()
          .body(new MessageResponse("Error: Username is already taken!"));
    }

    if (userRepository.existsByEmail(signUpRequest.getEmail())) {
      return ResponseEntity
          .badRequest()
          .body(new MessageResponse("Error: Email is already in use!"));
    }

    // Create new user's account
  User user = new User(signUpRequest.getUsername(),
              signUpRequest.getEmail(),
              encoder.encode(signUpRequest.getPassword()),signUpRequest.getAdresse(),signUpRequest.getBirth_date() ,signUpRequest.getTelephone(), signUpRequest.getAbonnementcreation() , signUpRequest.getAbonnementexpiration());

    user.setAdresse(signUpRequest.getAdresse());
    user.setTelephone(signUpRequest.getTelephone());
    user.setTaille(signUpRequest.getTaille());
    user.setName(signUpRequest.getName());
    user.setPoids(signUpRequest.getPoids());
    user.setPassword(encoder.encode(signUpRequest.getPassword()));

    //  User users = new User(signUpRequest.getUsername(),
       //     signUpRequest.getEmail(),
      //    encoder.encode(signUpRequest.getPassword()),signUpRequest.getAdresse(),signUpRequest.getBirth_date(),signUpRequest.getSpecialite());
    Set<String> strRoles = signUpRequest.getRole();
    Set<Role> roles = new HashSet<>();

    if (strRoles == null) {
      Role userRole = roleRepository.findByName(ERole.Role_Admin)
          .orElseThrow(() -> new RuntimeException("Error: Role is not found."));
      roles.add(userRole);
    } else {
      strRoles.forEach(role -> {
        switch (role) {

        case "client":
          Role modRole = roleRepository.findByName(Role_client)
              .orElseThrow(() -> new RuntimeException("Error: Role is not found."));
          roles.add(modRole);

break;
          case "entreneur":
            Role EntRole = roleRepository.findByName(ERole.Role_Entreneur)
                    .orElseThrow(() -> new RuntimeException("Error: Role is not found."));
            roles.add(EntRole);


          break;
        default:
          Role userRole = roleRepository.findByName(ERole.Role_Admin)
              .orElseThrow(() -> new RuntimeException("Error: Role is not found."));
          roles.add(userRole);
        }
      });
    }

      Long id = imagerepo.idlastimg();
      user.setImage(id);

      user.setRoles(roles);

      userRepository.save(user);

    return ResponseEntity.ok(new MessageResponse("User registered successfully!"));
  }

*/
  @PostMapping("/forgot-password")//flutter (forgetpassword)
  public String forgotPassword(@RequestParam String email) {

    String response = userService.forgotPassword(email);

    if (!response.startsWith("Invalid")) {
      response = "http://localhost:8080/api/auth/reset-password?token=" + response;
    }
    return response;
  }

  @PutMapping("/reset-password")//fluter (confirmer pasword modifier)
  public String resetPassword(@RequestParam String token,
                              @RequestParam String password) {

    return userService.resetPassword(token, password);
  }
  @GetMapping(value="/getallentreneur")//angular(afficher entrenure)
  public List<User> AllEntreneurs() {
    List<User> userList = new ArrayList<>();
    Map<Long, User> userMap = new HashMap<>();
    List<Long> ids = roleRepository.nb_idsentreneur();
    for (Long id : ids) {
      if (userMap.containsKey(id)) {
        userList.add(userMap.get(id));
      }
    }
    return userList;
  }

  @GetMapping("/listeclients")//angular(afficher clinets)
  public List<User> getclientByIds() {
    List<Long> ids = roleRepository.nb_idclients();
    List<User> users = userRepository.findAllById(ids) ;
    return users ;
  }
    @DeleteMapping(value = "/deleteuserbyid/{id}")//angular(supprimer clients/entrai,neyu)
    public void deletebyid(@PathVariable Long id) {
        userRepository.deleteById(id);
    }
  @GetMapping(value = "/showallcours")//angulare(afficher cours)bich nconsomiha flutter(calrndrier cours)
  public List<Cours> retrieveAllCourss() {

    return (List<Cours>) coursRepository.findAll();
  }
  @PutMapping("/updateprofile/{iduser}")//flutter (gérer profile) zouz entr wil client
  public ResponseEntity<User> updateuser (@PathVariable Long iduser, @RequestBody User updateduser){
    User user  = service.updateusers(iduser , updateduser);
    if (user != null) {
      return ResponseEntity.ok(user);
    } else {
      return ResponseEntity.notFound().build();
    }
  }
  @PostMapping("/upload")//angulare ajoute image
  public ResponseEntity.BodyBuilder uplaodImage(@RequestParam("imageFile") MultipartFile file) throws IOException {
    System.out.println("Original Image Byte Size - " + file.getBytes().length);
    imageuser img = new imageuser(file.getOriginalFilename(), file.getContentType(),
            compressBytes(file.getBytes()));
    imagerepo.save(img);
    return ResponseEntity.status(HttpStatus.OK);
  }
  @GetMapping(path = { "/get/{imageID}" })//angular (affiche l'imagebch n'affichiha fil flutter mon profile
  public imageuser getImage(@PathVariable("imageID") Long imageID) throws IOException {
    final Optional<imageuser> retrievedImage = imagerepo.findById(imageID);
    imageuser img = new imageuser(retrievedImage.get().getName(), retrievedImage.get().getType(),
            decompressBytes(retrievedImage.get().getPicByte()));
    return img;
  }
  // compress the image bytes before storing it in the database
  public static byte[] compressBytes(byte[] data) {
    Deflater deflater = new Deflater();
    deflater.setInput(data);
    deflater.finish();
    ByteArrayOutputStream outputStream = new ByteArrayOutputStream(data.length);
    byte[] buffer = new byte[1024];
    while (!deflater.finished()) {
      int count = deflater.deflate(buffer);
      outputStream.write(buffer, 0, count);
    }
    try {
      outputStream.close();
    } catch (IOException e) {
    }
    System.out.println("Compressed Image Byte Size - " + outputStream.toByteArray().length);
    return outputStream.toByteArray();
  }
  // uncompress the image bytes before returning it to the angular application
  public static byte[] decompressBytes(byte[] data) {
    Inflater inflater = new Inflater();
    inflater.setInput(data);
    ByteArrayOutputStream outputStream = new ByteArrayOutputStream(data.length);
    byte[] buffer = new byte[1024];
    try {
      while (!inflater.finished()) {
        int count = inflater.inflate(buffer);
        outputStream.write(buffer, 0, count);
      }
      outputStream.close();
    } catch (IOException ioe) {
    } catch (DataFormatException e) {
    }
    return outputStream.toByteArray();
  }

















  @GetMapping("/resetpassword/SendCodeReset/{identity}")
  public boolean SendCodeReset(@PathVariable String identity){
    return userService.SendCodeReset(identity);
  }

  @GetMapping("/resetpassword/verifyCode/{code}/{identity}")
  public boolean verifyCode(@PathVariable String code ,@PathVariable String identity) {
    return userService.verifyCode(code,identity);
  }

  @GetMapping("/resetpassword/ChangePasswordAfterVerification/{newPassword}/{identity}")
  public boolean ChangePasswordAfterVerification(@PathVariable String newPassword ,@PathVariable String identity){
    return userService.ChangePasswordAfterVerification(newPassword,identity);
  }











  @PostMapping("/UpdateE/{id}")
  public User updateE(
          @RequestParam("image") MultipartFile file
          ,@RequestParam("name") String name
          ,@RequestParam("email") String email
          ,@RequestParam("password") String password
          ,@RequestParam("birth_date") String birth_date
          ,@RequestParam("adresse") String adresse,
          @PathVariable("id") Long idUser
  ) throws IOException{

    System.out.println("Hello");
    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
    try {
      Date date = dateFormat.parse(birth_date);
      return userService.updateE( file,  name ,  email,  password ,  date ,  adresse,idUser) ;

    }
    catch (ParseException e){

    }
    return null;
  }



}

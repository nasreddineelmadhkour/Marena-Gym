package com.bezkoder.springjwt.controllers;

import com.bezkoder.springjwt.Services.uService;
import com.bezkoder.springjwt.Utils.ImageUtils;
import com.bezkoder.springjwt.models.*;
import com.bezkoder.springjwt.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@CrossOrigin(origins = "*", maxAge = 3600)
@RestController
@RequestMapping("/api/cour")
public class CourControlleur {
    @Autowired
    CoursRepository coursRepository;
     @Autowired
    uService service;
    @Autowired
    InscritCourRepository inscritCourRepository;
    @Autowired
    ReservationRepository reservationrepo ;
    @Autowired
    UserRepository userRepository;

    @Autowired
    RoleRepository roleRepository;
    @Autowired
     AvisRepository avisrepo ;
    @Autowired
    CalendrierRepository calendrierRepository;
    
    
    @GetMapping("/getAllCal/{idEnt}")
    public List<Calendrier> getAllCal(@PathVariable Long idEnt){
    	
    	return calendrierRepository.findAll().stream().filter(o -> o.getUsers().getId()==idEnt).toList();
    }
    
    @PostMapping("/addCal/{idEnt}")
    public Calendrier addCal(@RequestBody Calendrier calendrier , @PathVariable Long idEnt) {
    	User user = userRepository.findById(idEnt).orElse(null);
    	if(user!=null) {
    		calendrier.setUsers(user);
    		
    	}
    	
    	return calendrierRepository.save(calendrier);
    }
    
    
    
    //@PreAuthorize("hasAuthority('admin')")
    @PostMapping(value = "/add-cours")//angulare (ajouter cours)
    public Cours addCours(@RequestBody Cours s) {
   //   s.setType(Cour_public);
        return coursRepository.save(s);
    }
    @PostMapping(value = "/add-avis/{id}")// flutter (client ajouter avis)
    public Boolean addAvis(@PathVariable Long id,@RequestBody Avis s) {

        User user = userRepository.findById(id).orElse(null);
        if(user!=null) {
            s.setUseravis(user);
            avisrepo.save(s);
            return true;
        }
        return false;
    }
    @GetMapping("/showallcours")//flutter w angular
    public List<Cours> retrieveAllCourss() {
        return (List<Cours>) coursRepository.findAll();

    }

    @GetMapping( "/getAllCours")//flutter w angular
    public List<Cours> getAllCours() {
        List<Cours> cours = new ArrayList<>();

        for(Cours cour: coursRepository.findAll()){
            cour.setPhoto(ImageUtils.decompressImage(cour.getPhoto()));
            cours.add(cour);
        }


        return cours;
    }

    @GetMapping(value = "/showallAviss")//angulare (affiche avis)
    public List<Avis> retrieveAllAvis() {

        return (List<Avis>) avisrepo.findAll();
    }
    @GetMapping(value = "/showcours/{id}")//fluuter détaille cours
    public Optional<Cours> retrieveCoursbyid(@PathVariable Long id) {

        return  coursRepository.findById(id) ;
    }

    @DeleteMapping(value = "/deletecourbyid/{id}")//angulare (supprimer cours)
    public void deletebyid(@PathVariable Long id) {

        coursRepository.deleteById(id);
    }
    @PutMapping("/updatecours/{courId}")//angulare (bch nocosomiywha mizelit)
    public ResponseEntity<Cours> updateCours(@PathVariable Long courId, @RequestBody Cours updatedCour) {
        Cours cour = service.updateCours(courId, updatedCour);
        if (cour != null) {
            return ResponseEntity.ok(cour);
        } else {
            return ResponseEntity.notFound().build();
        }
    }


    @PostMapping(value ="/inscritcours/{courid}")//flutter (inscrit cours)
    public InscriptionCours AddInscription(@RequestBody InscriptionCours inscrit, @PathVariable Long courid) {
        return service.AddInscription(inscrit,courid);
    }



    @GetMapping(value="/allinscription")//angular
    public List<InscriptionCours> afficherallinscription(){
        return inscritCourRepository.findAll();
    }


    @GetMapping(value="/numbreinscription/{idcours}")//angular
    public Long affichernombreinscription  (@PathVariable Long idcours){
        return inscritCourRepository.Numbrinscription(idcours);
    }
    @PostMapping(value = "/deleteinscritcourbyid/{id}")//flutter déinscription
    public void deletebyidinscrit(@PathVariable Long id) {
        inscritCourRepository.deleteById(id);
    }
    @PostMapping(value ="/reservercours/{courid}")//flutter cours privé
    public Reservationcourprive AddReservation(@RequestBody Reservationcourprive res, @PathVariable Long courid) {
        return service.AddReservation(res,courid);
    }
    @GetMapping("/couretinscrit")//angular
    public List<Object> getinscritByIds() {
      return  inscritCourRepository.InscripetNom();
    }
    @GetMapping("/coursreservation")//angular
    public List<Object> getreservationtByIds() {
        return  reservationrepo.ReservationetNomcour();
    }

    @GetMapping("/allReservation")//flutter
    public List<Reservationcourprive> getAllRPrive (){
        Date currentDate = new Date(); // Get current date
        
        return reservationrepo.findAll().stream().filter(reservationcourprive -> reservationcourprive.getDateSeanceprive().after(currentDate)).toList();
    }
    @GetMapping(value="/allinscri")//flutter
    public List<InscriptionCours> afficherallinscri(){
        Date currentDate = new Date(); // Get current date

        return inscritCourRepository.findAll().stream().filter(inscriptionCours -> inscriptionCours.getDateInscrit().after(currentDate)).toList();
    }




    @GetMapping("/Allreservationetcours")//angular
    public List<Object> getinscritetcours (){
        return reservationrepo.reservation();
    }



    @GetMapping("/Alinscritetcours")//angulare
    public List<Object> getinscrit(){
        return inscritCourRepository.inscription();
    }
    @GetMapping(value ="/nbrcours")//angular
    public Long nbrcours(){
        return coursRepository.Numbrecours();
    }
    @GetMapping(value ="/nbrcoursinscrit")//angular
    public Long nbrcoursinscrit(){
        return inscritCourRepository.Numbreinscrit();
    }
    @GetMapping(value ="/nbrcoursreservation")//angular
    public Long nbrcoursreservation(){
        return reservationrepo.Numbrereservations();
    }
    @GetMapping("/listentreneurs")//angular
    public List<User> getentreneurByIds() {
        List<Long> ids = roleRepository.nb_idsentreneur();
        List<User> users = userRepository.findAllById(ids) ;
        return users ;
    }
    
    
    @GetMapping("/getAllReservation")
    public List<Reservationcourprive> getAllReservation(){
  	  	List<Reservationcourprive> reservationcourprives = new ArrayList<>();
    	/*for(Cours cour : coursRepository.findAll()) {
    		reservationcourprives.addAll(cour.getReser());
    	}*/
  	  	
    	return reservationrepo.findAll();
    }
    
    
    
    @GetMapping("/getAllInsciption")
    public List<InscriptionCours> getAllInscription(){

  	  	
    	return inscritCourRepository.findAll();
    }
    

    @PostMapping ("/addCour")
    public Cours addCour(@RequestParam("image") MultipartFile file,
                         @RequestParam("nom") String nom,
                         @RequestParam("dateSeance") String dateSeance,
                         @RequestParam("type") TypeCour type,
                         @RequestParam("description") String description
                         ) throws IOException {

        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        try {
            Date date = dateFormat.parse(dateSeance);

            return service.addCours(nom, description, date, type, file);
        }
        catch (ParseException e){
        }
        return null;
    }
}

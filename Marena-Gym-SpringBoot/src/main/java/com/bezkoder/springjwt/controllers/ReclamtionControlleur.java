package com.bezkoder.springjwt.controllers;
import java.sql.Timestamp;

import com.bezkoder.springjwt.Dto.ReclamationDto;
import com.bezkoder.springjwt.Services.uService;
import com.bezkoder.springjwt.models.Calendrier;
import com.bezkoder.springjwt.models.Reclamation;
import com.bezkoder.springjwt.models.User;
import com.bezkoder.springjwt.repository.CalendrierRepository;
import com.bezkoder.springjwt.repository.ReclamationRepository;
import com.bezkoder.springjwt.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.temporal.TemporalAdjusters;
import java.time.temporal.TemporalField;
import java.time.temporal.WeekFields;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Locale;
import java.util.stream.Collectors;


@CrossOrigin(origins = "*", maxAge = 3600)
@RestController
@RequestMapping("/api/reclamation")
public class ReclamtionControlleur {
    @Autowired
    ReclamationRepository reclamationRepository;
    @Autowired
    uService service;
    @Autowired
    CalendrierRepository calendrierrepo ;
    @Autowired
    UserRepository userRepository;
    @PostMapping(value = "/add-Reclamation/{id}")//flutter(contactez nous)
    public boolean addReclamtion(@PathVariable Long id,@RequestBody Reclamation s) {
        User user = userRepository.findById(id).orElse(null);
        if(user!=null) {
            s.setUser(user);
            reclamationRepository.save(s);
            return true;
        }

        return false;
    }

    @GetMapping( "/showallrec")//angulare
    public List<Reclamation> retrieveAll() {

        return  reclamationRepository.findAll();
    }

    @PostMapping("/allReclamation/{idUser}")
    public  List <Reclamation> getall(@PathVariable Long idUser){

        return reclamationRepository.findAll().stream().filter(reclamation ->
                reclamation.getUser().getId()==idUser).toList();

    }


    @GetMapping(value = "/showallrecreponce/{user_id}")//flutter(notification na9ouz)
    public String retrievereponce(@PathVariable Long user_id ) {

        return  reclamationRepository.findAllById(user_id);
    }
    @DeleteMapping(value = "/deletebyid/{id}")//angular
    public void deletebyid(@PathVariable Long id) {
        reclamationRepository.deleteById(id);
    }
    @PutMapping("/update/{recId}")//angular
    public ResponseEntity<Reclamation> update(@PathVariable Long recId, @RequestBody Reclamation updatedrec) {
        Reclamation rec = service.updateReclamation(recId, updatedrec);
        if (rec != null) {
            return ResponseEntity.ok(rec);
        } else {
            return ResponseEntity.notFound().build();
        }
    }
    @GetMapping(value ="/nbrreclamations")//angular
    public Long nbrreclamations(){
        return reclamationRepository.Numbrerec();
    }
    @PostMapping(value = "/add-Calendrier")//angular
    public Calendrier addCalendrier(@RequestBody Calendrier  s) {

        return calendrierrepo.save(s);
    }
    public static List<LocalDateTime> filterDatesForThisWeek(List<LocalDateTime> dates) {
        LocalDate today = LocalDate.now();
        LocalDate startOfWeek = today.with(TemporalAdjusters.previousOrSame(DayOfWeek.MONDAY));
        LocalDate endOfWeek = today.with(TemporalAdjusters.nextOrSame(DayOfWeek.SUNDAY));

        return dates.stream()
                .filter(date -> date.toLocalDate().isAfter(startOfWeek.minusDays(1)) &&
                        date.toLocalDate().isBefore(endOfWeek.plusDays(1)))
                .collect(Collectors.toList());
    }
    @GetMapping("/dates-of-this-week/{id}")//flutter (affiche date des cours de semain )
    public List<LocalDateTime> getDatesOfThisWeek(@PathVariable Long id) {

        return service.getDatesForCurrentWeek(id);
    }

    @GetMapping("/randomReclamation")
    public ReclamationDto getRandomReclamation(){
        return service.getRandomReclamation();
    }

}

import 'package:flutter/material.dart';
import 'package:projetfe/Models/Cours.dart';
import 'package:projetfe/ViewModel/CoachingViewModel.dart';
import 'package:projetfe/ViewModel/CoursViewModel.dart';
import 'package:projetfe/formulaireinscri.dart';
import 'package:projetfe/reservation.dart';

// Modèle de données pour représenter un cours
class Course {
  final String name;
  final String time;
  final String instructor;
  bool isEnrolled;

  Course({
    required this.name,
    required this.time,
    required this.instructor,
    this.isEnrolled = false,
  });
}

class CoursePage extends StatefulWidget {
  @override
  _CoursePageState createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {


  CoachingViewModel coachingViewModel = CoachingViewModel();
  // Liste de cours disponibles
  List<Course> courses = [
    Course(name: "Zumba", time: "8:00 AM - 9:00 AM", instructor: "Houssam Khaladi"),
    Course(name: "Musculation", time: "10:00 AM - 11:00 AM", instructor: "zouhier Kouki"),
    Course(name: "Kick Boxing", time: "1:00 PM - 2:00 PM", instructor: "Ahlem Grisset"),
    Course(name: "Gymnastique", time: "3:00 PM - 4:00 PM", instructor: "Haifa Mahjoubi"),
    Course(name: "Karaté", time: "5:00 PM - 6:00 PM", instructor: "Mahmoud Yazidi"),
  ];
  CoursViewModel coursViewModel = CoursViewModel();
  List<Cours> coursList=[];

  @override
  void initState() {
    super.initState();
    loadCours();
  }

  Future<void> loadCours() async {
    try {
      List<Cours> fetchedCours = await coursViewModel.getCours();
      setState(() {
        coursList = fetchedCours;
      });
    } catch (error) {
      print('Error loading cours: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("Cours et Séances d'entraînement",style: TextStyle(fontSize: 20),),
      ),
      body: ListView.builder(
        itemCount: coursList.length + 1, // Ajout d'un élément supplémentaire pour le bouton Coaching Privé
        itemBuilder: (context, index) {
          if (index < coursList.length) {
            final course = coursList[index];
            return ListTile(
              title: Text(course.nom),
              
              subtitle: Text("${coursList[index].dateSeance}\nInstructeur: ${courses[index].instructor}"),
              trailing: ElevatedButton(
                onPressed: () {

                  if(!courses[index].isEnrolled) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>
                          Inscription()), // Remplacez MyPage par votre page de coaching privé
                    );
                  }
                  else{
                    coachingViewModel.desinscriCoaching(course.id.toString());
                  }

                  setState(() {
                    courses[index].isEnrolled = !courses[index].isEnrolled;

                  });
                },
                child: Text(courses[index].isEnrolled ? "Désinscrire" : "S'inscrire"),
              ),
            );
          } else {
            // Retourner le bouton Coaching Privé à la fin de la liste
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyPage()), // Remplacez MyPage par votre page de coaching privé
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  primary: Colors.orange, // Couleur du bouton
                ),
                child: Text(
                  "Coaching Privé",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Naviguer vers la page du calendrier
         Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CalendarPage(courses: courses)),
          );
        },
        child: Icon(Icons.calendar_today),
      ),
    );
  }
}

// Page du calendrier pour visualiser les horaires des cours
class CalendarPage extends StatelessWidget {
  final List<Course> courses;

  CalendarPage({required this.courses});

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("Calendrier des Cours"),
      ),
      body: ListView.builder(
        itemCount: courses.length,
        itemBuilder: (context, index) {
          final course = courses[index];
          return Container(
            color: index.isOdd ? Colors.orange[100] : Colors.white, // Alternance de couleur entre orange et blanc pour chaque ligne
            child: ListTile(
              title: Text(course.name),
              subtitle: Text(course.time),
            ),
          );
        },
      ),
    );
  }
}

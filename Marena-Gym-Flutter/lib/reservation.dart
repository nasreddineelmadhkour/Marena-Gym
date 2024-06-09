import 'package:flutter/material.dart';
import 'package:projetfe/Models/Coachingprive.dart';
import 'package:projetfe/Models/StaticUser.dart';
import 'package:projetfe/ViewModel/CoachingViewModel.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  // Créer une clé globale pour le formulaire
  final _formKey = GlobalKey<FormState>();
  Coachingprive coachingprive = Coachingprive(nom: "nom", email: "email", phone: "phone", date: "date", idCours: "idCours");
  CoachingViewModel coachingViewModel = CoachingViewModel();
  // Créer des contrôleurs pour les champs de texte
  final _nameController = TextEditingController(text: StaticUser.staticUser2.name);
  final _coachController = TextEditingController(text: StaticUser.staticUser2.email);
  final _coursController = TextEditingController(text: StaticUser.staticUser2.telephone);
  final _jourController = TextEditingController();
  final _timeController = TextEditingController();

  @override
  void dispose() {
    // Libérer les ressources des contrôleurs
    _nameController.dispose();
    _coachController.dispose();
    _coursController.dispose();
    _jourController.dispose();
    _timeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Coaching Privé',
          style: TextStyle(color: Colors.orange, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
       
        decoration: BoxDecoration(
          image: DecorationImage(
            opacity: 0.5,
            
            image: AssetImage('assets/images/coachP.jpg',), // Ajoutez ici le chemin de votre image de fond
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.5),
             BlendMode.darken
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Champ pour le nom
                TextFormField(
                  style: TextStyle(color: Colors.white),

                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: ' Nom',
                    labelStyle: TextStyle(color: Colors.orange,fontWeight: FontWeight.bold,), // Modifier la couleur ici

                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Veuillez entrer votre nom';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15.0),
                // Champ pour le nom de l'entraîneur
                TextFormField(

                  style: TextStyle(color: Colors.white),
                  controller: _coachController,
                  decoration: InputDecoration(
                    labelText: "Email",
                        labelStyle: TextStyle(color: Colors.orange,fontWeight: FontWeight.bold), // Modifier la couleur ici

                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Veuillez entrer l'email";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15,),
                TextFormField(

                  style: TextStyle(color: Colors.white),

                  controller: _coursController,
                  decoration: InputDecoration(
                    labelText: "Phone",
                                            labelStyle: TextStyle(color: Colors.orange,fontWeight: FontWeight.bold), // Modifier la couleur ici

                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Veuillez entrer la numéro de téléphone";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15,),
                TextFormField(
                  style: TextStyle(color: Colors.white),

                  controller: _jourController,
                  decoration: InputDecoration(
                    labelText: 'La Cours',
                        labelStyle: TextStyle(color: Colors.orange,fontWeight: FontWeight.bold), // Modifier la couleur ici

                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Veuillez entrer la cours préféré';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),
                // Champ pour le temps préféré
                TextFormField(
                  style: TextStyle(color: Colors.white),

                  controller: _timeController,
                  decoration: InputDecoration(
                    labelText: 'Date d\inscription',
                        labelStyle: TextStyle(color: Colors.orange,fontWeight: FontWeight.bold), // Modifier la couleur ici

                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Veuillez date d\inscription';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),
                // Bouton pour enregistrer les données
                ElevatedButton(
                  onPressed: () {
                    // Valider le formulaire
                    if (_formKey.currentState!.validate()) {
                      // Afficher une snackbar avec les données saisies
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Inscription Coatch privée avec Succes'
                          ),
                        ),
                      );

                      coachingprive.nom= _nameController.text;
                      coachingprive.email=_coachController.text;
                      coachingprive.phone = _coursController.text;
                       coachingprive.idCours= _jourController.text;
                       coachingprive.date = _timeController.text;

                      coachingViewModel.inscriCoachingPrive(coachingprive);


                    }
                  },
                  child: Text('Envoyer',style: TextStyle(color: Colors.white),),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

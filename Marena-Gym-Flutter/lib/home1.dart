// ignore_for_file: prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:projetfe/Models/StaticUser.dart';
import 'package:projetfe/StartingPage.dart';
import 'package:projetfe/ViewModel/UserViewModel.dart';
import 'package:provider/provider.dart';
import 'package:projetfe/ViewModel/ContactViewModel.dart';

class HomePage1 extends StatefulWidget{

 @override 
 _HomePage1 createState()=> _HomePage1();
}

class _HomePage1 extends State<HomePage1> {

      ContactViewModel contactViewModel = ContactViewModel();

      late TextEditingController nameUser = TextEditingController(text: "");
      late TextEditingController contenu = TextEditingController(text: "");



  @override
  void initState(){
      super.initState();
      _fetchReclamation();

  }

@override 
void dispose(){

nameUser.dispose();
contenu.dispose();
super.dispose();
}


 Future<void> _fetchReclamation() async{
  try {
      if(await contactViewModel.getRandomReclamation()){
        setState(() {
          nameUser.text=StaticUser.reclamation.nameUser;
          contenu.text=StaticUser.reclamation.contenu;
        });
          
      }
  }
  catch(erreur){

  }
 }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Image.asset(
            'assets/images/gym_image.jpg',
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          // Container semi-transparent pour assombrir l'image
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.black.withOpacity(0.3), // Opacité 30%
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Informations générales sur la salle de sport
                Text(
                  'Bienvenue à la Salle de Sport ',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Texte en blanc sur fond sombre
                  ),
                ),
                Center(
                  child: Text(
                    'MARINA GYM ',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange.shade900, // Texte en blanc sur fond sombre
                    ),
                  ),
                ),
                SizedBox(height: 80),
                Text(
                  'Adresse : El Alia Rue Amina Bent Wahab, Bizerte, Tunisie',
                  style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Text(
                  'Horaires d\'ouverture :',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.orange.shade900,),
                ),
                Text(
                  'Lundi - Vendredi : 06:00 - 22:00',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                Text(
                  'Samedi - Dimanche : 08:00 - 20:00',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                SizedBox(height: 20),

                // Promotions spéciales/offres spéciales
                Text(
                  'Promotions spéciales :',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.orange.shade900),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.all(10),
                  color: Colors.orange.shade700,
                  child: Text(
                    'Offre spéciale : Abonnement annuel à 20% de réduction !',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                SizedBox(height: 40),

                // Témoignages de clients satisfaits
                Text(
                  'Témoignages de clients satisfaits :',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.orange.shade900),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '« ${contenu.text} »',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '- ${nameUser.text}',
                        style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => StartingPage()),
          );
          // Action à effectuer lors du clic sur le bouton flottant
          // Par exemple, naviguer vers une autre page
        },
        child: Icon(Icons.add), // Icône du bouton flottant, vous pouvez en choisir une autre selon vos besoins
        backgroundColor: Colors.orange.shade700, // Couleur de fond du bouton flottant
      ),
    );
  }
}

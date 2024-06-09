import 'dart:typed_data';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:projetfe/Calendrier.dart';
import 'package:projetfe/Models/StaticUser.dart';
import 'package:projetfe/g%C3%A9rer_profile.dart';

class Utilisateur extends StatefulWidget {
  const Utilisateur({Key? key}) : super(key: key);

  @override
  State<Utilisateur> createState() => _UtilisateurState();
}

class _UtilisateurState extends State<Utilisateur> {

    DateTime? currentBackPressTime;

  @override
  Widget build(BuildContext context) {
    return 
    
    WillPopScope(
      onWillPop: () async {
        // Minimize the app instead of going back
        if (currentBackPressTime == null ||
            DateTime.now().difference(currentBackPressTime!) >
                Duration(seconds: 2)) {
          currentBackPressTime = DateTime.now();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Appuyez de nouveau pour quitter"),
            ),
          );
          return false;
        }
        SystemNavigator.pop();
        return false;
      },
      child:  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange.shade800,
        title: Text("Mon Profil",style: TextStyle(color: Colors.white),),
        centerTitle: true,

      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 115,
              height: 115,
              child: Container(
                height: 125,
                width: 125,
                child: CircleAvatar(
                  backgroundColor: Colors.orange,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                        70), // Set the same radius as the CircleAvatar
                    child: Image.memory(
                      Uint8List.fromList(
                          StaticUser.staticUser2.photo),
                      width: 95,
                      height: 95,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
             Text(
              '${StaticUser.staticUser2.name}',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
             ),
              Text(
              'Age: ${StaticUser.staticUser2.age} ans',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            Text(
              'Taille : ${StaticUser.staticUser2.taille} cm',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            Text(
              'Poids: ${StaticUser.staticUser2.poids} kg',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
             SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                 Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfilePage()),
          );
                // Action for managing profile
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.orange)
              ),
              child: Text('Gérer Profile',
              style: TextStyle(
             color: Colors.white, // Couleur du texte du bouton
               ),
              ),
            ),
            SizedBox(height: 20),
            /*Text(
              'Active Subscriptions:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
              ListTile(
              leading: Icon(Icons.check_circle, color: Colors.green),
              title: Text('Gym Membership'),
              subtitle: Text('Expires on 2025-12-31'),
            ),
            ListTile(
              leading: Icon(Icons.check_circle, color: Colors.green),
              title: Text('Yoga Classes'),
              subtitle: Text('Expires on 2025-12-31'),
            ),*/
            SizedBox(height: 20),
            Text(
              'Payment History:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            ListTile(
              leading: Icon(Icons.payment),
              title: Text('Payment for Gym Membership'),
              subtitle: Text('Date Debut: ${StaticUser.staticUser2.abonnementcreation}, Date Fin :${StaticUser.staticUser2.abonnementexpiration}, Amount: \$50'),
            ),/*
            ListTile(
              leading: Icon(Icons.payment),
              title: Text('Payment for Yoga Classes'),
              subtitle: Text('Date: 2025-03-15, Amount: \$30'),
            ),*/
          ],
        ),
      ),floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Calendrier()),
          );
          // Action à effectuer lors du clic sur le bouton flottant
          // Par exemple, naviguer vers une autre page
        },
        child: Icon(Icons.calendar_today), // Icône du bouton flottant, vous pouvez en choisir une autre selon vos besoins
        backgroundColor: Colors.orange.shade700, // Couleur de fond du bouton flottant
      ),

    ),);
    
     }
}
         
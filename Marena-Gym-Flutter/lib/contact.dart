// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:projetfe/Models/StaticUser.dart';
import 'package:projetfe/ViewModel/ContactViewModel.dart';
import 'package:projetfe/a.dart';

class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {

  ContactViewModel contactViewModel = ContactViewModel();

  final _formKey = GlobalKey<FormState>();

  // Créer des contrôleurs pour les champs de texte
  final _nameController = TextEditingController(text: StaticUser.staticUser2.name);
  final _emailController = TextEditingController(text: StaticUser.staticUser2.email);
  final _messageController = TextEditingController();

  @override
  void dispose() {
    // Libérer les ressources des contrôleurs
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('Contactez-nous',style: TextStyle(fontWeight: FontWeight.bold,fontSize:25 ),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Champ pour le nom
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Nom',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez entrer votre nom';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              // Champ pour l'email
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez entrer votre email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              // Champ pour le message
              TextFormField(
                controller: _messageController,
                decoration: InputDecoration(
                  labelText: 'Message',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez entrer votre message';
                  }
                  return null;
                },
                maxLines: 5,
              ),
              SizedBox(height: 16.0),
              // Bouton pour envoyer le formulaire
              ElevatedButton(
                style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.orange), // Changer la couleur de fond
                // Vous pouvez également ajuster d'autres propriétés comme la couleur du texte, etc.
                ),
                onPressed: () async {
                  // Valider le formulaire
                  if (_formKey.currentState!.validate()) {
                    if(await contactViewModel.addReclamation(_messageController.text)){
                      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ajouter reclamation avec succes'),
            backgroundColor: Colors.green,
          ),
        );

                      Navigator.of(context).push(MaterialPageRoute(builder: (context) =>const Home()));

                    }
                    // Afficher une snackbar avec les données saisies

                  }
                  else{

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Tous les champs obligatoire'
                        ),
                      ),
                    );

                  }
                },
                child: Text('Envoyer',style: TextStyle(color: Colors.black),),
              ),
              SizedBox(height: 20,),
            Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.location_on),
                                    SizedBox(width: 12,),

                    Text("123 Rue de la Forme, Ville, Pays")
              
                  ],
                ),
                            SizedBox(height: 20,),

                Row(
                  children: [
                Icon(Icons.phone),
                SizedBox(width: 12,),
                 Text("(+216)71889658"),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.phone_android),
                    SizedBox(width: 12,),
                    Text("(+216)58553883"),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                  Icon(Icons.mail),
                  SizedBox(width: 12,),
                  Text("contact@marina-gym.com")
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.sports_gymnastics),
                    SizedBox(width: 12,),
                    Text("Marina Gym"),
                  ],
                )
              ],
              
            )
            ],
            
            
          ),
          
        ),
        
      ),
      
    );
  }
}
import 'package:flutter/material.dart';
import 'package:projetfe/ViewModel/ContactViewModel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.orange, // Couleur principale de l'application
        scaffoldBackgroundColor: Colors.orange, // Couleur de fond de l'application
      ),
      home: AvisPage(),
    );
  }
}

class AvisPage extends StatefulWidget {
  const AvisPage({Key? key}) : super(key: key);

  @override
  State<AvisPage> createState() => _AvisPageState();
}

class _AvisPageState extends State<AvisPage> {
  ContactViewModel contactViewModel = ContactViewModel();

  double _rating = 0.0;
  TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('Laisser un Avis',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Note:',
                style: TextStyle(fontSize: 18.0),
              ),
              Slider(
                value: _rating,
                min: 0,
                max: 5,
                divisions: 5,
                onChanged: (value) {
                  setState(() {
                    _rating = value;
                  });
                },
                label: '$_rating',
                activeColor: Colors.orange,
              ),
              SizedBox(height: 20.0),
              Text(
                'Commentaire:',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: _commentController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Entrez votre commentaire',
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  // Logique pour envoyer l'avis
                  print('Note: $_rating, Commentaire: ${_commentController.text}');
                  contactViewModel.addAvis("Note:"+_rating.toString()+" Commentaire : "+_commentController.text);
                  // Réinitialiser les champs après avoir envoyé l'avis
                  setState(() {
                    _rating = 0.0;
                    _commentController.clear();

                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                   SnackBar(
            content: Text('Ajouter avis avec succes'),
            backgroundColor: Colors.green,
            ),
            );

                Navigator.pop(context);
                },
                child: Center(child: Text('Envoyer',style: TextStyle(color: Colors.white),)),
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                  /*padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),*/
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

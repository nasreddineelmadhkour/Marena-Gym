// Importer le package Flutter
import 'package:flutter/material.dart';
import 'package:projetfe/Abonnement.dart';
import 'package:projetfe/Exercices.dart';
import 'package:projetfe/a.dart';
import 'package:projetfe/avis.dart';
import 'package:projetfe/calenetsc.dart';
import 'package:projetfe/contact.dart';
import 'package:projetfe/listReclamation.dart';
import 'package:projetfe/login.dart';
import 'package:projetfe/secondPage.dart';
import 'package:projetfe/sports.dart';

// Définir la fonction principale
void main() {
  runApp(const Imc());
}

// Définir la classe MyApp qui hérite de StatelessWidget
class Imc extends StatelessWidget {
  const Imc({Key? key}) : super(key: key);

  // Redéfinir la méthode build
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // Enlever le bandeau de débogage
      debugShowCheckedModeBanner: false,
      // Définir le titre de l'application
      title: 'Calculateur d\'IMC',
      // Définir le widget racine
      home: HomeScreen(),
    );
  }
}

// Définir la classe HomeScreen qui hérite de StatefulWidget
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  // Redéfinir la méthode createState
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

// Définir la classe _HomeScreenState qui hérite de State<HomeScreen>
class _HomeScreenState extends State<HomeScreen> {
  // Définir le contrôleur du champ de texte associé à la taille
  final _heightController = TextEditingController();

  // Définir le contrôleur du champ de texte associé au poids
  final _weightController = TextEditingController();

  // Définir la variable qui stocke l'IMC
  double? _bmi;

  // Définir la variable qui stocke le message
  String _message = 'Veuillez entrer votre taille et votre poids';

  // Définir la fonction qui est déclenchée quand l'utilisateur appuie sur le bouton "Calculer"
  void _calculate() {
    // Récupérer la valeur de la taille en mètre
    double height = double.parse(_heightController.text) / 100;

    // Récupérer la valeur du poids en kilogramme
    double weight = double.parse(_weightController.text);

    // Calculer l'IMC selon la formule : IMC = poids / taille^2
    double result = weight / (height * height);

    // Affecter le résultat à la variable _bmi
    _bmi = result;

    // Déterminer le message selon la valeur de l'IMC
    if (_bmi! < 18.5) {
      _message = 'Vous êtes en insuffisance pondérale';
    } else if (_bmi! < 25) {
      _message = 'Vous avez un poids normal';
    } else if (_bmi! < 30) {
      _message = 'Vous êtes en surpoids';
    } else {
      _message = 'Vous êtes en obésité';
    }

    // Mettre à jour l'état du widget
    setState(() {});
  }

  // Redéfinir la méthode build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Calculer votre IMC',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 
        25,color: Colors.black),),
        backgroundColor: Colors.orange,
      ),
      // Définir la couleur de fond
      backgroundColor: Colors.white,
      // Définir le corps du widget
      drawer: Drawer(
        child: Container(
          color: Colors.white,
          child: ListView(
            children: [
              DrawerHeader(
                child: Center(
                  child: Image.asset("assets/images/logo.jpg"),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.monitor_weight),
                title: const Text(
                  'Home',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const Home(),
                  ));
                },
              ),
              ListTile(
                leading: const Icon(Icons.contact_page),
                title: const Text(
                  'Contact',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ContactPage(),
                  ));
                },
              ),
              ListTile(
                leading: const Icon(Icons.error),
                title: const Text(
                  'List Reclamation',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ListReclamation(),
                  ));
                },
              ),
              ListTile(
                leading: const Icon(Icons.health_and_safety),
                title: const Text(
                  'Bien-etre et Santé',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const Scendpage(),
                  ));
                },
              ),
              ListTile(
                leading: const Icon(Icons.sports_gymnastics_sharp),
                title: const Text(
                  'Exercies individuelle',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ExercisePage(),
                  ));
                },
              ),
              ListTile(
                leading: const Icon(Icons.sports_bar_outlined),
                title: const Text(
                  'Sports',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SportsPage(),
                  ));
                },
              ),
              ListTile(
                leading: const Icon(Icons.home_repair_service),
                title: const Text(
                  'Planification',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CoursePage(),
                  ));
                },
              ),
              ListTile(
                leading: const Icon(Icons.money_rounded),
                title: const Text(
                  'Tarif',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SubscriptionPage(),
                  ));
                },
              ),
              ListTile(
                leading: const Icon(Icons.message_outlined),
                title: const Text(
                  'Avis',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AvisPage(),
                  ));
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout,color: Colors.red),
                title: const Text(
                  'Déconnexion',
                  style: TextStyle(fontSize: 20,color: Colors.red),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ));
                },
              ),
            ],
          ),
        ),
      ),
      body: Center(
        // Utiliser un SizedBox pour limiter la largeur du widget
        child: SizedBox(
          width: 320,
          // Utiliser un Card pour créer un effet d'élévation
          child: Card(
            color: Colors.white,
            elevation: 10,
            // Utiliser un Padding pour créer un espace autour du contenu
            child: Padding(
              padding: const EdgeInsets.all(20),
              // Utiliser un Column pour aligner les widgets verticalement
              child: Column(
                // Utiliser la taille minimale nécessaire
                mainAxisSize: MainAxisSize.min,
                // Définir les widgets enfants
                children: [
                  // Utiliser un TextField pour saisir la taille
                  TextField(
                    // Utiliser un clavier numérique avec la possibilité d'entrer des décimales
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    // Utiliser un InputDecoration pour afficher un label
                    decoration: const InputDecoration(labelText: 'Taille (m)'),
                    // Utiliser le contrôleur défini précédemment
                    controller: _heightController,
                  ),
                  // Utiliser un TextField pour saisir le poids
                  TextField(
                    // Utiliser un clavier numérique avec la possibilité d'entrer des décimales
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    // Utiliser un InputDecoration pour afficher un label
                    decoration: const InputDecoration(
                      labelText: 'Poids (kg)',
                    ),
                    // Utiliser le contrôleur défini précédemment
                    controller: _weightController,
                  ),
                  const SizedBox(height: 20,),
                  // Utiliser un ElevatedButton pour créer un bouton
                  
                  ElevatedButton(
                    // Utiliser la fonction définie précédemment comme gestionnaire d'événement
                    onPressed: _calculate,
                    // Utiliser un Text pour afficher le libellé du bouton
                    child: const Text('Calculer',style: TextStyle(color: Colors.white),),
                    style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.orange), // Changer la couleur de fond
                    // Vous pouvez également ajuster d'autres propriétés comme la couleur du texte, etc.
                    ),
                    
                  ),
                  // Utiliser un SizedBox pour créer un espace vertical
                  const SizedBox(
                    height: 30,
                  ),
                  // Utiliser un Text pour afficher le résultat ou le message
                  Text(
                    // Utiliser une expression conditionnelle pour afficher l'IMC si il est non nul, sinon afficher le message
                    _bmi == null
                        ? _message
                        : 'Votre IMC est de ${_bmi!.toStringAsFixed(2)}\n$_message',
                    // Utiliser un TextStyle pour modifier l'apparence du texte
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 19.4,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
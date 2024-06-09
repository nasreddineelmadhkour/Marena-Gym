import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projetfe/Abonnement.dart';
import 'package:projetfe/Calendrier.dart';
import 'package:projetfe/Exercices.dart';
import 'package:projetfe/avis.dart';
import 'package:projetfe/calenetsc.dart';
import 'package:projetfe/contact.dart';
import 'package:projetfe/imc.dart';
import 'package:projetfe/listReclamation.dart';
import 'package:projetfe/login.dart';
import 'package:projetfe/secondPage.dart';
import 'package:projetfe/sports.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       /* leading: IconButton(onPressed: (){
          Navigator.pushReplacement(context, CupertinoModalPopupRoute(builder: (((context) => Calendrier()))));

        }, icon: const Icon(CupertinoIcons.back)),*/
        backgroundColor: Color.fromARGB(255, 249, 145, 9),
        centerTitle: true,
        title: const Text("M A R E N A - G Y M"),
      ),
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
                  'IMC',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
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
      body: Column(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset(
                  "assets/images/fp1.jpg",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedDefaultTextStyle(
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black, // Initial color
                  ),
                  duration: Duration(milliseconds: 1000), // Animation duration
                  curve: Curves.easeInExpo, // Animation curve
                  child: Text(
                    "Bienvenue à M A R E N A - G Y M",style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 10), // Adjust spacing as needed
                AnimatedDefaultTextStyle(
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black, // Initial color
                  ),
                  duration: Duration(milliseconds: 500), // Animation duration
                  curve: Curves.easeInOut, // Animation curve
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(),
                      child: Text(
                        "'Le sport un voyage vers la meilleure version de vous-même'",
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset(
                  "assets/images/fp2.jpeg",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
           IconButton(onPressed: (){
          Navigator.pushReplacement(context, CupertinoModalPopupRoute(builder: (((context) => Calendrier()))));

        }, icon: const Icon(CupertinoIcons.back)),
        ],
      ),
    );
  }
}

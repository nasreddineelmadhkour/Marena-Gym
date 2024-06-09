import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:projetfe/Models/Cours.dart';
import 'package:projetfe/ViewModel/CoursViewModel.dart';


class SportsPage extends StatefulWidget {
  @override
  _SportsPageState createState() => _SportsPageState();
}

class _SportsPageState extends State<SportsPage> {
  final CoursViewModel coursViewModel = CoursViewModel();
  List<Cours> coursList = [];

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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(
          'Sports',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: coursList.length,
        itemBuilder: (ctx, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SportDetailsPage(sport: coursList[index]),
                ),
              );            },
            child: Card(
              elevation: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    child: ClipRect(
                      child: Image.memory(
                        Uint8List.fromList(coursList[index].photo),
                        fit: BoxFit.cover,
                        width: width, // Example width
                        //height: 70, // Example height
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      coursList[index].nom,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class SportDetailsPage extends StatelessWidget {
  final Cours sport;

  SportDetailsPage({required this.sport});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    List<String> infoParts = sport.nom.split('. ');
    String durationInfo = '';
    String benefitsInfo = '';
    String advantagesInfo = '';

    if (infoParts.length > 0) {
      durationInfo = infoParts[0];
    }
    if (infoParts.length > 1) {
      benefitsInfo = infoParts[1];
    }
    if (infoParts.length > 2) {
      advantagesInfo = infoParts[2];
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(sport.nom),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child:ClipRect(
                child: Image.memory(
                  Uint8List.fromList(sport.photo),
                  fit: BoxFit.cover,
                  width: width, // Example width
                  height: 300, // Example height
                ),
              ) ,
            ),

            SizedBox(height: 20),


            ListTile(
                leading: Icon(Icons.description,size: 35),
                iconColor: Colors.orange,
                title: Text('Description',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
                subtitle: Text(sport.description),
            ),
            SizedBox(height: 10),

            SizedBox(height: 10),
            /*ListTile(
              leading: Icon(sport.durationIcon),
              iconColor: Colors.orange,
              title: Text('Durée'),
              subtitle: Text(durationInfo),
            ),
            ListTile(
              leading: Icon(sport.benefitsIcon),
              iconColor: Colors.orange,

              title: Text('Bienfaits pour la santé'),
              subtitle: Text(benefitsInfo),
            ),
            ListTile(
              leading: Icon(sport.advantagesIcon),
              iconColor: Colors.orange,
              title: Text('Avantages'),
              subtitle: Text(advantagesInfo),
            ),*/
          ],
        ),
      ),
    );
  }
}

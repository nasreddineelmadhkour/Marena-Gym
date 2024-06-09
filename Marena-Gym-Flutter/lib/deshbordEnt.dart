import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:projetfe/Models/StaticUser.dart';
import 'package:projetfe/ViewModel/CoachingViewModel.dart';
import 'package:projetfe/g%C3%A9reeProfileEnt.dart';
import 'package:projetfe/login.dart';
import 'package:flutter/services.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  DateTime? currentBackPressTime;
  CoachingViewModel coachingViewModel = CoachingViewModel();
  List<dynamic> data2 = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    data2 = await coachingViewModel.getReservation();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
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
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: Text(
            'Entraineur Dashboard',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ));
              },
              icon: Icon(Icons.logout, color: Colors.white),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                        Uint8List.fromList(StaticUser.staticUser2.photo),
                        width: 95,
                        height: 95,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                '${StaticUser.staticUser2.name}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePageEnt()),
                  );
                  // Action for managing profile
                },
                style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.orange)),
                child: Text(
                  'Gérer Profile',
                  style: TextStyle(
                    color: Colors.white, // Couleur du texte du bouton
                  ),
                ),
              ),
              SizedBox(height: 40),
              Text(
                'Emploi du Temps:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: data2.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(
                          data2[index]['dateseance'], // Assuming date is provided in the API response
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Type: ${data2[index]['type']}', // Assuming type is provided in the API response
                            ),
                            Text(
                              'Activité: ${data2[index]['nom']}', // Assuming activity name is provided in the API response
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:projetfe/Models/StaticUser.dart';
import 'package:projetfe/User.dart';
import 'package:projetfe/a.dart';
import 'package:table_calendar/table_calendar.dart';

void main() {
  runApp(Calendrier());
}

class Calendrier extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calendrier Abonnement',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: SubscriptionCalendarPage(),
    );
  }
}

class SubscriptionCalendarPage extends StatefulWidget {
  @override
  _SubscriptionCalendarPageState createState() =>
      _SubscriptionCalendarPageState();
}

class _SubscriptionCalendarPageState extends State<SubscriptionCalendarPage> {
  late DateTime _selectedDate;
  late CalendarFormat _calendarFormat;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _calendarFormat = CalendarFormat.month;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendrier Abonnement'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Utilisateur()),
            );


          },
        ),
      ),
      body: Column(
        children: <Widget>[
          TableCalendar(
            focusedDay: _selectedDate,
            firstDay: StaticUser.staticUser2.abonnementcreation,
            lastDay: StaticUser.staticUser2.abonnementcreation.add(Duration(days: 29)),
            calendarFormat: _calendarFormat,
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            headerStyle: HeaderStyle(
              titleCentered: true,
            ),
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.5),
                shape: BoxShape.rectangle,
              ),
              selectedDecoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                shape: BoxShape.circle,
              ),
              selectedTextStyle: TextStyle(color: Colors.white),
            ),
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, date, _) {
                // Check if the date is within the next 30 days
                if (date.isBefore(DateTime.now().add(Duration(days: 30)))) {
                  // Change color for the next 30 days
                  return Container(
                    margin: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.5), // Change color here
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '${date.day}',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  );
                } else {
                  // Return default cell for other days
                  return null;
                }
              },
            ),
          ),
          SizedBox(height: 20,),
          ElevatedButton(
            onPressed: () {
              // Votre logique ici lorsque l'utilisateur appuie sur le bouton
              Navigator.of(context).push(MaterialPageRoute(builder: (context) =>const Home()));

            },
            style: ElevatedButton.styleFrom(
              primary: Colors.orange, // Couleur de fond du bouton
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              fixedSize: Size(50, 50),
              // Autres propriétés de style ici
            ),
            child: Icon(
              Icons.arrow_forward,
              color: Colors.white,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}


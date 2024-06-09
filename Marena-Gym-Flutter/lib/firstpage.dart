// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:projetfe/reservation.dart';
// ignore: unused_import

class Firstpage extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const Firstpage({Key? key});

  @override
  State<Firstpage> createState() => _FirstpageState();
}

class _FirstpageState extends State<Firstpage> {
  final Map<String, List<String>> _schedule = {
    'Monday': [
      '8:30 AM: BodyPump',
      '11:00 AM: ABDOS',
      '18:30 PM: TRX, BodyPump, Boxing',
      '8:30 PM: BodyAttack, Boxing'
    ],
    'Tuesday': [
      '8:30 AM: BodyPump',
      '11:30 AM: ABDOS',
      '18:30 PM: Circuit Minceur, BodyPump, Dance Oriental',
      '9:30 PM: RPM, BodyCombat'
    ],
    'Wednesday': [
      '8:30 AM: BodyPump',
      '11:00 AM: ABDOS',
      '18:30 PM: Boxing, BodyAttack, Step',
      '20:00 PM: Boxing, ABDOS',
      '22:00 PM: TRX'
    ],
    'Thursday': [
      '8:30 AM: BodyPump',
      '11:00 AM: ABDOS',
      '18:30 PM: Circuit Minceur',
      '19:30 PM: BodyCombat',
      '20:30 PM: Cross Training'
    ],
    'Friday': [
      '8:30 AM: BodyPump',
      '11:00 AM: ABDOS',
      '18:30 PM: TRX',
      '19:30 PM: Tabata',
      '20:30 PM: Pilates'
    ],
    'Saturday': [
      'Morning: Yoga, Cross Kids',
      '12:30 PM: Boxing, BodyPump',
      '18:30 PM: Step',
      '19:30 PM: ABDOS',
      '20:30 PM: Pilates'
    ],
    'Sunday': [
      '10:00 AM: Boxing',
      '11:00 AM: Cross Kids',
      '12:00 PM: Gym for Fillettes',
      '13:00 PM: Born to Move'
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('Training Schedule'),
        centerTitle: true,
        actions: [
          TextButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: ((context) => MyPage())));
          }, 
          style: TextButton.styleFrom(
             backgroundColor: Colors.white, // Couleur de fond du bouton
            shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // Bord arrondi du bouton
            side: BorderSide(color: Colors.white), // Contour du bouton
    ),
  ),
          child: 
          Text("Coaching Privé",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
          ),
        ],
        
      ),
      body: ListView.separated(
        itemCount: _schedule.length,
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemBuilder: (BuildContext context, int index) {
          String day = _schedule.keys.elementAt(index);
          List<String> timeSlots = _schedule[day]!;
          return ExpansionTile(
            title: Text(day),
            children: timeSlots.map<Widget>((timeSlot) {
              return InkWell(
                onTap: () {
                 // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MyPage()));
                  // ignore: avoid_print
                  print('Clique sur le créneau horaire: $timeSlot');
                },
                child: ListTile(
                  title: Text(timeSlot),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
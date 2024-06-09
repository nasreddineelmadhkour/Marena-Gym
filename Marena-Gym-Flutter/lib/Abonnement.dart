import 'package:flutter/material.dart';

class Abonnement extends StatelessWidget {
  const Abonnement({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     debugShowCheckedModeBanner: false,
      title: 'Abonnement Salle de Sport' ,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: SubscriptionPage(),
    );
  }
}

class SubscriptionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
backgroundColor: Colors.orange,
        title: Text('Abonnement Salle de Sport'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(child: Image.asset("assets/images/tarif.png"),)
                ],

              ),
              SizedBox(height: 20),
              SubscriptionCard(
                title: 'Abonnement mensuel',
                price: '\50d',
                description: 'Accès illimité à la salle de sport pendant un mois.',
              ),
              SubscriptionCard(
                title: 'Abonnement trimestriel',
                price: '\140d',
                description: 'Accès illimité à la salle de sport pendant trois mois.',
              ),
              SubscriptionCard(
                title: 'Abonnement annuel',
                price: '\560d',
                description: 'Accès illimité à la salle de sport pendant un an.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SubscriptionCard extends StatelessWidget {
  final String title;
  final String price;
  final String description;

  const SubscriptionCard({
    Key? key,
    required this.title,
    required this.price,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Prix : $price',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              description,
              style: TextStyle(fontSize: 14),
            ),
            
          ],
        ),
      ),
    );
  }
}
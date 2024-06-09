import 'package:flutter/material.dart';

class TipsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(
          'Conseils pour les Sportifs',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTipCard(
              title: 'Échauffez-vous avant l\exercice',
              content:
                  'Il est important de faire un échauffement avant de commencer votre séance d\'entraînement pour préparer vos muscles et réduire le risque de blessures.',
              imagePath: 'assets/images/ech.jpg',
            ),
            _buildTipCard(
              title: 'Hydratez-vous régulièrement',
              content:
                  'Buvez de l\'eau avant, pendant et après votre séance d\'entraînement pour rester hydraté et maintenir de bonnes performances.',
              imagePath: 'assets/images/eau.jpg',
            ),
            _buildTipCard(
              title: 'Écoutez votre corps',
              content:
                  'Apprenez à reconnaître les signes de fatigue ou de douleur et ne poussez pas votre corps au-delà de ses limites. Accordez-vous le repos nécessaire.',
              imagePath: 'assets/images/corps.jpg',
            ),
            _buildTipCard(
              title: 'Adoptez une alimentation équilibrée',
              content:
                  'Une alimentation saine et équilibrée est essentielle pour soutenir vos séances d\'entraînement et favoriser la récupération musculaire.',
              imagePath: 'assets/images/pyramide.jpg',
            ),
            _buildTipCard(
              title: 'Variez vos entraînements',
              content:
                  'Changez régulièrement votre routine d\'exercice pour éviter l\'ennui et stimuler votre progression. Intégrez différents types d\'exercices et de modalités.',
            imagePath: 'assets/images/entr.jpg',

            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTipCard(
      {required String title,
      required String content,
      required String imagePath}) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(
            imagePath,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  content,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class NutritionTipsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('Conseils Alimentaires pour les Sportifs',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTipCard(
              title: 'Hydratez-vous',
              content:
                  'Buvez suffisamment d\'eau tout au long de la journée pour maintenir une hydratation adéquate. L\'eau est essentielle pour la performance et la récupération.',
              imagePath: 'assets/images/1.jpg',
            ),
            _buildTipCard(
              title: 'Consommez des protéines maigres',
              content:
                  'Les protéines sont importantes pour la construction et la réparation musculaire. Choisissez des sources de protéines maigres comme le poulet, le poisson et les légumineuses.',
              imagePath: 'assets/images/3.jpg',
            ),
            _buildTipCard(
              title: 'Mangez des fruits et légumes',
              content:
                  'Les fruits et légumes sont riches en nutriments essentiels, en antioxydants et en fibres. Ils soutiennent la santé globale et favorisent la récupération.',
              imagePath: 'assets/images/4.jpg',
            ),
            _buildTipCard(
              title: 'Évitez les aliments transformés',
              content:
                  'Limitez votre consommation d\'aliments transformés riches en sucres ajoutés, en gras saturés et en additifs. Privilégiez les aliments naturels et non transformés.',
              imagePath: 'assets/images/5.jpg',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTipCard({required String title, required String content, required String imagePath}) {
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

import 'package:flutter/material.dart';

class Temperature extends StatefulWidget {
  const Temperature({super.key});

  @override
  State<Temperature> createState() => _TemperatureState();
}

class _TemperatureState extends State<Temperature> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(
          'Température ',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        
      ),
       body: Center(
          child: Stack(
            children: [
              
              // Photo au milieu de la page
              Positioned.fill(
                child: Image.asset(
                  'assets/images/temp.jpg', // Remplacez par le chemin de votre photo
                  fit: BoxFit.cover,
                ),
              ),
              // Bouton orange centré
              Positioned(
                bottom: 50, // Ajustez la position du bouton comme vous le souhaitez
                left: 0,
                right: 0,
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Action lorsque le bouton est appuyé
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.orange, // Couleur orange
                    ),
                    child: Text(
                      'Démarrer',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    
  }
}
    
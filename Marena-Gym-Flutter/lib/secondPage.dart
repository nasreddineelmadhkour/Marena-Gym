import 'package:flutter/material.dart';
import 'package:projetfe/Conseils.dart';
import 'package:projetfe/aliments.dart';
import 'package:projetfe/battement.dart';
import 'package:projetfe/temerature.dart';

class Scendpage extends StatefulWidget {
  const Scendpage({Key? key}) : super(key: key);

  @override
  State<Scendpage> createState() => _ScendpageState();
}

class _ScendpageState extends State<Scendpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text("Bien-être et Santé",style:TextStyle(color: Colors.orange),),

      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 200,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/conseil.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      width: 150.0, // width of the circular button
                    height: 100.0, // height of the circular button
                    decoration: BoxDecoration(
                      shape: BoxShape.circle),
                      //color: Colors.white.withOpacity(0.5),
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>TipsPage(),));
                        },
                        child: Text(
                          "Consulter",
                          style: TextStyle(
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              height: 200,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/alimentation.jpg",),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      width: 200, // width of the circular button
                    height: 50, // height of the circular button
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,),
                      //color: Colors.white.withOpacity(0.5),
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>NutritionTipsPage(),));
                        },
                        child: Text(
                          "Consulter",
                          style: TextStyle(
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              height: 200,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/battement.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      width: 200, // width of the circular button
                    height: 50, // height of the circular button
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,),
                     // color: Colors.white.withOpacity(0.5),
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>Battement(),));
                        },
                        child: Text(
                          "Consulter",
                          style: TextStyle(
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              height: 200,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/température.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      width: 200, // width of the circular button
                    height: 50, // height of the circular button
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,),
                      //color: Colors.white.withOpacity(0.5),
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>Temperature(),));
                        },
                        child: Text(
                          "Consulter",
                          style: TextStyle(
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

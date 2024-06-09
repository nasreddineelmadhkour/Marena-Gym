import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projetfe/login.dart';
import 'package:projetfe/sign_up.dart';

class StartingPage extends StatelessWidget {
  const StartingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text("Bienvenue sur l'App Sports!!",style: TextStyle(color: Colors.orange,fontSize: 30,fontWeight: FontWeight.bold),),
              SizedBox(height: 80), // Espacement entre le titre et l'image
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/images/logo.jpg'), // Remplacez 'assets/image.jpg' par le chemin de votre image
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Text(
                  'Marena Gym',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: Color(0xFFDA6C0C)),
                ),
                SizedBox(height:100 ,),
                TextButton(onPressed: (){
                 Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => LoginScreen(),));
                }, 
                child: const Text("Sign in",style:TextStyle(color:Colors.orangeAccent,fontWeight: FontWeight.bold,fontSize: 20 ) ,),
                style: OutlinedButton.styleFrom(
                side:const BorderSide(color: Color(0xFFDA6C0C)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                ),),
                /*
                TextButton(onPressed: (){
                 Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>SignUpPage(),));
                }, 
                child: const Text("Sign up",style:TextStyle(color:Colors.orangeAccent,fontWeight: FontWeight.bold,fontSize: 20 ) ,),
                style: OutlinedButton.styleFrom(
                side:const BorderSide(color: Color(0xFFDA6C0C)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                ),),*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}
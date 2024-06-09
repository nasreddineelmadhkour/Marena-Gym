import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projetfe/Models/StaticUser.dart';
import 'package:projetfe/Models/User.dart';
import 'package:projetfe/ViewModel/UserViewModel.dart';
import 'package:projetfe/login.dart';

class ProfilePageEnt extends StatefulWidget {
  const ProfilePageEnt({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePageEnt> {
  UserViewModel userViewModel = UserViewModel();
  TextEditingController _firstNameController = TextEditingController(text: StaticUser.staticUser2.name);
  TextEditingController _lastNameController = TextEditingController(text: StaticUser.staticUser2.email);
  TextEditingController _ageController = TextEditingController();
  TextEditingController _heightController = TextEditingController(text: StaticUser.staticUser2.birth_date.toString());
  TextEditingController _poidController = TextEditingController(text: StaticUser.staticUser2.adresse);
  File? _imageFile = null;
  User user = User(
    id: 0,
    name: "name",
    taille: 0,
    poids: 0,
    adresse: "adresse",
    accessToken: "accessToken",
    photo: Uint8List(0),
    username: "username",
    telephone: "",
    email: "email",
    password: "password",
    roles: ["role"],
    birth_date: DateTime.now(),
    age: 0,
    abonnementcreation: DateTime.now(),
    abonnementexpiration: DateTime.now()
  );

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _ageController.dispose();
    _heightController.dispose();
    _poidController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('Gérer le profil',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: width,
                    height: 115,
                    child: Container(
                      height: 125,
                      width: 125,
                      child: CircleAvatar(
                        backgroundColor: Colors.orange,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                              70), // Set the same radius as the CircleAvatar
                          child:  _imageFile != null
                              ? Image.file(
                            _imageFile!,
                            width: 95,
                            height: 95,
                            fit: BoxFit.cover,

                          )
                              : Image.memory(
                            Uint8List.fromList(
                                StaticUser.staticUser2.photo),
                            width: 95,
                            height: 95,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: width/2 +(25),
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        //    color: ColorTheme.principalTeal
                      ),
                      child: GestureDetector(
                        onTap: () {
                          _selectImage(); // Call function to select image
                        },
                        child: Icon(
                          Icons.camera_alt,
                          // color: ColorTheme.backgroundNormalColor,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),
              Text(
                'Nom',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: _firstNameController,
                decoration: InputDecoration(
                  hintText: 'Entrez votre nom',
                ),
              ),/*
              SizedBox(height: 20),
              Text(
                'Email',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: _lastNameController,
                decoration: InputDecoration(
                  hintText: 'Entrez votre Email',
                ),
              ),*/
              /*SizedBox(height: 20),
              Text(
                'Password',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: _ageController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: 'Entrez votre password',
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Date de Naissance',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: _heightController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: 'Entrez votre date de naissance',
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Adresse',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: _poidController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: 'Entrez votre Adresse',
                ),
              ),*/
              SizedBox(height: 20),
             Center(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      ElevatedButton(
        onPressed: () async {

          user.name = _firstNameController.text;
          user.email = _lastNameController.text;
          user.password= _ageController.text;
          user.telephone = _heightController.text;
          user.adresse = _poidController.text;

          if( await userViewModel.updateE(user, _imageFile!)){
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
            print("hello update");
          }



          // Ajouter la logique pour enregistrer les modifications du profil
        },
        style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Colors.orange),
    ),
        child: Text('Enregistrer les modifications',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
      ),
    ],
  ),
),

            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(
        source: ImageSource
            .gallery); // You can also use ImageSource.camera for capturing from camera
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }
}

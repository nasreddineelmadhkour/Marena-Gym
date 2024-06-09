
import 'dart:convert';
import 'dart:typed_data';

import 'package:projetfe/Models/Login.dart';
import 'package:projetfe/Models/Reclamation.dart';
import 'package:projetfe/Models/User.dart';


class StaticUser{
  // Static field
  static User staticUser = User(
      id: 0,
      name: "name",
      taille: 0,
      poids: 0,
      adresse: "adresse",
      accessToken: "accessToken",
      photo: Uint8List(0),
      telephone: "telephone",
      username: "username",
     // codeTel: "codeTel",
     // resetToken: "resetToken",
      email: "email",
      password: "password",
      roles: ["role"],
      birth_date: DateTime.now(),
      age: 0,
      abonnementcreation: DateTime.now(),
      abonnementexpiration: DateTime.now()
  );

  static User staticUser2 = User(
      id: 0,
      name: "name",
      taille: 0,
      poids: 0,
      adresse: "adresse",
      accessToken: "accessToken",
      photo: Uint8List(0),
      telephone: "telephone",
      username: "username",
      // codeTel: "codeTel",
      // resetToken: "resetToken",
      email: "email",
      password: "password",
      roles: ["role"],
      birth_date: DateTime.now(),
      age: 0,
       abonnementcreation: DateTime.now(),
       abonnementexpiration: DateTime.now()
  );


  static Login staticLogin = Login(id: 0, accessToken: "", username: "", email: "", roles: []);

  static Reclamation reclamation = Reclamation(nameUser: "nameUser", contenu: "contenu") ;
}


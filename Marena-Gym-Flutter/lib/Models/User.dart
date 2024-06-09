import 'dart:convert';
import 'dart:typed_data';

import 'package:projetfe/Models/StaticMethode.dart';

class User {
  late int id;
  late String name;
  late int taille;
  late int poids;
  late String adresse;
  late String accessToken;
  late Uint8List photo;
  late String telephone;
  late String username;
  //late String codeTel;
  //late String resetToken;
  late String email;
  late String password;
  late List<String> roles; // Change type to List<String>
  late int age;
  //late String activateCode;
  late DateTime birth_date;
  late DateTime abonnementcreation;
  late DateTime abonnementexpiration;

  User({
    required this.id,
    required this.name,
    required this.taille,
    required this.poids,
    required this.adresse,
    required this.accessToken,
    required this.photo,
    required this.telephone,
    required this.username,

    //required this.codeTel,
    //required this.resetToken,
    required this.email,
    required this.password,
    required this.roles, // Update constructor parameter
    required this.birth_date,
    required this.age,
    required this.abonnementcreation,
    required this.abonnementexpiration,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'taille':taille,
      'poids':poids,
      'adresse':adresse,
      'accessToken': accessToken,
      'photo': photo,
      'telephone': telephone,
      'username': username,
      //'codeTel': codeTel,
      //'resetToken': resetToken,
      'email': email,
      'password': password,
      //'activateCode': activateCode,
      'birth_date': birth_date.toIso8601String(),
      'age':age,
      'roles': roles,
      'abonnementcreation': abonnementcreation.toIso8601String(),
      'abonnementexpiration': abonnementexpiration.toIso8601String(),
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      taille: json['taille'] ?? 0,
      poids: json['poids'] ?? 0,
      adresse: json['adresse'] ?? '',

      accessToken: json['accessToken'] ?? '',
      photo: base64.decode(json['photo']),
      telephone: json['telephone'] ?? '',
      username : json['username']??'',
      //codeTel: json['codeTel'] ?? '',
      //resetToken: json['resetToken'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      roles: List<String>.from(json['roles']), // Parse 'roles' as a List<String>
      birth_date: StaticMethode.parseDateString(json['birth_date'] ?? ''),
      age: json['age']?? 0,
      abonnementcreation: StaticMethode.parseDateString(json['abonnementcreation'] ?? ''),
      abonnementexpiration: StaticMethode.parseDateString(json['abonnementexpiration'] ?? ''),
    );
  }
}

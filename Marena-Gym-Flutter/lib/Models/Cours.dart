

import 'dart:convert';
import 'dart:typed_data';

import 'package:projetfe/Models/StaticMethode.dart';

class Cours {

  int id;
  String nom;
  Uint8List photo;
  String type ;
  String description;
  DateTime dateSeance;


  Cours({
    required this.id,
    required this.nom,
    required this.photo,
    required this.type,
    required this.description,
    required this.dateSeance
  });


  factory Cours.fromJson(Map<String, dynamic> json) {
    return Cours(
      id: json['id'],
      nom: json['nom'],
      photo: base64.decode(json['photo']), // Convert base64 string to bytes
      type: json['type'],
      description: json['description'],
      dateSeance: StaticMethode.parseDateString(json['dateSeance'] ?? ''),
    );
  }
}
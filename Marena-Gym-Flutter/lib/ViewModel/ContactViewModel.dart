import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:projetfe/Models/Reclamation.dart';
import 'package:projetfe/Models/StaticUser.dart';
import 'package:projetfe/Netwrok/BaseURL.dart';

class ContactViewModel extends ChangeNotifier {


  Future<bool> addReclamation(String message) async {
    notifyListeners();

    final String apiUrl = BaseURL.baseURL+'/api/reclamation/add-Reclamation/${StaticUser.staticUser2.id}';


    try {

      final response = await http.post(
        Uri.parse(apiUrl),
        body: jsonEncode({
          'contenu': message,
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${StaticUser.staticLogin.accessToken}',

        },
      );

      if (response.statusCode == 200) {
        print("envoyer avec succes");
        notifyListeners();
        return true;
      } else {
        print('Envoyer failed. Status code: ${response.statusCode}');
        notifyListeners();
        return false;
      }
    } catch (error) {
      print('Error during Envoyer: $error');
      notifyListeners();
      return false;
    }
  }

  Future<bool> addAvis(String commentaire) async {
    notifyListeners();

    final String apiUrl = BaseURL.baseURL+'/api/cour/add-avis/${StaticUser.staticUser2.id}';


    try {

      final response = await http.post(
        Uri.parse(apiUrl),
        body: jsonEncode({
          'contenuavis': commentaire,
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${StaticUser.staticLogin.accessToken}',

        },
      );

      if (response.statusCode == 200) {
        print("envoyer avec succes");
        notifyListeners();
        return true;
      } else {
        print('Envoyer failed. Status code: ${response.statusCode}');
        notifyListeners();
        return false;
      }
    } catch (error) {
      print('Error during Envoyer: $error');
      notifyListeners();
      return false;
    }
  }

  Future<bool> getRandomReclamation() async {
    notifyListeners();
    try {

        final response = await http.get(
          Uri.parse(BaseURL.baseURL+'/api/reclamation/randomReclamation'),
          headers: {
            'Content-Type': 'application/json',
          },
        );
         StaticUser.reclamation= Reclamation.fromJson(json.decode(response.body));

         return true;

    } catch (error) {
      print('Error during reclamation: $error');
      notifyListeners();
      return false;
    }
  }

}

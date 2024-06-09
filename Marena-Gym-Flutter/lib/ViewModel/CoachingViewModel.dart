
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:projetfe/Models/Coachingprive.dart';
import 'package:projetfe/Models/StaticUser.dart';
import 'package:projetfe/Netwrok/BaseURL.dart';
import 'package:http/http.dart' as http;

class CoachingViewModel extends ChangeNotifier{


  Future<bool> inscriCoachingPrive(Coachingprive coachingprive) async {
    notifyListeners();

    final String apiUrl = BaseURL.baseURL+'/api/cour/reservercours/${coachingprive.idCours}';
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: jsonEncode({
          'email':coachingprive.email,
          'nom':coachingprive.nom,
          'phone':coachingprive.phone,
          'dateSeanceprive': coachingprive.date
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


  Future<bool> inscriCoaching(Coachingprive coachingprive) async {
    notifyListeners();

    final String apiUrl = BaseURL.baseURL+'/api/cour/inscritcours/${coachingprive.idCours}';


    try {

      final response = await http.post(
        Uri.parse(apiUrl),
        body: jsonEncode({
          'email':coachingprive.email,
          'nom':coachingprive.nom,
          'phone':coachingprive.phone,
          'dateInscrit': coachingprive.date

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


  Future<bool> desinscriCoaching(String idCours) async {
    notifyListeners();

    final String apiUrl = BaseURL.baseURL+'/api/cour/deleteinscritcourbyid/${idCours}';
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
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


  Future<List<dynamic>> getInsci() async {
    final String apiUrl = BaseURL.baseURL + '/api/cour/allinscri';
    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${StaticUser.staticLogin.accessToken}',
        },
      );
      if (response.statusCode == 200) {
          return json.decode(response.body);
      } else {
        throw Exception('Failed to load data');
      }

    } catch (error) {
      print('Error during get cours: $error');
      throw Exception('Failed to load drivers');
    }
  }

  Future<List<dynamic>> getReservation() async {
    final String apiUrl = BaseURL.baseURL + '/api/cour/getAllCal/${StaticUser.staticLogin.id}';
    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${StaticUser.staticLogin.accessToken}',
        },
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load data');
      }

    } catch (error) {
      print('Error during get cours: $error');
      throw Exception('Failed to load drivers');
    }
  }



  /*Future<List<Cours>> getCours() async {
    final String apiUrl = BaseURL.baseURL + '/api/cour/getAllCours';
    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${StaticUser.staticLogin.accessToken}',
        },
      );

      print(apiUrl);
      if (response.statusCode == 200) {

        List<dynamic> jsonList = jsonDecode(response.body);
        List<Cours> drivers = jsonList.map((json) => Cours.fromJson(json)).toList();
        print('GET /  response.status:${response.statusCode}');

        return drivers;
      } else {
        print(apiUrl);
        print('GET /  response.status: ${response.statusCode}');
        throw Exception('Failed to load drivers');
      }
    } catch (error) {
      print('Error during get cours: $error');
      throw Exception('Failed to load drivers');
    }
  }

*/

}
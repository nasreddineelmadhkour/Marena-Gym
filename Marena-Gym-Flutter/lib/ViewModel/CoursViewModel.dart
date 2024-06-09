

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:projetfe/Models/Cours.dart';
import 'package:projetfe/Models/StaticUser.dart';
import 'package:projetfe/Netwrok/BaseURL.dart';
import 'package:http/http.dart' as http;


class CoursViewModel extends ChangeNotifier{




  Future<List<Cours>> getCours() async {
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

}
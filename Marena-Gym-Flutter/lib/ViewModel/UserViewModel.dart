import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:projetfe/Models/Login.dart';
import 'package:projetfe/Models/StaticUser.dart';
import 'package:projetfe/Models/User.dart';
import 'package:http/http.dart' as http;
import 'package:projetfe/Netwrok/BaseURL.dart';

class UserViewModel extends ChangeNotifier {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;


  Future<bool> login() async {
    isLoading = true;
    notifyListeners();

    final String apiUrl = BaseURL.baseURL+'/api/auth/signin';

    print("username:"+usernameController.text);
    print("password:"+passwordController.text);

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: jsonEncode({
          'username': usernameController.text,
          'password': passwordController.text,
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        print("hellooo");
        StaticUser.staticLogin = Login.fromJson(json.decode(response.body));

        print(StaticUser.staticUser.accessToken);

        // Add a delay of 2 seconds
        await Future.delayed(Duration(seconds: 2));

        final response2 = await http.get(
          Uri.parse(BaseURL.baseURL+'/api/auth/getDetailUser/${StaticUser.staticLogin.id}'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${StaticUser.staticUser.accessToken}',
          },
        );
        print("hello2");
        StaticUser.staticUser2 = User.fromJson(json.decode(response2.body));

        print(StaticUser.staticUser2.username);
        print(StaticUser.staticUser2.accessToken);

        print('Login successful');
        isLoading = false;
        notifyListeners();
        return true;
      } else {
        print('Login failed. Status code: ${response.statusCode}');
        isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (error) {
      print('Error during login: $error');
      isLoading = false;
      notifyListeners();
      return false;
    }
  }


  Future<bool> updateUser(User user, File image) async {
    try {

      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            '${BaseURL.baseURL}/api/auth/updateUser/${StaticUser.staticLogin.id}'),
      );

      print('${BaseURL.baseURL}/api/auth/updateUser/${StaticUser.staticLogin.id}');
        request.files.add(
          await http.MultipartFile.fromPath(
            'image',
            image.path,
            contentType: MediaType('image', 'jpeg'), // Adjust content type as needed
          ),
        );
      request.fields.addAll({
        'name': user.name,
        'age': user.age.toString(),
        'taille': user.taille.toString(),
        'poids': user.poids.toString()
      });

      request.headers['Authorization'] = 'Bearer ${StaticUser.staticLogin.accessToken}';

      var response = await request.send();
      var responseData = await response.stream.bytesToString();
      print(response.statusCode);

      if (response.statusCode == 200) {
        return true; // Success
      } else {
        throw Exception('Failed to update user');
      }
    } catch (e) {
      print('Error: $e');
      return false; // Failure
    }
  }





  Future<bool> SendCodeReset(String email) async{

    final String apiUrl = BaseURL.baseURL+'/api/auth/resetpassword/SendCodeReset/${email}';

    try
    {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {

        final responseData = json.decode(response.body);
        bool apiResult = responseData;

        if(apiResult == true){
          print("hello");
          return true;
        }
        else {
          print("hello2");
          return false;
        }


      }
      else
      {
        print(apiUrl);
        print('GET /  response.status: ${response.statusCode}');
        throw Exception('Failed to load drivers');
      }




    }
    catch(error){
      print('Error send code reset : $error');
    }

    print("lastreturn");
    return false;

  }


  Future<bool> VerifyCode(String code) async{

    final String apiUrl = BaseURL.baseURL+'/api/auth/resetpassword/verifyCode/${code}/${StaticUser.staticUser.email}';

    try
    {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {

        final responseData = json.decode(response.body);
        bool apiResult = responseData;

        if(apiResult == true){
          return true;
        }
        else {
          return false;
        }
      }
      else
      {
        print(apiUrl);
        print('GET /  response.status: ${response.statusCode}');
        throw Exception('Failed to load drivers');
      }

    }
    catch(error){
      print('Error send code reset : $error');
    }
    print("lastreturn");
    return false;

  }

  Future<bool> ChangePasswordAfterVerification(String password) async{

    final String apiUrl = BaseURL.baseURL+'/api/auth/resetpassword/ChangePasswordAfterVerification/${password}/${StaticUser.staticUser.email}';

    try
    {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {

        final responseData = json.decode(response.body);
        bool apiResult = responseData;

        if(apiResult == true){
          return true;
        }
        else {
          return false;
        }
      }
      else
      {
        print(apiUrl);
        print('GET /  response.status: ${response.statusCode}');
        throw Exception('Failed to load drivers');
      }

    }
    catch(error){
      print('Error send code reset : $error');
    }
    print("lastreturn");
    return false;

  }


  Future<bool> updateE(User user, File image) async {
    try {

      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            '${BaseURL.baseURL}/api/auth/UpdateE/${StaticUser.staticLogin.id}'),
      );

      print('${BaseURL.baseURL}/api/auth/UpdateE/${StaticUser.staticLogin.id}');
      request.files.add(
        await http.MultipartFile.fromPath(
          'image',
          image.path,
          contentType: MediaType('image', 'jpeg'), // Adjust content type as needed
        ),
      );
      request.fields.addAll({
        'name': user.name,
        'email': user.email.toString(),
        'password': user.password.toString(),
        'birth_date': user.telephone.toString(),
        'adresse':user.adresse.toString()
      });

      request.headers['Authorization'] = 'Bearer ${StaticUser.staticLogin.accessToken}';

      var response = await request.send();
      var responseData = await response.stream.bytesToString();
      print(response.statusCode);

      if (response.statusCode == 200) {
        return true; // Success
      } else {
        throw Exception('Failed to update user');
      }
    } catch (e) {
      print('Error: $e');
      return false; // Failure
    }
  }




}
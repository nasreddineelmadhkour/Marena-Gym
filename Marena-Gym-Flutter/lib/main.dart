import 'package:flutter/material.dart';
import 'package:projetfe/ViewModel/ContactViewModel.dart';
import 'package:projetfe/ViewModel/UserViewModel.dart';
import 'package:projetfe/deshbordEnt.dart';
import 'package:projetfe/g%C3%A9reeProfileEnt.dart';
import 'package:projetfe/home1.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserViewModel()), // Assuming UserViewModel extends ChangeNotifier
        // Add other providers if needed
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
            useMaterial3: true,
          ),

        home: HomePage1(),
      ),
    );
  }
}
/*
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home:HomePage1()
    );
  }
}
**/
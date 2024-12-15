import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surya_aquatic/screens/detail.dart';
import 'package:surya_aquatic/screens/login.dart';
import 'package:surya_aquatic/screens/navbar_screen.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool islogged = prefs.getBool('islogged') ?? false;
  
  runApp( MainApp(islogged: islogged,));
}

class MainApp extends StatelessWidget {
  final bool islogged;

  const MainApp({super.key, required this.islogged});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: islogged ? const navbar_screen() : const loginpage(),
    );
  }
}

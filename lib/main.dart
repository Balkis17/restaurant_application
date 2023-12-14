import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:restaurant_application/color_schemes.g.dart';
import 'my_login_page.dart';
import 'my_home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: 'AIzaSyBaaguaWIrpLg664ShTr2o1zr6Wip5XtdI',
      appId: '1:220182701429:web:6f60bdf38b77b395fc5f3c',
      messagingSenderId: '220182701429',
      projectId: 'restaurants-5ba2c',
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant',
      theme:ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,

      ),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      home: FirebaseAuth.instance.currentUser == null
          ? MyLoginPage()
          : MyHomePage(),
    );
  }
}




import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/pages/home.dart';
import 'package:flutter_firebase_app/pages/main_screen.dart';
// ignore: unused_import
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  initFirebase();

  runApp(
    MaterialApp(
      theme: ThemeData(primaryColor: Colors.amberAccent),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const MainScreen(),
        '/tasks': (context) => const Home(),
      },
    ),
  );
}

void initFirebase() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

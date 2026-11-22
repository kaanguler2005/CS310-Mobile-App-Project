import "package:flutter/material.dart";
import "Screens/LoginPage.dart";
import "Screens/StudentHomePage.dart";
import 'Screens/FlashcardsPage.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      //home: LoginPage(),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/home': (context) => StudentHomePage(),
        '/flashcards': (context) => FlashcardsPage(),
        // TODO '/profile': (context) => ProfilePage(),
      },
    ),
  );
}

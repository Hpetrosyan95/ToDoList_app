import 'package:flutter/material.dart';
import 'package:flutter_app/pages/auth.dart';
import 'package:flutter_app/pages/home.dart';
import 'package:flutter_app/pages/landing.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MaterialApp(
      theme: ThemeData.light().copyWith(
        colorScheme: ThemeData.light().colorScheme.copyWith(
              primary: Colors.green[300],
              onPrimary: Colors.white,
            ),
      ),
      home: const LandingPage(),
      initialRoute: '/main',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/main': (context) => const AutorisationPage(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/second': (context) => const Home(),
      },
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:flutter_app/pages/auth.dart';
import 'package:flutter_app/pages/home.dart';
import 'home.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     late  bool isLoggedIn = false;
    return isLoggedIn ? const Home()  : const AutorisationPage();
  }
}

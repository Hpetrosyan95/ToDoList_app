import 'dart:developer';

import 'package:flutter/material.dart';

import '../services/auth.dart';

class AutorisationPage extends StatefulWidget {
  const AutorisationPage({Key? key}) : super(key: key);

  @override
  State<AutorisationPage> createState() => _AutorisationPageState();
}

class _AutorisationPageState extends State<AutorisationPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _scrollController = ScrollController();
  final authService = AuthService();
  bool showLogin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: ListView(
          physics: const BouncingScrollPhysics(),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          controller: _scrollController,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _logo(),
                const SizedBox(height: 40),
                if (showLogin)
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      _form(
                        'LOGIN',
                        onSignIn,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              showLogin = false;
                            });
                          },
                          child: const Text(
                            "Not Registered? Register",
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                                fontFamily: "Regular"),
                          ),
                        ),
                      ),
                    ],
                  )
                else
                  Column(
                    children: <Widget>[
                      _form('REGISTER', onSignUp),
                      Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              showLogin = true;
                            });
                          },
                          child: const Text(
                            "Already Registered? Login",
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                                fontFamily: "Regular"),
                          ),
                        ),
                      ),
                    ],
                  ),
                // _buttomWave(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _logo() {
    return const Padding(
      padding: EdgeInsets.only(top: 160),
      child: Align(
        child: Text(
          'MyApp',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            fontFamily: 'Regular',
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _input(
    Icon icon,
    String hint,
    TextEditingController controller,
    bool obscure,
  ) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.white,
        ),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          hintStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.white54,
          ),
          hintText: hint,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(
              color: Colors.greenAccent,
              width: 0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(
              color: Colors.greenAccent,
              width: 1,
            ),
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(
              left: 15,
              right: 15,
            ),
            child: IconTheme(
                data: const IconThemeData(color: Colors.white), child: icon),
          ),
        ),
      ),
    );
  }

  Widget _button(String text, void Function() func) {
    return ElevatedButton(
      onPressed:(){ Navigator.pushNamed(context, '/second');},
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    );
  }

  Widget _form(String label, void Function() func) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 20, top: 10),
          child: _input(const Icon(Icons.email), "Login or phone number",
              _emailController, false),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: _input(
              const Icon(Icons.lock), "Password", _passwordController, true),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: SizedBox(
            height: 45,
            width: MediaQuery.of(context).size.width,
            child: _button(label, func),
          ),
        ),
      ],
    );
  }

  Future<void> onSignUp() async {
    await authService.registerWithEmailAndPassword(
      _emailController.text,
      _passwordController.text,
    );
    showLogin = true;
    setState(() {});
  }

  Future<void> onSignIn() async {
    await authService.signInWithEmailAndPassword(
      _emailController.text,
      _passwordController.text,
    );
    log("SIGNED IN ");
    setState(() {});
  }
}

class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(size.width, 0.0);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.lineTo(0.0, size.height + 5);
    var secondControlPoint = Offset(size.width - (size.width / 6), size.height);
    var secondEndPoint = Offset(size.width, 0.0);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

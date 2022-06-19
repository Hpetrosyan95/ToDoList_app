import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text(
          'WorkList',
          style: TextStyle(fontFamily: "Regular"),
        ),
        centerTitle: true,
      ),
      body: Align(
          alignment: const Alignment(0.8, 0.9),
          child: CupertinoButton.filled(
            child: const Text(
              "Next",
              style: TextStyle(fontFamily: "Regular"),
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/todo');
            },
          )),
    );
  }
}

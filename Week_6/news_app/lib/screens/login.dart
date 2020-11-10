import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {

  static const String _id = 'login';

  static String get id => _id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              Image(
                image: AssetImage('assets/newsfone.png'),
                height: 56.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
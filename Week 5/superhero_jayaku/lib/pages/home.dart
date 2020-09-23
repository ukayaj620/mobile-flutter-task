import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:superhero_jayaku/components/app_raised_button.dart';

class Home extends StatelessWidget {
  static const String routeId = 'home';

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SvgPicture.asset(
                "assets/hero.svg",
                width: MediaQuery.of(context).size.width * 0.75,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 16.0),
                child: Text(
                  'Logged In!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Quicksand',
                    fontSize: 24.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 80.0),
                child: AppRaisedButton(
                  color: Color.fromRGBO(0, 101, 255, 1),
                  press: () async {
                    await _auth.signOut();
                    Navigator.pushNamed(context, 'sign_in');
                  },
                  text: 'Sign Out',
                  textColor: Color.fromRGBO(255, 255, 255, 1),
                ),
              ),
            ],
          )
        )
      )
    );
  }
}
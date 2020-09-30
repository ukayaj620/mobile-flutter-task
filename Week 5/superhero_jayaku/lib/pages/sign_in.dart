import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:superhero_jayaku/components/app_raised_button.dart';
import 'package:superhero_jayaku/components/app_text_field.dart';

class SignIn extends StatelessWidget {
  static const String _routeId = 'sign_in';

  static String get id => _routeId;

  final _auth = FirebaseAuth.instance;
  String _inputEmail, _inputPassword;

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
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20.0),
                child: Text(
                  'Welcome Hero!',
                  style: TextStyle(
                    fontFamily: 'Quicksand',
                    fontSize: 32.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              AppTextField(
                hint: 'Username',
                secure: false,
                inputType: TextInputType.text,
                onChanged: (email) => _inputEmail = email,
              ),
              AppTextField(
                hint: 'Password',
                secure: true,
                inputType: TextInputType.visiblePassword,
                onChanged: (password) => _inputPassword = password,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20.0, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    AppRaisedButton(
                      color: Color.fromRGBO(0, 101, 255, 1),
                      press: () async {
                        try {
                          final userSignIn = await
                          _auth.signInWithEmailAndPassword(
                              email: _inputEmail,
                              password: _inputPassword
                          );
                          if (userSignIn != null) Navigator.pushNamed(context, 'home');
                        } catch (e){
                          print(e);
                        }
                      },
                      text: 'Sign In',
                      textColor: Color.fromRGBO(255, 255, 255, 1),
                    ),
                    AppRaisedButton(
                      color: Color.fromRGBO(0, 101, 255, 1),
                      press: () => Navigator.pushNamed(context, 'sign_up'),
                      text: 'Sign Up',
                      textColor: Color.fromRGBO(255, 255, 255, 1),
                    ),
                  ],
                ),
              ),
            ],
          )
        )
      )
    );
  }
}
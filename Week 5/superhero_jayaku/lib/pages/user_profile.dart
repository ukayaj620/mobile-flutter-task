import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:superhero_jayaku/components/app_raised_button.dart';
import 'package:superhero_jayaku/components/app_text_field.dart';

class UserProfile extends StatefulWidget {
  static const String _routeId = 'user_profile';

  static String get id => _routeId;

  @override
  _CreateUserProfile createState() => _CreateUserProfile();
}

class _CreateUserProfile extends State<UserProfile> {
  final _auth = FirebaseAuth.instance;
  User _loggedIn;
  String _name;

  @override
  void initState() {
    _getUserProfile();
    super.initState();
  }

  void _getUserProfile() {
    User user = _auth.currentUser;
    if (user != null) {
      _loggedIn = user;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Set Your Profile Name',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Quicksand',
                    fontSize: 28.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 16.0),
                  child: AppTextField(
                    hint: 'Profile Name',
                    secure: false,
                    inputType: TextInputType.text,
                    onChanged: (name) => _name = name,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    AppRaisedButton(
                      color: Color.fromRGBO(0, 101, 255, 1),
                      press: () => Navigator.pop(context),
                      text: 'Back',
                      textColor: Color.fromRGBO(255, 255, 255, 1),
                    ),
                    AppRaisedButton(
                      color: Color.fromRGBO(0, 101, 255, 1),
                      press: () async {
                        try {
                          await _loggedIn.updateProfile(displayName: _name);
                          if (_name != null) {
                            Navigator.pop(context);
                          }
                        } catch (e) {
                          print(e);
                        }
                      },
                      text: 'Submit',
                      textColor: Color.fromRGBO(255, 255, 255, 1),
                    ),
                  ],
                ),
              ],
            )
          ),
        ),
      ),
    );
  }
}

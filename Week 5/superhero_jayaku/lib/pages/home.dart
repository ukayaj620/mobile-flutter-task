import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:superhero_jayaku/components/app_icon_button.dart';

class Home extends StatefulWidget {
  static const String _routeId = 'home';

  static String get id => _routeId;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final _auth = FirebaseAuth.instance;
  User _loggedIn;
  String _profileName = "John Doe";
  String _profileImageUrl = "https://www.pngkey.com/png/detail/230-2301779_best-classified-apps-default-user-profile.png";

  @override
  void initState() {
    super.initState();
    _getUserProfile();
  }

  void _getUserProfile() {
    User user = _auth.currentUser;

    if (user != null) {
      _loggedIn = user;
      if (_loggedIn.displayName != null) {
        _profileName = _loggedIn.displayName;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                backgroundImage: NetworkImage(
                    _profileImageUrl,
                    scale: 0.2,
                ),
                radius: 80.0,
              ),
              SizedBox(height: 20.0),
              Text(
                _profileName.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Quicksand',
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 20.0),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      AppIconButton(
                        tooltip: 'Set Profile Name',
                        icon: Icon(Icons.settings_applications),
                        onPressed: () => Navigator.pushNamed(context, 'user_profile').whenComplete(
                          () => setState(
                            () => {_getUserProfile()},
                          ),
                        ),
                        color: Colors.blue,
                      ),
                      IconButton(
                        tooltip: 'Create Moods',
                        icon: Icon(Icons.person_add),
                        onPressed: () => Navigator.pushNamed(context, 'create_moods'),
                        color: Colors.amber,
                      ),
                      IconButton(
                        tooltip: 'Sign Out',
                        icon: Icon(Icons.block),
                        onPressed: () async {
                          await _auth.signOut();
                          Navigator.pushReplacementNamed(context, 'sign_in');
                        },
                        color: Colors.red[700],
                      ),
                    ],
                  ),
                ),
              )
            ],
          )
        )
      )
    );
  }
}
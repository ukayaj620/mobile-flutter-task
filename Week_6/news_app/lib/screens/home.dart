import 'package:flutter/material.dart';
import 'package:news_app/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  static const String _id = 'home';
  static String get id => _id;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _username = '';

  @override
  void initState() {
    super.initState();
    _getStore();
  }

  void _getStore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('username');
    });
  }

  void _signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.pushNamed(context, LoginScreen.id);
  }

  static const TextStyle _textStyle = TextStyle(fontFamily: 'Roboto', fontSize: 36.0);

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Welcome " + _username,
                textAlign: TextAlign.center,
                style: _textStyle,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 24.0, 0, 0),
                child: RaisedButton(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  textColor: Colors.white,
                  color: Colors.black87,
                  child: Text("SIGN OUT"),
                  onPressed: () => _signOut(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
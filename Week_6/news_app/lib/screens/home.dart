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
      print(prefs.getString('userId'));
    });
  }

  void _signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.pushNamed(context, LoginScreen.id);
  }

  static const TextStyle _textStyle = TextStyle(fontFamily: 'Roboto', fontSize: 24.0);

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Image.asset(
            'assets/newsfone.png',
            width: MediaQuery.of(context).size.width * 0.3,
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.backspace),
              onPressed: () {
                _signOut();
                Navigator.pushNamed(context, "login");
              },
            )
          ],
        ),
        body: SafeArea(
          child: Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0, 2),
                          spreadRadius: 0,
                          blurRadius: 4, // changes position of shadow
                        ),
                      ],
                    ),
                    child: Text(
                      "Welcome " + _username,
                      textAlign: TextAlign.center,
                      style: _textStyle,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, 'add_news'),
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:news_app/components/app_text_form_field.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/screens/register.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:news_app/screens/home.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({ Key key }): super(key: key);

  static const String _id = 'login';
  static String get id => _id;

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String _email, _password;

  void _validateForm() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      _login();
    }
  }

  void _login() async {
    final response = await http.post(
      'https://flutternewsapi.000webhostapp.com/login.php',
      body: {
        'email': _email,
        'password': _password,
      }
    );
    final data = jsonDecode(response.body);
    if (data['value'] == 1) {
      print(data);
      _store(data['username'], data['email'], data['id']);
      Navigator.pushNamed(context, HomeScreen.id);
    } else {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text(data['message'].toString()),
          duration: Duration(seconds: 3),
        )
      );
    }
  }

  void _store(String username, String email, String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
    await prefs.setString('email', email);
    await prefs.setString('userId', userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(
                image: AssetImage('assets/newsfone.png'),
                height: 56.0,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 64.0, 0, 32.0),
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      AppTextFormField(
                        onSaved: (value) => _email = value,
                        inputType: TextInputType.emailAddress,
                        secure: false,
                        hint: "Email",
                        label: "Email",
                      ),
                      AppTextFormField(
                        onSaved: (value) => _password = value,
                        inputType: TextInputType.text,
                        secure: true,
                        hint: "Password",
                        label: "Password",
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                margin: EdgeInsets.fromLTRB(0, 0, 0, 24.0),
                child: RaisedButton(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  onPressed: () => _validateForm(),
                  textColor: Colors.white,
                  color: Colors.black87,
                  child: Text("LOGIN"),
                ),
              ),
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Don\'t have account? ',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 16.0,
                        color: Colors.black87
                      ),
                    ),
                    TextSpan(
                      text: 'Sign Up',
                      recognizer: TapGestureRecognizer()..onTap = () => Navigator.pushNamed(context, RegisterScreen.id),
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87
                      ),
                    )
                  ]
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
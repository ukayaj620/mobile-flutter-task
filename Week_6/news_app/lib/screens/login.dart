import 'package:flutter/material.dart';
import 'package:news_app/components/app_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({ Key key }): super(key: key);

  static const String _id = 'login';
  static String get id => _id;

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email, _password;

  void _validateForm() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      print("$_email, $_password");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      ),
                      AppTextFormField(
                        onSaved: (value) => _password = value,
                        inputType: TextInputType.text,
                        secure: true,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 48.0,
                child: RaisedButton(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  onPressed: () => _validateForm(),
                  textColor: Colors.white,
                  color: Colors.black87,
                  child: Text("LOGIN"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
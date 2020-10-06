import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:superhero_jayaku/pages/create_moods.dart';
import 'package:superhero_jayaku/pages/home.dart';
import 'package:superhero_jayaku/pages/sign_in.dart';
import 'package:superhero_jayaku/pages/sign_up.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: SignIn.id,
      routes: {
        SignIn.id: (context) => SignIn(),
        SignUp.id: (context) => SignUp(),
        Home.id: (context) => Home(),
        CreateMoods.id: (context) => CreateMoods(),
      },
    );
  }
}
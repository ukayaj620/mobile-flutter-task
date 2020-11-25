import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/screens/add_news.dart';
import 'package:news_app/screens/home.dart';
import 'package:news_app/screens/login.dart';
import 'package:news_app/screens/register.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) => runApp(new App()));
}

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News',
      initialRoute: RegisterScreen.id,
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        RegisterScreen.id: (context) => RegisterScreen(),
        AddNewsScreen.id: (context) => AddNewsScreen(),
      },
    );
  }
}

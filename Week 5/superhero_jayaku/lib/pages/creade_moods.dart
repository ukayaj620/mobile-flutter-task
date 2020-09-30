import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:superhero_jayaku/components/app_hero_card.dart';
import 'package:superhero_jayaku/models/heros.dart';
import 'dart:convert';

class CreateMoods extends StatefulWidget {
  static const String _routeId = 'create_moods';

  static String get id => _routeId;

  @override
  _CreateMoodsState createState() => _CreateMoodsState();
}

class _CreateMoodsState extends State<CreateMoods> {

  Future<HeroModel> _bootstrapAsync() async {
    http.Response response = await http.get('https://www.superheroapi.com/api.php/3142788385831459/search/batman');
    if (response.statusCode == 200) {
      Map json = jsonDecode(response.body);
      HeroModel heroData = HeroModel.fromJson(json);
      return heroData;
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: FutureBuilder(
            future: _bootstrapAsync(),
            builder: (context, AsyncSnapshot<HeroModel> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemBuilder: (BuildContext context, int index) => HeroCard(
                    imageUrl: snapshot.data.results[index].image.url,
                    heroName: snapshot.data.results[index].name.toString(),
                  ),
                  itemCount: snapshot.data.results.length,
                );
              } else {
                return CircularProgressIndicator();
              }
            }
          ),
        ),
      )
    );
  }
}
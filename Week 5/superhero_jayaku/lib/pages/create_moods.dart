import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:superhero_jayaku/components/app_hero_card.dart';
import 'package:superhero_jayaku/components/app_text_field.dart';
import 'package:superhero_jayaku/models/heros.dart';
import 'package:superhero_jayaku/services/api_services.dart';
import 'dart:convert';

class CreateMoods extends StatefulWidget {
  static const String _routeId = 'create_moods';

  static String get id => _routeId;

  @override
  _CreateMoodsState createState() => _CreateMoodsState();
}

class _CreateMoodsState extends State<CreateMoods> {

  String _searchHero;
  Future<HeroModel> _getSearchResult;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.fromLTRB(0, 24.0, 0, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                'Search The Hero',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Quicksand',
                  fontSize: 28.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: 24.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: AppTextField(
                  hint: 'Search Hero',
                  secure: false,
                  inputType: TextInputType.text,
                  onChanged: (hero) {
                    _searchHero = hero;
                    setState(() {
                      _getSearchResult = APIServices().getSearchResult(_searchHero);
                    });
                  },
                ),
              ),
              Expanded(
                child: FutureBuilder(
                  future: APIServices().getSearchResult(_searchHero),
                  builder: (context, AsyncSnapshot<HeroModel> snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Center(child: CircularProgressIndicator());
                      default:
                        return !snapshot.hasData
                            ? Text('No Data Found')
                            : _listOfContent(context, snapshot.data);
                    }
                  }
                ),
              ),
            ],
          ),
        )
      )
    );
  }

  Widget _listOfContent(BuildContext context, data) {
    print(data);
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) => HeroCard(
        imageUrl: data.results[index].image.url,
        heroName: data.results[index].name.toString(),
      ),
      itemCount: data.results.length,
    );
  }
}
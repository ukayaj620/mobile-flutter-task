import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:superhero_jayaku/components/app_hero_card.dart';
import 'package:superhero_jayaku/components/app_text_field.dart';
import 'package:superhero_jayaku/models/heros.dart';
import 'package:superhero_jayaku/services/api_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CreateMoods extends StatefulWidget {
  static const String _routeId = 'create_moods';

  static String get id => _routeId;

  @override
  _CreateMoodsState createState() => _CreateMoodsState();
}

class _CreateMoodsState extends State<CreateMoods> {

  String _searchHero;
  Future<HeroModel> _getSearchResult;
  String _heroName;
  String _imageUrl;
  String _moodsHero;
  List<int> _isSelected;
  int _selectedIndex;
  final _fireStoreInstance = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

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
                  future: _getSearchResult,
                  builder: (context, AsyncSnapshot<HeroModel> snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Center(child: CircularProgressIndicator());
                      default:
                        _isSelected = List.filled(snapshot.data.results.length, 0);
                        return !snapshot.hasData
                            ? Text('No Data Found')
                            : _listOfContent(context, snapshot.data);
                    }
                  }
                ),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Card(
        child: ListTile(
          leading: Text(
            'Moods',
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontFamily: 'Quicksand',
              fontSize: 16.0,
              fontWeight: FontWeight.w900,
            ),
          ),
          title: AppTextField(
            hint: 'Input Moods',
            secure: false,
            inputType: TextInputType.text,
            onChanged: (mood) {
              _moodsHero = mood;
            },
          ),
          trailing: IconButton(
            icon: Icon(Icons.send),
            onPressed: () async {
              User loggedIn = _auth.currentUser;
              await _fireStoreInstance.collection('moods').doc(loggedIn.email).set({
                'nameHero': _heroName,
                'urlHero': _imageUrl,
                'moodsText': _moodsHero,
              }).then((value) =>
                print('${loggedIn.displayName} insert Hero Moods successfully')
              ).catchError((error) =>
                print(error)
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _listOfContent(BuildContext context, data) {
    print(_isSelected);

    if (_selectedIndex != null)
      _isSelected[_selectedIndex] = 1;

    print(_heroName);
    print(_imageUrl);
    print(_selectedIndex);
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) => HeroCard(
        imageUrl: data.results[index].image.url,
        heroName: data.results[index].name.toString(),
        index: index,
        getData: (String heroName, String imageUrl, int index) {
          setState(() {
            _heroName = heroName;
            _imageUrl = imageUrl;
            _selectedIndex = index;
          });
        },
        borderColor: _isSelected[index] == 1 ? Colors.blueAccent : Colors.transparent,
      ),
      itemCount: data.results.length,
    );
  }
}
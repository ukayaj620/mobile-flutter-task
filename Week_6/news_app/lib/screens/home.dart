import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class HomeScreen extends StatefulWidget {
  static const String _id = 'home';
  static String get id => _id;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _username = '';
  List<NewsModel> newsList = List<NewsModel>();
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _getStore();
    _getNewsData();
  }

  _getNewsData() async {
    newsList.clear();
    setState(() {
      _loading = true;
    });
    final response = await http.get('https://flutternewsapi.000webhostapp.com/detailNews.php');
    if (response.statusCode == 200) {
      final newsData = jsonDecode(response.body);
      print(newsData);
      newsData.forEach((data) {
        final listData = NewsModel(
          newsId: data['newsId'],
          image: data['image'],
          title: data['title'],
          content: data['content'],
          description: data['description'],
          dateNews: data['dateNews'],
          userId: data['userId'],
          username: data['username'],
        );
        newsList.add(listData);
      });
      setState(() {
        _loading = false;
      });
    } else {
      throw Exception('Failed to load News');
    }
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

  static const TextStyle _textTitleStyle = TextStyle(fontFamily: 'Roboto', fontSize: 20.0, fontWeight: FontWeight.bold);
  static const TextStyle _textStyle = TextStyle(fontFamily: 'Roboto', fontSize: 12.0);

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
              margin: EdgeInsets.fromLTRB(0, 16.0, 0, 0),
              child: RefreshIndicator(
                  onRefresh: () => _getNewsData(),
                  child: _loading ?
                  Center(child: CircularProgressIndicator())
                      : ListView.builder(
                      itemCount: newsList.length,
                      itemBuilder: (context, i) {
                        final _newsDetails = newsList[i];
                        return InkWell(
                          child: Container(
                            padding: EdgeInsets.all(16.0),
                            margin: EdgeInsets.symmetric(vertical: 8.0),
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
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.25,
                                  height: MediaQuery.of(context).size.width * 0.25,
                                  margin: EdgeInsets.fromLTRB(0, 0, 16.0, 0),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black54),
                                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                    image: DecorationImage(
                                      image: NetworkImage('https://flutternewsapi.000webhostapp.com/uploads/${_newsDetails.image}'),
                                      fit: BoxFit.cover
                                    )
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(_newsDetails.title, style: _textTitleStyle),
                                      Text("${_newsDetails.content} | ${_newsDetails.dateNews}", style: _textStyle),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }
                  )
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
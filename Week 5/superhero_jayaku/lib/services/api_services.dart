import 'dart:convert';
import 'package:superhero_jayaku/models/heros.dart';
import 'package:http/http.dart' as http;

class APIServices {

  String _url = 'https://www.superheroapi.com/api.php/3142788385831459/search';

  Future<HeroModel> getSearchResult(String query) async {
    http.Response response = await http.get('$_url/$query');
    if (response.statusCode == 200) {
      Map json = jsonDecode(response.body);
      HeroModel heroData = HeroModel.fromJson(json);
      return heroData;
    } else {
      throw Exception('Failed to load album');
    }
  }
}
import 'dart:collection';
import 'dart:convert';

import 'package:p_singular/SRC/ENTITIES/entities.dart';
import 'package:p_singular/SRC/MODELS/models.dart';
import 'package:http/http.dart' as http;

abstract class GamesRepository {
  Future<List<Games>> loadData();
  Future<List<Games>> searchResults(String query);
}

class GameAPI extends GamesRepository {
  List<Games> games;

  @override
  Future<List<Games>> loadData() async {
    final response = await http.get(
        'https://my-json-server.typicode.com/SunbakedCoast/PlayStationDemo/games');

    //if (response.statusCode != 200) throw Exception('Request Failed: ${response.statusCode}');

    Iterable list = jsonDecode(response.body);
    return games = list
        .map((game) => Games.fromEntity(GamesEntity.fromJson(game)))
        .toList();
    //return Games.fromEntity(GamesEntity.fromJson(jsonDecode(response.body)))
  }

  @override
  Future<List<Games>> searchResults(String query) async {
    final response = await http.get(
        'https://my-json-server.typicode.com/SunbakedCoast/PlayStationDemo/games');
    if (response.statusCode != 200)
      throw Exception('Request Failed: ${response.statusCode}');
    //final body = jsonDecode(response.body);
    try {
      Iterable list = json.decode(response.body);
      return games = list
          .map((game) => Games.fromEntity(GamesEntity.fromJson(game)))
          .where((element) => element.name == query).toList();
    } catch (_) {
      throw Exception('ERROR PARSING RESPONSE BODY');
    }

    //return Games.fromEntity(GamesEntity.fromJson(list).name;
  }
}

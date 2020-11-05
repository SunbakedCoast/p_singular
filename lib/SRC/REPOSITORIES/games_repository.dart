import 'dart:collection';
import 'dart:convert';

import 'package:p_singular/SRC/ENTITIES/entities.dart';
import 'package:p_singular/SRC/MODELS/models.dart';
import 'package:http/http.dart' as http;

abstract class GamesRepository {
  Future<List<Games>> loadData();
}

class GameAPI extends GamesRepository {
  List<Games> games;

  @override
  Future<List<Games>> loadData() async {
    final response = await http.get('https://my-json-server.typicode.com/SunbakedCoast/PlayStationDemo/games');

    //for debugging purposes only
    Iterable list = jsonDecode(response.body);
    //for debugging purposes only

    return games = list.map((game) => Games.fromEntity(GamesEntity.fromJson(game))).toList();
    //return Games.fromEntity(GamesEntity.fromJson(jsonDecode(response.body)))
  }
}

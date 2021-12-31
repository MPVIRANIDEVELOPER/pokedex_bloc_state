import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex_bloc_state/models/PokemonSpeciesModel.dart';
import 'models/PokemonModel.dart';

import 'models/PokemonInfoModel.dart';

class PokemonRepository {
  final baseUrl = "pokeapi.co";
  final client = http.Client();

  Future<PokemonModel> getPokemonPage(int pageIndex) async {
    //    /api/v2/pokemon?offset=100&limit=200

    final queryParameters = {
      'limit': '200',
      'offset': (pageIndex * 200).toString()
    };
    final uri = Uri.https(baseUrl, '/api/v2/pokemon', queryParameters);

    final response = await client.get(uri);

    return pokemonModelFromJson(response.body);
  }

  Future<PokemonInfo> getPokemonInfo(int pokemonId) async {
    final uri = Uri.https(baseUrl, '/api/v2/pokemon/$pokemonId');

    try {
      final response = await client.get(uri);
      final pokemonInfo = pokemonInfoFromJson(response.body);
      return pokemonInfo;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
  }

  Future<PokemonSpeciesModel> getPokemonSpeciesInfo(int pokemonId) async {
    final uri = Uri.https(baseUrl, '/api/v2/pokemon-species/$pokemonId');

    try {
      final response = await client.get(uri);
      final pokemonInfo = pokemonSpeciesModelFromJson(response.body);
      return pokemonInfo;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
  }
}

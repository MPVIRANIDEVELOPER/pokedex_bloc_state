import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_bloc_state/models/PokemonDetailsModel.dart';
import 'package:pokedex_bloc_state/models/PokemonInfoModel.dart';
import 'package:pokedex_bloc_state/models/PokemonSpeciesModel.dart';
import 'package:pokedex_bloc_state/pokemon_repository.dart';

class PokemonDetailsCubit extends Cubit<dynamic> {
  final _pokemonRepository = PokemonRepository();

  PokemonDetailsCubit() : super(null);

  void getPokemonDetails(int pokemonId) async {
    final response = await Future.wait([
      _pokemonRepository.getPokemonInfo(pokemonId),
      _pokemonRepository.getPokemonSpeciesInfo(pokemonId)
    ]);

    final pokemonInfo = response[0] as PokemonInfo;
    final speciesInfo = response[1] as PokemonSpeciesModel;

    emit(PokemonDetailsModel(
        id: pokemonInfo.id,
        name: pokemonInfo.name,
        imageUrl: '',
        types: ['pokemonInfo.types'],
        height: pokemonInfo.height,
        weight: pokemonInfo.weight,
        description: 'speciesInfo.formDescriptions'));
  }

  void clearPokemonDetails() => emit(null);
}

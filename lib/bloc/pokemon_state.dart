import 'package:pokedex_bloc_state/models/PokemonModel.dart';

abstract class PokemonState {}

class PokemonInitial extends PokemonState {}

class PokemonLoadInProgress extends PokemonState {}

class PokemonPageLoadSuccess extends PokemonState {
  final PokemonModel pokemonListing;

  PokemonPageLoadSuccess({required this.pokemonListing});
}

class PokemonPageLoadFailed extends PokemonState {
  final String error;

  PokemonPageLoadFailed({required this.error});
}

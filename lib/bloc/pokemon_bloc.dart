import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_bloc_state/bloc/Pokemon_event.dart';
import 'package:pokedex_bloc_state/bloc/pokemon_state.dart';
import 'package:pokedex_bloc_state/pokemon_repository.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final _pokemonRepository = PokemonRepository();
  PokemonBloc() : super(PokemonInitial()) {
    on<PokemonPageRequest>(loadPokemon);
  }

  FutureOr<void> loadPokemon(
      PokemonPageRequest event, Emitter<PokemonState> emit) async {
    emit(PokemonLoadInProgress());

    try {
      final pokemonPageResponse =
          await _pokemonRepository.getPokemonPage(event.page);

      if (kDebugMode) {
        print(pokemonPageResponse);
      }

      emit(PokemonPageLoadSuccess(pokemonListing: pokemonPageResponse));
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      emit(PokemonPageLoadFailed(error: "Something Goes Wrong"));
    }
  }
}

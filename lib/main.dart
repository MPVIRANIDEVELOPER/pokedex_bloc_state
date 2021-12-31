import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_bloc_state/app_navigator.dart';
import 'package:pokedex_bloc_state/bloc/Pokemon_event.dart';
import 'package:pokedex_bloc_state/bloc/nav_cubit.dart';
import 'package:pokedex_bloc_state/bloc/pokemon_bloc.dart';
import 'package:pokedex_bloc_state/bloc/pokemon_details_cubit.dart';
import 'package:pokedex_bloc_state/pokedex_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final pokemonDetailsCubit = PokemonDetailsCubit();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Theme.of(context).copyWith(
          primaryColor: Colors.red,
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: Colors.redAccent)),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                PokemonBloc()..add(PokemonPageRequest(page: 0)),
          ),
          BlocProvider(
            create: (context) =>
                NavCubit(pokemonDetailsCubit: pokemonDetailsCubit),
          ),
          BlocProvider(create: (context) => pokemonDetailsCubit),
        ],
        child: const AppNavigator(),
      ),
    );
  }
}

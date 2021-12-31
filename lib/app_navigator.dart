import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_bloc_state/bloc/nav_cubit.dart';
import 'package:pokedex_bloc_state/pokedex_view.dart';

class AppNavigator extends StatelessWidget {
  const AppNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavCubit, int>(builder: (context, pokemonId) {
      return Navigator(
        pages: [
          MaterialPage(child: PokedexView()),
          if (pokemonId != null)
            MaterialPage(
              child: Scaffold(
                appBar: AppBar(
                  title: Text('Details'),
                ),
                body: Text(
                  pokemonId.toString(),
                ),
              ),
            ),
        ],
        onPopPage: (route, result) {
          BlocProvider.of<NavCubit>(context).popToPokedex();
          return route.didPop(result);
        },
      );
    });
  }
}

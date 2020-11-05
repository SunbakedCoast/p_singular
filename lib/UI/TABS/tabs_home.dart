import 'package:p_singular/BLOCS/BLOCS_HOME/home.dart';
import 'package:p_singular/SRC/REPOSITORIES/games_repository.dart';
import 'package:p_singular/WIDGETS/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeProvider extends StatelessWidget {
  Widget build(BuildContext context) {
    return RepositoryProvider<GamesRepository>(
        create: (context) => GameAPI(),
        child: BlocProvider<HomeBloc>(
          create: (context) {
            final gameRepository =
                RepositoryProvider.of<GamesRepository>(context);
            return HomeBloc(gameRepository)..add(LoadAllData());
          },
          child: _HomeTab(),
        ));
  }
}

class _HomeTab extends StatelessWidget {
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
      if (state is DataLoaded) {
        //final _itemCount = state.games.length;
        final _games = state.games;
        //print('ITEMCOUNT: ${_itemCount.toString()}');
        return ListView(
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          children: [
            HorizontalCategories(section: 'Categories'),
            HorizontalList(section: 'Featured', itemName: 'Assassins Creed: Valhalla'),
            VerticalListWide(section: 'All', itemLength: 3, state: state, games: _games)
          ],
        );
      }
      return Container(
        child: Center(
          child: Text('no data'),
        ),
      );
    });
  }
}

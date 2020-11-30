import 'package:p_singular/BLOCS/BLOCS_HOME/home.dart';
import 'package:p_singular/SRC/REPOSITORIES/games_repository.dart';
import 'package:p_singular/WIDGETS/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///[SIMPLIFY _games VARIABLE]
class HomeTab extends StatelessWidget {
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      if (state is DataLoaded) {
        final _games = state.games;
        return ListView(
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          children: [
            HorizontalCategories(section: 'Categories'),
            HorizontalList(
              section: 'Featured',
              state: state,
              games: _games,
            ),
            GridViewVertical(section: 'All', state: state, games: _games)
          ],
        );
      }
      print('TABS HOME STATE IS $state');
      return _progressIndicator();
    });
  }

  Widget _progressIndicator() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

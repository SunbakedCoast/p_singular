import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p_singular/BLOCS/BLOCS_CATEGORIES/categories.dart';
import 'package:p_singular/SRC/REPOSITORIES/repositories.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final GamesRepository _gamesRepository;
  StreamSubscription _streamSubscription;

  CategoriesBloc(GamesRepository gamesRepository)
      : assert(gamesRepository != null),
        _gamesRepository = gamesRepository,
        super(CategoriesInitial());

  @override
  Stream<CategoriesState> mapEventToState(CategoriesEvent event) async* {
    if (event is LoadCategories) {
      yield* _mapLoadCategoriestoState();
    }
    if (event is CategoriesUpdated) {
      yield* _mapCategoriesUpdatedtoState(event);
    }
  }

  Stream<CategoriesState> _mapLoadCategoriestoState() async* {
    yield CategoriesLoading();
    _streamSubscription?.cancel();

    _streamSubscription = _gamesRepository
        .loadData()
        .asStream()
        .listen((games) {
      add(CategoriesUpdated(games));
    });
  }

  Stream<CategoriesState> _mapCategoriesUpdatedtoState(
      CategoriesUpdated event) async* {
    yield CategoriesLoaded(event.games);
  }
}

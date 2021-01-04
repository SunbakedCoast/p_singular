import 'dart:async';

import 'package:p_singular/BLOCS/BLOCS_HOME/home.dart';
import 'package:p_singular/SRC/REPOSITORIES/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GamesRepository _gamesRepository;
  StreamSubscription _streamSubscription;

  HomeBloc(GamesRepository gamesRepository)
      : assert(gamesRepository != null),
        _gamesRepository = gamesRepository,
        super(HomeInitial());

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is LoadAllData) {
      yield* _mapLoadAllDatatoState();
    }
    if (event is DataUpdated) {
      yield* _mapDataUpdatedtoState(event);
    }
  }

  Stream<HomeState> _mapLoadAllDatatoState() async* {
    yield HomeLoading();
    try {
      _streamSubscription?.cancel();
      _streamSubscription =
          _gamesRepository.loadData().asStream().listen((games) {
        print('Games list: $games');
        add(DataUpdated(games));
      });
    } catch (error) {
      yield FetchError(
          error: error.message ?? 'Oh snap! Unknown error occured!');
    }
  }

  Stream<HomeState> _mapDataUpdatedtoState(DataUpdated event) async* {
    yield DataLoaded(event.games);
  }
}

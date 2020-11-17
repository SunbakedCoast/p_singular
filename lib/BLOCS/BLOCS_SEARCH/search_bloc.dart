import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p_singular/BLOCS/BLOCS_SEARCH/search.dart';
import 'package:p_singular/SRC/MODELS/models.dart';
import 'package:p_singular/SRC/REPOSITORIES/repositories.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  GamesRepository _gamesRepository;

  SearchBloc(GamesRepository gamesRepository)
      : assert(gamesRepository != null),
        _gamesRepository = gamesRepository,
        super(SearchState.initial());

  void onTransition(Transition<SearchEvent, SearchState> transition) {
    super.onTransition(transition);
    print("TRANSITION CAUGHT: ${transition.toString()}");
  }

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    yield SearchState.loading();

    try {
      List<Games> games = await _gamesRepository.searchResults(event.query);
      print('GAMES RESULT FROM BLOC: $games');
      yield SearchState.success(games);
    } catch (error) {
      yield SearchState.error(error ?? 'An unknown error has occured');
    }
  }
}

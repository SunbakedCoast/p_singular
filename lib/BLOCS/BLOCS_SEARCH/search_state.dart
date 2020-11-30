import 'package:p_singular/SRC/MODELS/models.dart';

class SearchState {
  final bool isLoading;
  final bool hasError;
  final String error;
  final List<Games> games;

  SearchState({this.isLoading, this.hasError, this.error, this.games});

  factory SearchState.initial() {
    return SearchState(
      games: [],
      isLoading: false,
      error: '',
      hasError: false,
    );
  }

  factory SearchState.loading() {
    return SearchState(
      games: [],
      isLoading: true,
      error: '',
      hasError: false,
    );
  }

  factory SearchState.success(List<Games> games) {
    return SearchState(
      games: games,
      isLoading: false,
      error: '',
      hasError: false,
    );
  }

  factory SearchState.error(String error) {
    return SearchState(
      games: [],
      isLoading: false,
      error: error,
      hasError: true,
    );
  }

  @override
  String toString() =>
      'SearchState {games: ${games.toString}, isLoading: $isLoading, hasError: $hasError}';
}

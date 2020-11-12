import 'package:p_singular/SRC/MODELS/models.dart';

class SearchState {
  final bool isLoading;
  final bool hasError;
  final List<Games> games;

  SearchState({this.isLoading, this.hasError, this.games});

  factory SearchState.initial() {
    return SearchState(
      games: [],
      isLoading: false,
      hasError: false,
    );
  }

  factory SearchState.loading() {
    return SearchState(
      games: [],
      isLoading: true,
      hasError: false,
    );
  }

  factory SearchState.success(List<Games> games) {
    return SearchState(
      games: games,
      isLoading: false,
      hasError: false,
    );
  }

  factory SearchState.error() {
    return SearchState(
      games: [],
      isLoading: false,
      hasError: true,
    );
  }

  @override
  String toString() =>
      'SearchState {games: ${games.toString}, isLoading: $isLoading, hasError: $hasError}';
} 

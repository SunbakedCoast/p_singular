import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p_singular/BLOCS/BLOCS_DETAILS/details.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  DetailsBloc() : super(DetailsInitial());

  @override
  Stream<DetailsState> mapEventToState(DetailsEvent event) async* {
    if (event is GetButtonPressed) {
      yield* _mapGetButtonPressedtoState(event);
    }
  }


  ///[TEST CODE]
  Stream<DetailsState> _mapGetButtonPressedtoState(
      GetButtonPressed event) async* {
    yield DetailsLoading();
    await Future.delayed(Duration(seconds: 2));
    yield GetSuccess(games: event.games);
  }
}

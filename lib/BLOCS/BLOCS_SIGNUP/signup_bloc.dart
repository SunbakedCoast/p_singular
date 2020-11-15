import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p_singular/BLOCS/BLOCS_AUTH/authentication.dart';
import 'package:p_singular/BLOCS/BLOCS_SIGNUP/signup.dart';
import 'package:p_singular/SRC/REPOSITORIES/repositories.dart';
import 'package:p_singular/SRC/SERVICES/authentication_service.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthenticationBloc _authenticationBloc;
  final AuthenticationService _authenticationService;
  final PlayerRepository _playerRepository;

  SignUpBloc(
      AuthenticationBloc authenticationBloc,
      AuthenticationService authenticationService,
      PlayerRepository playerRepository)
      : assert(authenticationBloc != null),
        assert(authenticationService != null),
        assert(playerRepository != null),
        _authenticationBloc = authenticationBloc,
        _authenticationService = authenticationService,
        _playerRepository = playerRepository,
        super(SignUpInitial());

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    if (event is SignUpButtonPressed) {
      yield* _mapSignUpWithButtonPressedtoState(event);
    }
    if (event is SendUserDataWithButtonPressed) {
      yield* _mapSendUserDataWithButtonPressed(event);
    }
  }

  Stream<SignUpState> _mapSignUpWithButtonPressedtoState(
      SignUpButtonPressed event) async* {
    yield SignUpLoading();
    await _authenticationService.signUpWithCredentials(
        event.email, event.password);
    final user = _authenticationService.getCurrentUser();
    if (user != null)
      _authenticationBloc.add(UserLoggedIn());
    else
      yield SignUpFailure(error: 'errorTest');
  }

  Stream<SignUpState> _mapSendUserDataWithButtonPressed(
      SendUserDataWithButtonPressed event) async* {
    _playerRepository.sendUserDatatoDatabase(event.player);
  }
}

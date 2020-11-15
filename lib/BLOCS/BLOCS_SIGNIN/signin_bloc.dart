import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p_singular/BLOCS/BLOCS_AUTH/authentication.dart';
import 'package:p_singular/BLOCS/BLOCS_SIGNIN/signin.dart';
import 'package:p_singular/SRC/SERVICES/services.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthenticationBloc _authenticationBloc;
  final AuthenticationService _authenticationService;

  SignInBloc(AuthenticationBloc authenticationBloc,
      AuthenticationService authenticationService)
      : assert(authenticationBloc != null),
        assert(authenticationService != null),
        _authenticationBloc = authenticationBloc,
        _authenticationService = authenticationService,
        super(SignInInitial());

  @override
  Stream<SignInState> mapEventToState(SignInEvent event) {
    // TODO: implement mapEventToState
    throw UnimplementedError();
  }

  Stream<SignInState> _mapSignInButtonPressedtoState(
      SignInButtonPressed event) async* {
    yield SignInLoading();
    await _authenticationService.signInWithCredentials(
        event.email, event.password);
    final user = _authenticationService.getCurrentUser();
    if (user != null)
      _authenticationBloc.add(UserLoggedIn());
    else
      yield SignInFailure(error: 'errorTest');
  }
}

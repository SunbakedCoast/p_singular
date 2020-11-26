import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p_singular/BLOCS/BLOCS_AUTH/authentication.dart';
import 'package:p_singular/SRC/SERVICES/authentication_service.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationService _authenticationService;

  AuthenticationBloc(AuthenticationService authenticationService)
      : assert(authenticationService != null),
        _authenticationService = authenticationService,
        super(AuthenticationInitial());

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AppLoaded) {
      yield* _mapAppLoadedtoState();
    }
    if (event is UserLoggedIn) {
      yield* _mapUserLoggedIntoState();
    }
    if (event is UserLoggedOut) {
      yield* _mapUserLoggedOutToState();
    }
  }

  Stream<AuthenticationState> _mapAppLoadedtoState() async* {
    yield AuthenticationLoading();
    await Future.delayed(Duration(seconds: 3));

    final _currentUser = await _authenticationService.getCurrentUser();
    try {
      if (_currentUser != null) {
        yield AuthenticationAuthenticated();
      } else {
        yield AuthenticationUnauthenticated();
      }
    } catch (e) {
      yield AuthenticationFailure(
          errorMessage: e.toString() ?? 'An unknown error occured');
    }
  }

  Stream<AuthenticationState> _mapUserLoggedIntoState() async* {
    yield AuthenticationAuthenticated();
  }

  Stream<AuthenticationState> _mapUserLoggedOutToState() async* {
    yield AuthenticationLoading();
    await _authenticationService.signOut();
    yield AuthenticationUnauthenticated();
  }
}

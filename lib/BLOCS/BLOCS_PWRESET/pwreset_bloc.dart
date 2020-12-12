import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p_singular/BLOCS/BLOCS_PWRESET/pwreset_event.dart';
import 'package:p_singular/BLOCS/BLOCS_PWRESET/pwreset_state.dart';
import 'package:p_singular/SRC/SERVICES/services.dart';

class PasswordResetBloc extends Bloc<PasswordResetEvent, PasswordResetState> {
  final AuthenticationService _authenticationService;

  PasswordResetBloc(AuthenticationService authenticationService)
      : assert(authenticationService != null),
        _authenticationService = authenticationService,
        super(PasswordResetInitial());

  @override
  Stream<PasswordResetState> mapEventToState(PasswordResetEvent event) async* {
    if (event is ResetPasswordPressed) {
      yield* _mapResetPasswordPressedtoState(event);
    }
  }

  Stream<PasswordResetState> _mapResetPasswordPressedtoState(
      ResetPasswordPressed event) async* {
    yield PaswwordResetLoading();
    await _authenticationService.sendPasswordReset(event.email);
    yield PasswordResetEmailSent();
  }
}

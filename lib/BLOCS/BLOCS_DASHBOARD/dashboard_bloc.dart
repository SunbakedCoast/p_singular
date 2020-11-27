import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p_singular/BLOCS/BLOCS_AUTH/authentication.dart';
import 'package:p_singular/BLOCS/BLOCS_DASHBOARD/dashboard.dart';
import 'package:p_singular/SRC/REPOSITORIES/repositories.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final AuthenticationBloc _authenticationBloc;
  final PlayerRepository _playerRepository;
  StreamSubscription _streamSubscription;

  DashboardBloc(
      AuthenticationBloc authenticationBloc, PlayerRepository playerRepository)
      : assert(authenticationBloc != null),
        assert(playerRepository != null),
        _authenticationBloc = authenticationBloc,
        _playerRepository = playerRepository,
        super(DashboardInitial());

  @override
  Stream<DashboardState> mapEventToState(DashboardEvent event) async* {
    if (event is LoadUserData) {
      yield* _mapDashboardDataLoaded();
    }
    if (event is UserDataUpdated) {
      yield* _mapUserDataUpdatedtoState(event);
    }
    if (event is LogoutBtnPressed) {
      yield* _mapLogoutBtnPressedtoState();
    }
  }

  Stream<DashboardState> _mapDashboardDataLoaded() async* {
    yield DashboardLoading();
    _streamSubscription?.cancel();

    _streamSubscription =
        _playerRepository.getUserDatafromDatabase().asStream().listen((player) {
      print(player);
      add(UserDataUpdated(player: player));
    });
  }

  Stream<DashboardState> _mapUserDataUpdatedtoState(
      UserDataUpdated event) async* {
    yield DashboardDataLoaded(player: event.player);
  }

  Stream<DashboardState> _mapLogoutBtnPressedtoState() async* {
    yield DashboardLoading();
    _authenticationBloc.add(UserLoggedOut());
  }
}

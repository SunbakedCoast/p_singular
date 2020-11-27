import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:p_singular/BLOCS/BLOCS_AUTH/authentication.dart';
import 'package:p_singular/BLOCS/BLOCS_DASHBOARD/dashboard.dart';
import 'package:p_singular/SRC/REPOSITORIES/repositories.dart';
import 'package:p_singular/pages.dart';

class DashboardProvider extends StatelessWidget {
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
      final _authBloc = BlocProvider.of<AuthenticationBloc>(context);
      if (state is AuthenticationUnauthenticated) {
        return AuthenticationStart();
      }
      if (state is AuthenticationFailure) {}
      if (state is AuthenticationAuthenticated) {
        return Dashboard();
      }
      if (state is AuthenticationLoading) {
        return _progressIndicator();
      }
    });
  }

  Widget _progressIndicator() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

class Dashboard extends StatelessWidget {
  Widget build(BuildContext context) {
    final _dashboardBloc = BlocProvider.of<DashboardBloc>(context);

    _logoutButtonPressed() {
      _dashboardBloc.add(LogoutBtnPressed());
      //_authenticationBloc.add(UserLoggedOut());
    }

    var _screenSize = MediaQuery.of(context).size;
    /*final _authBloc = BlocProvider.of<AuthenticationBloc>(context);
    final _playerRepository = RepositoryProvider.of<PlayerRepository>(context);*/
    return BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
      if (state is DashboardDataLoaded) {
        final _userName = state.player.userName;
        print('USERNAME: $_userName');
        return Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          persistentFooterButtons: [
            SizedBox(
              width: _screenSize.width,
              child: RaisedButton(
                splashColor: Theme.of(context).accentColor,
                onPressed: _logoutButtonPressed,
                color: Colors.red,
                child: Text('Log out',
                    style: GoogleFonts.poppins(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
          body: SafeArea(
              child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              RichText(
                text: TextSpan(
                  text: 'Hello ',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                    fontSize: 18
                  ),
                  children: <TextSpan>[
                    TextSpan(text: '$_userName, ',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                    )),
                  ]
                ),
              ), 
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text('Welcome to Singular! We are an online retail gaming store.', 
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.normal
                )),
              )
              ],
            ),
          )),
        );
      }
      print(state.toString());
      return Center(
        child: CircularProgressIndicator(),
      );
    });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:p_singular/BLOCS/BLOCS_AUTH/authentication.dart';
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
      if (state is AuthenticationAuthenticated) {}
    });
  }
}

class Dashboard extends StatelessWidget {
  Widget build(BuildContext context) {
    final _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);

    _logoutButtonPressed() {
      _authenticationBloc.add(UserLoggedOut());
    }

    var _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(),
      ),
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
    );
  }
}

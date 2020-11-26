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
    final _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);

    _logoutButtonPressed() {
      _authenticationBloc.add(UserLoggedOut());
    }

    var _screenSize = MediaQuery.of(context).size;
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
              Text('Username', 
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24
              )),
            ],
          ),
        )
      ),
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p_singular/BLOCS/BLOCS_AUTH/authentication.dart';
import 'package:p_singular/SRC/SERVICES/services.dart';
import 'package:p_singular/pages.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

///when I wrote this Me and God know how all these works 
///but now it's only God

///[CHECKED FOR SIMPLIFICATION]
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( RepositoryProvider<AuthenticationService>(
      create: (context) {
        return FirebaseAuthenticationService();
      },
      child: BlocProvider<AuthenticationBloc>(
        create: (context) {
          final _authService =
              RepositoryProvider.of<AuthenticationService>(context);
          return AuthenticationBloc(_authService)..add(AppLoaded());
        },
        child: Singular(),
      )));
}

class Singular extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: _themeData(),
        title: 'Singular',
        home: SafeArea(
          child: Scaffold(body:
              BlocBuilder<AuthenticationBloc, AuthenticationState>(
                  builder: (context, state) {
            //final _authBloc = BlocProvider.of<AuthenticationBloc>(context);
            if (state is AuthenticationLoading) return SplashScreen();

            if (state is AuthenticationAuthenticated) return Home();

            if (state is AuthenticationFailure) return Container();    //TODO RETURN AUTHFAILURE
        
            if (state is AuthenticationUnauthenticated)
              return AuthenticationStart();

            print('MAIN STATE: ${state.toString()}');
            return Container();
          })),
        ));
  }

  ThemeData _themeData() {
    return ThemeData(
      /*appBarTheme: AppBarTheme(elevation: 0.0, color: Colors.black12),//elevation did work
          inputDecorationTheme:
              InputDecorationTheme(border: UnderlineInputBorder()), */
        primaryColor: Color(0xFF22262F),
        //hjhjbrightness: Brightness.dark,
        backgroundColor: Color(0xFF22262F),
        accentColor: Color(0xFFF2AA4C),
        textTheme: TextTheme(
            subtitle1: GoogleFonts.montserrat(
                fontWeight: FontWeight.normal,
                fontSize: 12,
                color: Colors.white),
            subtitle2: GoogleFonts.montserrat(
                fontWeight: FontWeight.normal,
                fontSize: 14,
                color: Colors.white),
            headline1: GoogleFonts.poppins(
                fontWeight: FontWeight.w900, fontSize: 48, color: Colors.white),
            headline2: GoogleFonts.poppins(
                fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
            headline3: GoogleFonts.poppins(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
            headline4: GoogleFonts.poppins(
                fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
            headline5: GoogleFonts.poppins(
                fontSize: 9, fontWeight: FontWeight.bold, color: Colors.white),
            overline: GoogleFonts.poppins(
                fontSize: 9,
                color: Colors.white,
                fontWeight: FontWeight.w300)));
  }
}

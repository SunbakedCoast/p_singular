import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p_singular/BLOCS/BLOCS_AUTH/authentication.dart';
import 'package:p_singular/BLOCS/BLOCS_PWRESET/pwreset.dart';
import 'package:p_singular/BLOCS/BLOCS_SIGNUP/signup.dart';
import 'package:p_singular/SRC/REPOSITORIES/repositories.dart';
import 'package:p_singular/SRC/SERVICES/services.dart';
import 'package:p_singular/pages.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'BLOCS/BLOCS_SIGNIN/signin.dart';

///when I wrote this Me and God know how all these works
///but now it's only God

///[CHECKED FOR SIMPLIFICATION]
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthenticationService>(
            create: (context) => FirebaseAuthenticationService()),
        RepositoryProvider<PlayerRepository>(
            create: (context) => FireStorePlayerRepository()),
        RepositoryProvider<GamesRepository>(create: (context) => GameAPI()),

        ///REMOVED PLACED TO THE NAVIGATION RETURN [MYCART]
        //RepositoryProvider<CartRepository>(create: (context) => CartRepo())
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
            create: (context) {
              final _authService =
                  RepositoryProvider.of<AuthenticationService>(context);
              return AuthenticationBloc(_authService)..add(AppLoaded());
            },
          ),
          /*BlocProvider<DashboardBloc>(create: (context) {
            final _authBloc = BlocProvider.of<AuthenticationBloc>(context);
            final _playerRepository =
                RepositoryProvider.of<PlayerRepository>(context);
            return DashboardBloc(_authBloc, _playerRepository)
              ..add(LoadUserData());
          }), */ ///TRANSFERED TO DASHBOARD [DASHBOARD.DART]
          /*BlocProvider<SearchBloc>(create: (context) {
            final _gamesrepository =
                RepositoryProvider.of<GamesRepository>(context);
            return SearchBloc(_gamesrepository);
          }), */
          /* BlocProvider<HomeBloc>(create: (context) {
            final _gamesRepository =
                RepositoryProvider.of<GamesRepository>(context);
            return HomeBloc(_gamesRepository)..add(LoadAllData());
          }), */ ///TRANSFERED TO THE NAVIGATION [TABS_HOME.DART]
          /*BlocProvider<CartBloc>(create: (context) {
            final _cartRepository =
                RepositoryProvider.of<CartRepository>(context);
            return CartBloc(_cartRepository)..add(LoadCartData());
          }), */ ///REMOVED PLACED TO THE NAVIGATION RETURN [MYCART]
          /*BlocProvider<CategoriesBloc>(create: (context) {
            final gamesRepository =
                RepositoryProvider.of<GamesRepository>(context);
            return CategoriesBloc(gamesRepository)..add(LoadCategories());
          }), */
          BlocProvider<SignInBloc>(create: (context) {
            final _authBloc = BlocProvider.of<AuthenticationBloc>(context);
            final _authService =
                RepositoryProvider.of<AuthenticationService>(context);
            return SignInBloc(_authBloc, _authService);
          }),
          BlocProvider<SignUpBloc>(create: (context) {
            final _authBloc = BlocProvider.of<AuthenticationBloc>(context);
            final _authService =
                RepositoryProvider.of<AuthenticationService>(context);
            final _playerRepository =
                RepositoryProvider.of<PlayerRepository>(context);
            return SignUpBloc(_authBloc, _authService, _playerRepository);
          }),
          BlocProvider<PasswordResetBloc>(create: (context) {
            final _authService =
                RepositoryProvider.of<AuthenticationService>(context);
            return PasswordResetBloc(_authService);
          })
        ],
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
            if (state is AuthenticationLoading) return SplashScreen();

            if (state is AuthenticationAuthenticated) return Home();

            if (state is AuthenticationFailure) return ExceptionWidget(exception: state.errorMessage);

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

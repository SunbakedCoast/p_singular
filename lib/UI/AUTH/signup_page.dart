import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:p_singular/BLOCS/BLOCS_AUTH/authentication.dart';
import 'package:p_singular/BLOCS/BLOCS_SIGNUP/signup.dart';
import 'package:p_singular/SRC/MODELS/models.dart';

class SignUp extends StatelessWidget {
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
      //final _authBloc = BlocProvider.of<AuthenticationBloc>(context);
      if (state is AuthenticationUnauthenticated) {
        print(state.toString());
        return _Form();
      }
      if (state is AuthenticationFailure) {
        print(state.toString());
        return _Form();
      }
      if (state is AuthenticationAuthenticated) {
        print(state.toString());
       print(state.toString());
        Navigator.popUntil(
            context, ModalRoute.withName(Navigator.defaultRouteName));
      }
      print('Auth State ${state.toString()}');
      return _progressIndicator();
    });
  }

  Widget _progressIndicator() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

class _Form extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(child: _SignUpForm()),
    );
  }
}

/*class _Form extends StatelessWidget {
  Widget build(BuildContext context) {
    var _screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: RepositoryProvider<PlayerRepository>(
            create: (context) => FireStorePlayerRepository(),
            child: BlocProvider<SignUpBloc>(
              create: (context) {
                final _authBloc = BlocProvider.of<AuthenticationBloc>(context);
                final _authService =
                    RepositoryProvider.of<AuthenticationService>(context);
                final _playerRepository =
                    RepositoryProvider.of<PlayerRepository>(context);
                return SignUpBloc(_authBloc, _authService, _playerRepository);
              },
              child: _SignUpForm(),
            )),
      ),
    );
  }
} */

class _SignUpForm extends StatefulWidget {
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<_SignUpForm> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _userNameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  //bool _validate = false;

  Widget build(BuildContext context) {
    var _screenSize = MediaQuery.of(context).size;
    // ignore: close_sinks
    final _signupBloc = BlocProvider.of<SignUpBloc>(context);

    _signupButtonPressed() {
      if (_key.currentState.validate()) {
        _signupBloc.add(SignUpButtonPressed(
            email: _emailTextController.text.trim(),
            password: _passwordTextController.text.trim()));
        _signupBloc.add(SendUserDataWithButtonPressed(
            player: Player(
          userName: _userNameTextController.text.trim(),
          email: _emailTextController.text.trim(),
        )));
      }
      /* else {
        setState(() {
          _validate = true;
        });
      } */
    }


    return BlocListener<SignUpBloc, SignUpState>(listener: (context, state) {
      if (state is SignUpFailure) {
        return _showError(context, state.error);
      }
    }, child: BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
      if (state is SignUpLoading) {
        return _showProgressIndicator();
      }
      if (state is SignUpFailure) {
        print(state.toString());
      }
      if (state is SignUpInitial) {
        print(state.toString());
      }
      return Center(
        child: Form(
          key: _key,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 30),
                  child: Text('Create account with Singular',
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22)),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 30),
                  child: Text('Hello there!',
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 12)),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 30, right: 30, top: 10),
                  child: TextFormField(
                    //autocorrect: false,
                    keyboardType: TextInputType.name,
                    controller: _userNameTextController,
                    style: GoogleFonts.poppins(
                        color: Colors.white, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      hintText: 'Username',
                      hintStyle: GoogleFonts.poppins(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Username is required';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 30, right: 30, top: 10),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailTextController,
                    style: GoogleFonts.poppins(
                        color: Colors.white, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      hintText: 'Email',
                      hintStyle: GoogleFonts.poppins(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Email is required';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 30, right: 30, top: 10),
                  child: TextFormField(
                    //autocorrect: false,
                    obscureText: true,
                    controller: _passwordTextController,
                    style: GoogleFonts.poppins(
                        color: Colors.white, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      hintText: 'Password 6+ characters',
                      hintStyle: GoogleFonts.poppins(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
                    validator: (value) {
                      if (value.length < 6) {
                        return 'Password must be greater than 6 characters';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(30),
                  child: SizedBox(
                    width: _screenSize.width,
                    child: RaisedButton(
                      elevation: 4.0,
                      splashColor: Colors.white,
                      onPressed:
                          state is SignUpLoading ? () {} : _signupButtonPressed,
                      color: Theme.of(context).accentColor,
                      child: Text(
                        'Count me in!',
                        style: GoogleFonts.poppins(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }));
  }

  _showError(BuildContext context, String error) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(error),
      backgroundColor: Colors.red,
    ));
  }

  Widget _showProgressIndicator() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

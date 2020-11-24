import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:p_singular/BLOCS/BLOCS_AUTH/authentication.dart';
import 'package:p_singular/BLOCS/BLOCS_SIGNUP/signup.dart';
import 'package:p_singular/SRC/MODELS/models.dart';
import 'package:p_singular/SRC/REPOSITORIES/repositories.dart';
import 'package:p_singular/SRC/SERVICES/services.dart';
import 'package:p_singular/pages.dart';

class SignUp extends StatelessWidget {
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
      final _authBloc = BlocProvider.of<AuthenticationBloc>(context);
      if (state is AuthenticationUnauthenticated) {
        print(state.toString());
        return _Form();
      }
      if (state is AuthenticationFailure) {
        print(state.toString());
      }
      if (state is AuthenticationAuthenticated) {
        print(state.toString());
        return Home();
      }
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
}

class _SignUpForm extends StatefulWidget {
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<_SignUpForm> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _userNameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  bool _validate = false;

  Widget build(BuildContext context) {
    var _screenSize = MediaQuery.of(context).size;
    final _signupBloc = BlocProvider.of<SignUpBloc>(context);

    _signupButtonPressed() {
      if (_key.currentState.validate()) {
        _signupBloc.add(SignUpButtonPressed(
            email: _emailTextController.text,
            password: _passwordTextController.text));
        _signupBloc.add(SendUserDataWithButtonPressed(
            player: Player(
          userName: _userNameTextController.text,
          email: _emailTextController.text,
        )));
      } else {
        setState(() {
          _validate = true;
        });
      }
    }

    return BlocListener<SignUpBloc, SignUpState>(listener: (context, state) {
      if (state is SignUpFailure) {
        return _showError(state.error);
      }
    }, child: BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
      if (state is SignUpLoading) {
        return _showProgressIndicator();
      }
      if (state is SignUpInitial) {
        return Center(
          child: Form(
            key: _key,
            autovalidateMode: AutovalidateMode.always,
            child: SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 30, right: 30, top: 10),
                    child: TextFormField(
                      //autocorrect: false,
                      keyboardType: TextInputType.name,
                      controller: _userNameTextController,
                      style: GoogleFonts.poppins(
                          color: Colors.white, fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        hintText: 'User Name',
                        hintStyle:  GoogleFonts.poppins(
                            color: Colors.grey, fontWeight: FontWeight.bold),
                      ),
                      validator: (value) {
                        if (value == null) {
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
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailTextController,
                      style: GoogleFonts.poppins(
                          color: Colors.white, fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        hintText: 'Email',
                        hintStyle:  GoogleFonts.poppins(
                            color: Colors.grey, fontWeight: FontWeight.bold),
                      ),
                      validator: (value) {
                        if (value == null) {
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
                        hintStyle:  GoogleFonts.poppins(
                            color: Colors.grey, fontWeight: FontWeight.bold),
                      ),
                      validator: (value) {
                        if (value == null) {
                          return 'Email is required';
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
                        onPressed: state is SignUpLoading
                            ? () {}
                            : _signupButtonPressed,
                        color: Theme.of(context).accentColor,
                        child: Text(
                          'Count me in!',
                          style:  GoogleFonts.poppins(
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
      }
    }));
  }

  _showError(String error) {
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p_singular/BLOCS/BLOCS_AUTH/authentication.dart';
import 'package:p_singular/BLOCS/BLOCS_SIGNIN/signin.dart';
import 'package:p_singular/SRC/SERVICES/services.dart';
import 'package:p_singular/pages.dart';

class SignIn extends StatelessWidget {
  Widget build(BuildContext context) {
    var _screenSize = MediaQuery.of(context).size;
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
      final _authBloc = BlocProvider.of<AuthenticationBloc>(context);
      if (state is AuthenticationUnauthenticated) {
        return _Form();
      }
      if (state is AuthenticationFailure) {
        //return AuthenticationExceptionWidget(authBloc: _authBloc, error: 'Authentication Error');
      }
      if (state is AuthenticationAuthenticated) {
        return Home();
      }

      return _progressIndicator();
    });
  }

  /*
  Widget _authenticationFailure(
      AuthenticationBloc authBloc, Size screenSize, String error) {
    return GestureDetector(
      onTap: () => authBloc.add(AppLoaded()),
      child: Container(
        height: screenSize.height,
        width: screenSize.width,
        child: Center(
          child: Text(error),
        ),
      ),
    );
  }
  //TODO REMOVE OR CHANGE IF NOT VIAGBLE
  Widget _authenticationFailureTestWidget(AuthenticationBloc authBloc, Size screenSize, String error){
    return 
  }
 */
  Widget _progressIndicator() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

class _Form extends StatelessWidget {
  Widget build(BuildContext context) {
    var _screenSize = MediaQuery.of(context).size;
    final _authService = RepositoryProvider.of<AuthenticationService>(context);
    final _authBloc = RepositoryProvider.of<AuthenticationBloc>(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
            height: _screenSize.height,
            width: _screenSize.width,
            child: BlocProvider<SignInBloc>(
              create: (context) => SignInBloc(_authBloc, _authService),
              child: _SignInForm(),
            )),
      ),
    );
  }
}

class _SignInForm extends StatefulWidget {
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<_SignInForm> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _validate = false;

  Widget build(BuildContext context) {
    var _screenSize = MediaQuery.of(context).size;
    final _signinBloc = BlocProvider.of<SignInBloc>(context);

    _loginButtonPressed() {
      if (_key.currentState.validate()) {
        _signinBloc.add(SignInButtonPressed(
            email: _emailController.text, password: _passwordController.text));
      } else {
        setState(() {
          _validate = true;
        });
      }
    }

    return BlocListener<SignInBloc, SignInState>(listener: (context, state) {
      if (state is SignInFailure) {
        return _showError(state.error);
      }
    }, child: BlocBuilder<SignInBloc, SignInState>(builder: (context, state) {
      if (state is SignInLoading) {
        _showProgressIndicator();
      }
      if (state is SignInInitial) {
        print('initial state test');
        return Form(
          key: _key,
          autovalidate: _validate,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 30, right: 30, top: 10),
                child: TextFormField(
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  style: TextStyle(fontFamily: 'OSLight'),
                  decoration: InputDecoration(
                    hintText: 'Email',
                    hintStyle: TextStyle(fontFamily: 'OSRegular'),
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
                margin: const EdgeInsets.only(left: 30, right: 30, top: 30),
                child: TextFormField(
                    keyboardType: TextInputType.name,
                    controller: _passwordController,
                    obscureText: true,
                    style: TextStyle(fontFamily: 'OSLight'),
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: TextStyle(fontFamily: 'OSRegular'),
                    ),
                    validator: (value) {
                      if (value == null) {
                        return 'Password is required';
                      } else {
                        return null;
                      }
                    }),
              ),
              Container(
                margin: const EdgeInsets.all(30),
                child: SizedBox(
                  width: _screenSize.width,
                  child: RaisedButton(
                    elevation: 4.0,
                    splashColor: Colors.white,
                    onPressed:
                        state is SignInLoading ? () {} : _loginButtonPressed,
                    color: Colors.black,
                    child: Text(
                      'Log in',
                      style: TextStyle(
                          fontFamily: 'OSBold',
                          color: Colors.white,
                          fontSize: 14.0),
                    ),
                  ),
                ),
              )
            ],
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

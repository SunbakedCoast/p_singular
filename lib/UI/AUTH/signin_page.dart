import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:p_singular/BLOCS/BLOCS_AUTH/authentication.dart';
import 'package:p_singular/BLOCS/BLOCS_SIGNIN/signin.dart';
import 'package:p_singular/pages.dart';

class SignIn extends StatelessWidget {
  Widget build(BuildContext context) {
    var _screenSize = MediaQuery.of(context).size;
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
      final _authBloc = BlocProvider.of<AuthenticationBloc>(context);
      if (state is AuthenticationUnauthenticated) {
        print(state.toString());
        return _Form();
      }
      if (state is AuthenticationFailure) {
        print(state.toString());
        return _authenticationFailure(
            _authBloc, _screenSize, state.errorMessage);
      }
      if (state is AuthenticationAuthenticated) {
        print(state.toString());

        return Home();
      }
      print('Sign in state: ${state.toString()}');
      return _progressIndicator();
    });
  }

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
  /* Widget _authenticationFailureTestWidget(AuthenticationBloc authBloc, Size screenSize, String error){
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
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Container(
          height: _screenSize.height,
          width: _screenSize.width,
          child: _SignInForm(),
        ),
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
  //bool _validate = false;

  Widget build(BuildContext context) {
    var _screenSize = MediaQuery.of(context).size;
    final _signinBloc = BlocProvider.of<SignInBloc>(context);

    _loginButtonPressed() {
      if (_key.currentState.validate()) {
        _signinBloc.add(SignInButtonPressed(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim()));
      }
    }

    return BlocListener<SignInBloc, SignInState>(listener: (context, state) {
      if (state is SignInFailure) {
        return _showError(context,state.error);
      }
    }, child: BlocBuilder<SignInBloc, SignInState>(builder: (context, state) {
      if (state is SignInLoading) {
        _showProgressIndicator();
      }
      if (state is SignInInitial) {
        print('initial state test');
        return Form(
          key: _key,
          autovalidateMode: AutovalidateMode.always,
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: Text('Welcome back!',
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 22)),
                    ),
                    Container(
                     margin: const EdgeInsets.only(bottom: 10),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        style: GoogleFonts.poppins(
                            color: Colors.white, fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          hintText: 'Email',
                          hintStyle: GoogleFonts.poppins(
                              color: Colors.grey, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Container(
                      //margin: const EdgeInsets.only(left: 30, right: 30, top: 30),
                      child: TextFormField(
                          keyboardType: TextInputType.name,
                          controller: _passwordController,
                          obscureText: true,
                          style: GoogleFonts.poppins(
                              color: Colors.white, fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: GoogleFonts.poppins(
                                color: Colors.grey, fontWeight: FontWeight.bold),
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
                      margin: const EdgeInsets.only(top: 20, bottom: 10),
                      child: SizedBox(
                        width: _screenSize.width,
                        child: RaisedButton(
                          elevation: 4.0,
                          splashColor: Colors.black,
                          onPressed: state is SignInLoading
                              ? () {}
                              : _loginButtonPressed,
                          color: Theme.of(context).accentColor,
                          child: Text(
                            'Log in',
                            style: GoogleFonts.poppins(
                                color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ResetPassword()));
                          },
                          child: Text(
                            'Forgot your password?',
                            style: GoogleFonts.poppins(
                                color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }
      print('Sign in state: ${state.toString()}');
      return _showProgressIndicator();
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:p_singular/BLOCS/BLOCS_PWRESET/pwreset.dart';
import 'package:p_singular/pages.dart';

class ResetPassword extends StatelessWidget {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  Widget build(BuildContext context) {
    var _screenSize = MediaQuery.of(context).size;
    final _passwordResetBloc = BlocProvider.of<PasswordResetBloc>(context);

    _resetPasswordPressed() {
      if (_key.currentState.validate()) {
        _passwordResetBloc
            .add(ResetPasswordPressed(email: _emailController.text.trim()));
      }
    }

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: BlocListener<PasswordResetBloc, PasswordResetState>(
          listener: (context, state) {
        if (state is PasswordResetEmailSent) {
          return _showMessage(
              context, 'A password reset link has been sent to your email');
        }
      }, child: BlocBuilder<PasswordResetBloc, PasswordResetState>(
              builder: (context, state) {
        if (state is PasswordResetInitial) {
          return Form(
            key: _key,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Reset Password',
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18)),
                      Container(
                        margin: const EdgeInsets.only(top: 20, bottom: 5),
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailController,
                          style: GoogleFonts.poppins(
                              color: Colors.white, fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            hintText: 'Email',
                            hintStyle: GoogleFonts.poppins(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please provide an email';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 5, bottom: 10),
                        child: SizedBox(
                          width: _screenSize.width,
                          child: RaisedButton(
                            elevation: 4.0,
                            splashColor: Colors.black,
                            onPressed: state is PaswwordResetLoading
                                ? () {}
                                : _resetPasswordPressed,
                            color: Theme.of(context).accentColor,
                            child: Text(
                              'Reset',
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        if (state is PasswordResetEmailSent) {
          return SignIn();
        }
        print(state.toString());
        return _showProgressIndicator();
      })),
    );
  }

  _showMessage(BuildContext context, String message) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Theme.of(context).accentColor,
    ));
  }

  Widget _showProgressIndicator() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

/* Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Reset Password',
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18)),
                Container(
                  margin: const EdgeInsets.only(top: 20, bottom: 5),
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
                  margin: const EdgeInsets.only(top: 5, bottom: 10),
                  child: SizedBox(
                    width: _screenSize.width,
                    child: RaisedButton(
                      elevation: 4.0,
                      splashColor: Colors.black,
                      onPressed: () {},
                      color: Theme.of(context).accentColor,
                      child: Text(
                        'Log in',
                        style: GoogleFonts.poppins(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ), */

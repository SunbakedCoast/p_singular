import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:p_singular/pages.dart';

///TODO [UPDATE UI]
class AuthenticationStart extends StatelessWidget {
  Widget build(BuildContext context) {
    var _screenSize = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(10),
      width: _screenSize.width,
      height: _screenSize.height,
      color: Theme.of(context).backgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: _screenSize.width,
            child: RaisedButton(
                splashColor: Theme.of(context).accentColor,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignIn()));
                },
                child: Text('Sign in')),
          ),
          SizedBox(
            width: _screenSize.width,
            child: RaisedButton(
                splashColor: Theme.of(context).accentColor,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUp()));
                },
                child: Text('Sign up')),
          )
        ],
      ),
    );
  }
}

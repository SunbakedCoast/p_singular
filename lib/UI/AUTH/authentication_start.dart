import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:p_singular/UI/VALUES/page_offset.dart';
import 'package:p_singular/WIDGETS/widgets.dart';
import 'package:provider/provider.dart';

class AuthenticationStart extends StatefulWidget {
  _AuthenticationStartState createState() => _AuthenticationStartState();
}

class _AuthenticationStartState extends State<AuthenticationStart>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  final PageController _pageController = PageController();

  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
  }

  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PageOffsetNotifier(_pageController),
      child: ListenableProvider.value(
        value: _animationController,
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          body: Stack(
            children: [
              Stack(
                children: [
                  PageView(
                    controller: _pageController,
                    physics: ClampingScrollPhysics(),
                    children: [PageOne(), PageTwo()],
                  ),
                  PageIndicator(),
                  AuthButtons()
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

//PageIndicator(), AuthButtons()

/* child: Column(
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
      ), */

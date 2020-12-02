import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:p_singular/UI/VALUES/page_offset.dart';
import 'package:p_singular/WIDGETS/widgets.dart';
import 'package:p_singular/pages.dart';
import 'package:provider/provider.dart';

///TODO [UPDATE UI]
class AuthenticationStart extends StatelessWidget {
  final PageController _pageController = PageController();
  Widget build(BuildContext context) {
    //var _screenSize = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (_) => PageOffsetNotifier(_pageController),
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Stack(
          children: [
            Stack(
              children: [
                PageView(
                  controller: _pageController,
                  physics: BouncingScrollPhysics(),
                  children: [PageOne(), PageTwo()],
                ),
                PageIndicator(),
                AuthButtons()
              ],
            )
          ],
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

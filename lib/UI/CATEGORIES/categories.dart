import 'package:animations/animations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p_singular/BLOCS/BLOCS_CATEGORIES/categories.dart';
import 'package:p_singular/UI/VALUES/values.dart';
import 'package:p_singular/pages.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Categories extends StatelessWidget {
  final String category;
  final int gradientOne;
  final int gradientTwo;

  Categories(
      {@required this.category,
      @required this.gradientOne,
      @required this.gradientTwo});
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: screenHeight(context),
          width: screenHeight(context),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(gradientOne), Color(gradientTwo)])),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.all(20),
                child: Text(category,
                    style: Theme.of(context).textTheme.headline1),
              ),
              CategoriesSlider(category: category)
            ],
          )),
    );
  }
}

class CategoriesSlider extends StatefulWidget {
  final String category;

  CategoriesSlider({@required this.category});
  _CategoriesSliderState createState() => _CategoriesSliderState();
}

class _CategoriesSliderState extends State<CategoriesSlider> {
  final PageController _pageController = PageController(viewportFraction: 0.8);

  int currentPage = 0;

  void initState() {
    super.initState();
    _pageController.addListener(() {
      int next = _pageController.page.round();

      if (currentPage != next) {
        setState(() {
          currentPage = next;
        });
      }
    });
  }

  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesBloc, CategoriesState>(
        builder: (context, state) {
      if (state is CategoriesLoaded) {
        final _gameState = state.games;
        final _games =
            _gameState.where((game) => game.genre == widget.category).toList();
        print('${widget.category} COUNT: ${_games.length}');
        return Container(
          child: Expanded(
            child: Container(
                child: PageView.builder(
                    physics: BouncingScrollPhysics(),
                    controller: _pageController,
                    itemCount: _games.length,
                    itemBuilder: (context, currentIdx) {
                      // if (3 >= currentIdx) {
                      bool active = currentIdx == currentPage;
                      return _animatedContainer(
                          active: active,
                          image: _games[currentIdx].image,
                          name: _games[currentIdx].name,
                          description: _games[currentIdx].description,
                          isMultiplayer: _games[currentIdx].isMultiplayer,
                          genre: _games[currentIdx].genre,
                          isFeatured: _games[currentIdx].isFeatured,
                          price: _games[currentIdx].price,
                          platforms: _games[currentIdx].platforms,
                          developer: _games[currentIdx].developer,
                          language: _games[currentIdx].language);
                    })),
          ),
        );
      }
      if (state is CategoriesLoading) {
        return _progressIndicator();
      }
    }

        ///TODO [RETURN WIDGET]
        );
  }

  Widget _progressIndicator() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  _animatedContainer(
      {bool active,
      String image,
      String name,
      String description,
      String isMultiplayer,
      String genre,
      bool isFeatured,
      int price,
      List<dynamic> platforms,
      String developer,
      String language}) {
    final double blur = active ? 10 : 5;
    final double offset = active ? 6 : 0;
    final double top = active ? 15 : 100;
    final double bottom = active ? 15 : 100;

    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeOutQuint,
      margin: EdgeInsets.only(top: top, bottom: bottom, right: 15, left: 15),
      //padding: const EdgeInsets.all(3.0),
      child: OpenContainer(
          closedBuilder: (_, openContainer) {
            return Container(
              //duration: Duration(milliseconds: 100),
              //curve: Curves.easeOutQuint,
              //margin: EdgeInsets.only(top: top, bottom: bottom, right: 15, left: 15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      topLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                      bottomLeft: Radius.circular(15)),
                  image: DecorationImage(
                      fit: BoxFit.cover, image: NetworkImage(image)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black87,
                        blurRadius: blur,
                        offset: Offset(offset, offset))
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AspectRatio(
                    aspectRatio: 2 / 0.6,
                    child: AnimatedContainer(
                      padding: const EdgeInsets.all(10),
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeOutQuint,
                      height: 100,
                      width: 200,
                      decoration: BoxDecoration(
                        gradient: active
                            ? LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                    Colors.transparent,
                                    Colors.black
                                  ]) //Theme.of(context).backgroundColor.withOpacity(0.9)
                            : null,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(0),
                            bottomRight: Radius.circular(5),
                            bottomLeft: Radius.circular(15)),
                      ),
                      child: active
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: Text(name,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline3),
                                ),

                                ///[textTheme]
                                Row(
                                  children: [
                                    Text(platforms.join(" "),
                                        style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300)),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          left: 10, right: 5),
                                      width: 3,
                                      height: 20,
                                      color: Theme.of(context).accentColor,
                                    ),
                                    Text('\$${price.toString()}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4)
                                  ],
                                ),
                              ],
                            )
                          : null,
                    ),
                  )
                ],
              ),
            );
          },
          closedElevation: 5,
          closedColor: Colors.black12,
          closedShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15),
                  topLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                  bottomLeft: Radius.circular(15))),
          openBuilder: (_, closeContainer) {
            return Details(
              image: image,
              name: name,
              description: description,
              isMultiplayer: isMultiplayer,
              genre: genre,
              isFeatured: isFeatured,
              price: price,
              platforms: platforms,
              developer: developer,
              language: language,
            );
          }),
    );
  }
}

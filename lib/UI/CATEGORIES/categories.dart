import 'package:animations/animations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p_singular/BLOCS/BLOCS_CATEGORIES/categories.dart';
import 'package:p_singular/SRC/REPOSITORIES/games_repository.dart';
import 'package:p_singular/pages.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoriesSlider extends StatefulWidget {
  final String category;
  final int gradientOne;
  final int gradientTwo;

  CategoriesSlider(
      {@required this.category,
      @required this.gradientOne,
      @required this.gradientTwo});
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
    var _screenSize = MediaQuery.of(context).size;
    return RepositoryProvider<GamesRepository>(
      create: (context) => GameAPI(),
      child: BlocProvider<CategoriesBloc>(
        create: (context) {
          final gamesRepository =
              RepositoryProvider.of<GamesRepository>(context);
          return CategoriesBloc(gamesRepository)..add(LoadCategories());
        },
        child: BlocBuilder<CategoriesBloc, CategoriesState>(
            builder: (context, state) {
          if (state is CategoriesLoaded) {
            final _games = state.games;
            final _gamesCount =
                _games.where((game) => game.genre == widget.category).toList();
            print('${widget.category} COUNT: $_gamesCount');
            return SafeArea(
              child: Scaffold(
                body: Container(
                  height: _screenSize.height,
                  width: _screenSize.width,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(widget.gradientOne),
                          Color(widget.gradientTwo)
                        ]),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(20),
                        child: Text(widget.category,
                            style: Theme.of(context).textTheme.headline1),
                      ),
                      //pageview
                      Container(
                        child: Expanded(
                          child: Container(
                              child: PageView.builder(
                                  physics: BouncingScrollPhysics(),
                                  controller: _pageController,
                                  itemCount: _gamesCount.length,
                                  itemBuilder: (context, currentIdx) {
                                    // if (3 >= currentIdx) {
                                    bool active = currentIdx == currentPage;
                                    return _animatedContainer(
                                        active: active,
                                        name: _gamesCount[currentIdx].name,
                                        image: _gamesCount[currentIdx].image);
                                    //}
                                  })),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }
          if (state is CategoriesLoading) {
            return _progressIndicator();
          }
        }),
      ),
    );
  }

  Widget _progressIndicator() {
    return Stack(
        children: [
          Center(
            child: CircularProgressIndicator(),
          )
        ],
    );
  }

  _animatedContainer({
    bool active,
    String name,
    String image,
  }) {
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
                        color: active
                            ? Theme.of(context).backgroundColor.withOpacity(0.9)
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
                                  child: Text(
                                    name,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: GoogleFonts.lora(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(Icons.person,
                                          color: Colors.white, size: 18),
                                      Container(
                                        margin: const EdgeInsets.only(left: 5),
                                        child: Text('0',
                                            style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  Theme.of(context).accentColor,
                                            )),
                                      )
                                    ],
                                  ),
                                )
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
            return Details();
          }),
    );
  }
}

/* child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeOutQuint,
        margin: EdgeInsets.only(top: top, bottom: bottom, right: 30),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(15),
                topLeft: Radius.circular(5),
                bottomRight: Radius.circular(5),
                bottomLeft: Radius.circular(15),
                ),
                  image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage('https://cdn-l-cyberpunk.cdprojektred.com/wallpapers/1080x1920/CP77-KV-en.jpg')
                      ), 
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
                  color: active ? Theme.of(context).backgroundColor.withOpacity(0.9) : null,
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
                            child: Text(
                              'Cyberpunk: 2077',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: GoogleFonts.lora(
                                  color: Colors.white, 
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.favorite_outline,
                                    color: Colors.white, size: 18),
                                Container(
                                  margin: const EdgeInsets.only(left: 5),
                                  child: Text('0',
                                      style: GoogleFonts.lora(
                                        color: Colors.white,
                                      )),
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    : null,
              ),
            )
          ],
        ),
      ), */

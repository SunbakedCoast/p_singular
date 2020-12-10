import 'package:animations/animations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p_singular/BLOCS/BLOCS_SEARCH/search.dart';
import 'package:p_singular/SRC/MODELS/models.dart';
import 'package:p_singular/UI/VALUES/values.dart';
import 'package:p_singular/pages.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:p_singular/SRC/REPOSITORIES/repositories.dart';
import 'package:p_singular/BLOCS/BLOCS_CART/cart.dart';

///TODO ADD ALL [textTheme] to [themeData];
///K[CHECKED FOR SIMPLIFICATION]
class Home extends StatefulWidget {
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  final _scrollController = ScrollController();

  /*TabController _tabController;

  final List<Tab> _tabs = [
    Tab(text: 'Home'),
    Tab(text: 'Most played'),
  ];

  void initState() {
    super.initState();
    _tabController = TabController(
      vsync: this,
      length: _tabs.length,
    );
  }

  void dispose() {
    _tabController.dispose();
    super.dispose();
  } */

  Widget build(BuildContext context) {
    return BlocProvider<SearchBloc>(
      create: (context) {
        final _gamesrepository =
            RepositoryProvider.of<GamesRepository>(context);
        return SearchBloc(_gamesrepository);
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        floatingActionButton: OpenContainer(
            closedBuilder: (_, openContainer) {
              return FloatingActionButton(
                elevation: 0.0,
                onPressed: openContainer,
                backgroundColor: Theme.of(context).accentColor,
                child: Icon(
                  Icons.shopping_cart,
                  color: Colors.black,
                ),
              );
            },
            openColor: Theme.of(context).accentColor,
            closedElevation: 5.0,
            closedShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100)),
            closedColor: Theme.of(context).accentColor,
            openBuilder: (_, closeContainer) {
              return RepositoryProvider<CartRepository>(
                create: (context) => CartRepo(),
                child: BlocProvider<CartBloc>(
                    create: (context) {
                      final _cartRepository =
                          RepositoryProvider.of<CartRepository>(context);
                      return CartBloc(_cartRepository)..add(LoadCartData());
                    },
                    child: MyCart()),
              );
            }),
        body: SafeArea(
          child: NestedScrollView(
              controller: _scrollController,
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxScrolled) {
                return [
                  SliverAppBar(
                    backgroundColor: Theme.of(context).backgroundColor,
                    title: Text('Singular',
                        style: GoogleFonts.bitter(
                            fontWeight: FontWeight.w900,
                            color: Theme.of(context).accentColor)),
                    pinned: false,
                    floating: true,
                    actions: [
                      IconButton(
                        icon: Icon(Icons.search),
                        color: Colors.white,
                        onPressed: () async {
                          Games selected = await showSearch<Games>(
                              context: context,
                              delegate: SearchData(
                                  BlocProvider.of<SearchBloc>(context)));
                          print('selected: $selected');
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.person_outline_outlined),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DashboardProvider()));
                        },
                      )
                    ],
                    forceElevated: innerBoxScrolled,
                    /*bottom: TabBar(
                    labelStyle:
                        GoogleFonts.poppins(fontWeight: FontWeight.bold),
                    labelColor: Theme.of(context).accentColor,
                    unselectedLabelColor: Colors.grey,
                    isScrollable: true,
                    indicatorSize: TabBarIndicatorSize.label,
                    tabs: _tabs,
                    controller: _tabController,
                  ), */
                  )
                ];
              },
              body: HomeTab()),
        ),
      ),
    );
  }
}

class SearchData extends SearchDelegate<Games> {
  final Bloc<SearchEvent, SearchState> gamesBloc;

  SearchData(this.gamesBloc);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {},
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {});
  }

  @override
  Widget buildResults(BuildContext context) {
    gamesBloc.add(SearchEvent(query));
    return BlocBuilder<SearchBloc, SearchState>(
        cubit: gamesBloc,
        builder: (context, state) {
          if (state.isLoading) return _progressIndicator();
          if (state.hasError) return _error(state.error);

          ///[FOR DEBUGGING PURPOSES ONLY]
          print('CURRENTSTATE: $state');
          print('GAMES LENGHT IS EQUAL TO: ${state.games.length}');

          ///[FOR DEBUGGING PURPOSES ONLY]
          return GridView.builder(
              padding: const EdgeInsets.all(10),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(),
              itemCount: state.games.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0),
              itemBuilder: (context, index) => _item(
                  context: context,
                  image: state.games[index].image,
                  name: state.games[index].name,
                  description: state.games[index].description,
                  isMultiplayer: state.games[index].isMultiplayer,
                  genre: state.games[index].genre,
                  isFeatured: state.games[index].isFeatured,
                  price: state.games[index].price,
                  platforms: state.games[index].platforms,
                  developer: state.games[index].developer,
                  language: state.games[index].language));
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }

  Widget _item(
      {BuildContext context,
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
    return OpenContainer(
        closedBuilder: (_, openContainer) {
          return Container(
            height: 140,
            width: 150,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover, image: NetworkImage(image))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  width: screenWidth(context) * 0.9,
                  height: 100,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, Colors.black])),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Text(
                                  name,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: GoogleFonts.poppins(
                                    fontSize: 9,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Text(
                                platforms.join(" "),
                                style: GoogleFonts.poppins(
                                  fontSize: 9,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 10, right: 5),
                        width: 3,
                        height: 20,
                        color: Theme.of(context).accentColor,
                      ),
                      Text('\$${price.toString()}',
                          style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        closedElevation: 5,
        closedShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
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
        });
  }

  Widget _progressIndicator() => Center(
        child: CircularProgressIndicator(),
      );

  Widget _error(String error) => Center(
        child: Text(error),
      );
}

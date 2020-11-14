import 'package:animations/animations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p_singular/BLOCS/BLOCS_SEARCH/search.dart';
import 'package:p_singular/SRC/MODELS/models.dart';
import 'package:p_singular/SRC/REPOSITORIES/repositories.dart';
import 'package:p_singular/pages.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

///TODO ADD ALL [textTheme] to [themeData]
class Home extends StatefulWidget {
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  final _scrollController = ScrollController();
  TabController _tabController;

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
  }

  Widget build(BuildContext context) {
    return RepositoryProvider<GamesRepository>(
      create: (context) => GameAPI(),
      child: BlocProvider<SearchBloc>(
        create: (context) {
          final gamesRepository =
              RepositoryProvider.of<GamesRepository>(context);
          return SearchBloc(gamesRepository);
        },
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            body: NestedScrollView(
              controller: _scrollController,
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxScrolled) {
                return [
                  SliverAppBar(
                    backgroundColor: Theme.of(context).backgroundColor,
                    title: Text('Singular',
                        style: GoogleFonts.bitter(
                          fontWeight: FontWeight.bold,
                        )),
                    pinned: true,
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
                        onPressed: () {},
                      )
                    ],
                    forceElevated: innerBoxScrolled,
                    bottom: TabBar(
                      labelStyle:
                          GoogleFonts.montserrat(fontWeight: FontWeight.bold),
                      labelColor: Theme.of(context).accentColor,
                      unselectedLabelColor: Colors.grey,
                      isScrollable: true,
                      indicatorSize: TabBarIndicatorSize.label,
                      tabs: _tabs,
                      controller: _tabController,
                    ),
                  )
                ];
              },
              body: TabBarView(
                children: [HomeProvider(), MostPlayedTab()],
                controller: _tabController,
              ),
            ),
          ),
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
    var _screenSize = MediaQuery.of(context).size;
    gamesBloc.add(SearchEvent(query));
    //TODO ADD BLOCPROVIDER
    return RepositoryProvider<GamesRepository>(
      create: (context) => GameAPI(),
      child: BlocProvider<SearchBloc>(
        create: (context) {
          final gamesRepository =
              RepositoryProvider.of<GamesRepository>(context);
          return SearchBloc(gamesRepository);
        },
        child: BlocBuilder<SearchBloc, SearchState>(
            cubit: gamesBloc,
            builder: (context, state) {
              if (state.isLoading) {
                print('state is loading');
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state.hasError) {
                return Container(
                  child: Center(
                    child: Text('errorTest'),
                  ),
                );
              }
              print('CURRENTSTATE: $state');
              print('GAMES LENGHT IS EQUAL TO: ${state.games.length}');
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
                      screenSize: _screenSize,
                      image: state.games[index].image,
                      name: state.games[index].name,
                      description: state.games[index].description,
                      //isFourK: state.games[index].isFourK,
                      isMultiplayer: state.games[index].isMultiplayer,
                      //players: state.games[index].players,
                      genre: state.games[index].genre,
                      isFeatured: state.games[index].isFeatured,
                      price: state.games[index].price,
                      platforms: state.games[index].platforms,
                      developer: state.games[index].developer,
                      language: state.games[index].language)
                  /*ListTile(
                title: Text(state.games[index].name)
              ) */
                  );
              /*ListTile(
                    title: Text(state.games[index].name),
                    leading: Icon(Icons.ac_unit),
                  )); */

              //print('GAMES LENGHT IS EQUAL TO: ${state.games.length}');
              /*return ListView.builder(
              itemCount: state.games.length,
              itemBuilder: (context, index) => ListTile(
                    title: Text(state.games[index].name),
                  )); */
            }),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }

  Widget _item(
      {BuildContext context,
      Size screenSize,
      String image,
      String name,
      String description,
      //bool isFourK,
      String isMultiplayer,
      //int players,
      String genre,
      bool isFeatured,
      int price,
      List<dynamic> platforms,
      String developer,
      String language}) {
    /* return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container( 
          margin: const EdgeInsets.only(bottom: 5),
          child: */
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
                  width: screenSize.width * 0.9,
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
            //isFourK: isFourK,
            isMultiplayer: isMultiplayer,
            //players: players,
            genre: genre,
            isFeatured: isFeatured,
            price: price,
            platforms: platforms,
            developer: developer,
            language: language,
          );
        });
  }
}

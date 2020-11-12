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
                mainAxisSpacing: 4.0
              ),
              itemBuilder: (context, index) => Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(state.games[index].image)
                  )
                ),
              )
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
  Widget buildSuggestions(BuildContext context) => Container();
}

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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxScrolled) {
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
                    onPressed: () {},
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
    );
  }
}

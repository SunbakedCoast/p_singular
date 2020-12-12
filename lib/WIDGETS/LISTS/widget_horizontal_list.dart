import 'package:animations/animations.dart';
import 'package:p_singular/BLOCS/BLOCS_HOME/home.dart';
import 'package:p_singular/SRC/MODELS/models.dart';
import 'package:p_singular/UI/VALUES/values.dart';
import 'package:p_singular/pages.dart';
import 'package:flutter/material.dart';

class HorizontalList extends StatelessWidget {
  final String section;
  final DataLoaded state;
  List<Games> games;

  HorizontalList(
      {@required this.section, @required this.state, @required this.games});

  Widget build(BuildContext context) {
    var _screenSize = MediaQuery.of(context).size;
    games = state.games.where((g) => g.isFeatured == true).toList();
    print('Featured list length: ${games.toString()}');
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: const EdgeInsets.all(10),
            child: Text(section, style: Theme.of(context).textTheme.headline2)),
        Container(
            child: AspectRatio(
                aspectRatio: _screenSize.height / _screenSize.width / 0.90,
                child: ListView.builder(
                    itemCount: games.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) => _item(
                        context: context,
                        screenSize: _screenSize,
                        image: games[index].image,
                        gif: games[index].gif,
                        name: games[index].name,
                        description: games[index].description,
                        isMultiplayer: games[index].isMultiplayer,
                        genre: games[index].genre,
                        isFeatured: games[index].isFeatured,
                        price: games[index].price,
                        platforms: games[index].platforms,
                        developer: games[index].developer,
                        language: games[index].language))))
      ],
    );
  }

  Widget _item(
      {BuildContext context,
      Size screenSize,
      String image,
      String gif,
      String name,
      String description,
      String isMultiplayer,
      String genre,
      bool isFeatured,
      int price,
      List<dynamic> platforms,
      String developer,
      String language}) {
    return Container(
      width: screenSize.width * 0.9,
      height: 100,
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(5),
      child: Container(
        margin: const EdgeInsets.only(bottom: 5),
        child: OpenContainer(
            closedBuilder: (_, openContainer) {
              return Container(
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
                                    Text(name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4),
                                    Text(platforms.join(" "),
                                        style: Theme.of(context)
                                            .textTheme
                                            .overline),
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
                                style: Theme.of(context).textTheme.headline4)
                          ],
                        ),
                      ),
                    ],
                  ));
            },
            closedElevation: 5,
            closedShape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            openBuilder: (_, closeContainer) {
              return Details(
                image: image,
                gif: gif,
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
      ),
    );
  }
}

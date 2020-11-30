import 'package:animations/animations.dart';
import 'package:p_singular/BLOCS/BLOCS_HOME/home.dart';
import 'package:p_singular/SRC/MODELS/models.dart';
import 'package:p_singular/UI/VALUES/values.dart';
import 'package:p_singular/pages.dart';
import 'package:flutter/material.dart';

class GridViewVertical extends StatelessWidget {
  final String section;
  final DataLoaded state;
  List<Games> games;

  GridViewVertical(
      {@required this.section, @required this.state, @required this.games});

  Widget build(BuildContext context) {
    games = state.games;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: const EdgeInsets.all(10),
            child: Text(section, style: Theme.of(context).textTheme.headline2)),
        Container(
          child: GridView.builder(
              itemCount: games.length,
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0),
              itemBuilder: (BuildContext context, int index) => _item(
                  context: context,
                  image: games[index].image,
                  name: games[index].name,
                  description: games[index].description,
                  isMultiplayer: games[index].isMultiplayer,
                  genre: games[index].genre,
                  isFeatured: games[index].isFeatured,
                  price: games[index].price,
                  platforms: games[index].platforms,
                  developer: games[index].developer,
                  language: games[index].language)),
        )
      ],
    );
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
    return Container(
      padding: const EdgeInsets.all(3),
      child: OpenContainer(
          closedBuilder: (_, openContainer) {
            return Container(
              height: 140,
              width: 140,
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
                                  child: Text(name,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5),
                                ),
                                Text(platforms.join(" "),
                                    style:
                                        Theme.of(context).textTheme.overline),
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
          }),
    );
  }
}

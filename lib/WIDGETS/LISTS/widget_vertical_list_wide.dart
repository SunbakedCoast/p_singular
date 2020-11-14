import 'package:animations/animations.dart';
import 'package:p_singular/BLOCS/BLOCS_HOME/home.dart';
import 'package:p_singular/pages.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VerticalListWide extends StatelessWidget {
  final String section;
  final DataLoaded state;
  var games;

  VerticalListWide(
      {@required this.section, @required this.state, @required this.games});

  Widget build(BuildContext context) {
    var _screenSize = MediaQuery.of(context).size;
    games = state.games;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: const EdgeInsets.all(10),
            child: Text(section,
                style: GoogleFonts.lora(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold))),
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
                  //isFourK: games[index].isFourK,
                  isMultiplayer: games[index].isMultiplayer,
                  //players: games[index].players,
                  genre: games[index].genre,
                  isFeatured: games[index].isFeatured,
                  screenSize: _screenSize,
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
      //bool isFourK,
      String isMultiplayer,
      //int players,
      String genre,
      bool isFeatured,
      Size screenSize,
      int price,
      List<dynamic> platforms,
      String developer,
      String language}) {
    return Container(
      padding: const EdgeInsets.all(3),
      //margin: const EdgeInsets.only(bottom: 5),
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
                                  platforms.toString(),
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
          }),
    );

    /* return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(5),
      color: Colors.red,
      height: 175,
      width: screenSize.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 5),
            child: OpenContainer(
                closedBuilder: (_, openContainer) {
                  return Container(
                    //padding: const EdgeInsets.all(5),
                    height: 140,
                    width: screenSize.width,
                    //color: Colors.red,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 140,
                          width: screenSize.width,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(image)),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(15),
                                  topLeft: Radius.circular(5),
                                  bottomRight: Radius.circular(5),
                                  bottomLeft: Radius.circular(15))),
                        ),
                      ],
                    ),
                  );
                },
                closedElevation: 5,
                //transitionDuration: Duration(milliseconds: 200),
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
                    isFourK: isFourK,
                    isMultiplayer: isMultiplayer,
                    players: players,
                    genre: genre,
                    isFeatured: isFeatured,
                  );
                }),
          ),
        ],
      ),
    ); */
  }
}

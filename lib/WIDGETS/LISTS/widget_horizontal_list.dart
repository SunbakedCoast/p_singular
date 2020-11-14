import 'package:animations/animations.dart';
import 'package:p_singular/BLOCS/BLOCS_HOME/home.dart';
import 'package:p_singular/SRC/MODELS/models.dart';
import 'package:p_singular/pages.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HorizontalList extends StatelessWidget {
  final String section;
  final DataLoaded state;
  List<Games> games;

  HorizontalList(
      {@required this.section, @required this.state, @required this.games});

  Widget build(BuildContext context) {
    var _screenSize = MediaQuery.of(context).size;
    //games = state.games;
    games = state.games.where((g) => g.isFeatured == true).toList();
    print('Featured list length: ${games.toString()}');
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
                        name: games[index].name,
                        description: games[index].description,
                        //isFourK: games[index].isFourK,
                        isMultiplayer: games[index].isMultiplayer,
                        //players: games[index].players,
                        genre: games[index].genre,
                        isFeatured: games[index].isFeatured,
                        price: games[index].price,
                        platforms: games[index].platforms,
                        developer: games[index].developer,
                        language: games[index].language
                      ))))
      ],
    );
  }

  Widget _item(
      {BuildContext context,
      Size screenSize,
      String image,
      String name,
      String description,
     // bool isFourK,
      String isMultiplayer,
      //int players,
      String genre,
      bool isFeatured,
      int price,
      List<dynamic> platforms,
      String developer,
      String language}) {
    return Container(
      //color: Colors.yellow,
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
                                    Text(
                                      name,
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      platforms.join(" "),
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
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
                  ));
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
      ),
    );
  }
}

/* 
Container(
            width: 120,
            //color: Colors.blue,
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(5),
            //color: Colors.blue,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  child: OpenContainer(
                      closedBuilder: (_, openContainer) {
                        return Container(
                          //color: Colors.grey,
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(imgurl))),
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
                        return Details();
                      }),
                ),
                Flexible(
                  child: Text(
                    itemName,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                )
              ],
            ),
          ) */

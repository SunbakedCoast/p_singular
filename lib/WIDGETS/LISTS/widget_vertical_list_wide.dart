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
          child: ListView.builder(
              itemCount: games.length,
              shrinkWrap: true,
              physics: ScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int index) => _item(
                  context: context,
                  image: games[index].image,
                  name: games[index].name,
                  description: games[index].description,
                  isFourK: games[index].isFourK,
                  isMultiplayer: games[index].isMultiplayer,
                  players: games[index].players,
                  genre: games[index].genre,
                  isFeatured: games[index].isFeatured,
                  screenSize: _screenSize)),
        )
      ],
    );
  }

  Widget _item(
      {BuildContext context, 
      String image,
      String name,
      String description,
      bool isFourK,
      bool isMultiplayer,
      int players,
      String genre,
      bool isFeatured,  
      Size screenSize}) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(5),
      //color: Colors.red,
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
                  return Details(image: image,
                  name: name,
                  description: description,
                  isFourK: isFourK,
                  isMultiplayer: isMultiplayer,
                  players: players,
                  genre: genre,
                  isFeatured: isFeatured,);
                }),
          ),
          Flexible(
            child: Text(
              name,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: Theme.of(context).textTheme.subtitle2,
            ),
          )
        ],
      ),
    );
  }
}

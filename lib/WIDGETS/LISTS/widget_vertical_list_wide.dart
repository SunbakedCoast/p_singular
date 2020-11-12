import 'package:animations/animations.dart';
import 'package:p_singular/BLOCS/BLOCS_HOME/home.dart';
import 'package:p_singular/pages.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VerticalListWide extends StatelessWidget {
  final String section;
  final DataLoaded state;
  var games;

  VerticalListWide({@required this.section,
  @required this.state,
  @required this.games});

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
              itemBuilder: (BuildContext context, int index) =>
                  _item(context, games[index].name,games[index].image ,_screenSize)),
        )
      ],
    );
  }

  Widget _item(BuildContext context, String itemName, String imgurl,Size screenSize) {
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
                                image: NetworkImage(imgurl)
                              ),
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
                  return Details();
                }),
          ),
          Flexible(
            child: Text(
              itemName,
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

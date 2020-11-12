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
      {@required this.section,
      @required this.state,
      @required this.games});

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
                aspectRatio: _screenSize.height / _screenSize.width / 0.75,
                child: ListView.builder(
                    itemCount: games.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) => _item(
                          context: context,
                          itemName: games[index].name,
                          imgurl: games[index].image))))
      ],
    );
  }

  Widget _item({BuildContext context, String itemName, String imgurl}) {
    return Container(
      width: 120,
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 5),
            child: OpenContainer(
                closedBuilder: (_, openContainer) {
                  return Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover, image: NetworkImage(imgurl))),
                  );
                },
                closedElevation: 5,
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

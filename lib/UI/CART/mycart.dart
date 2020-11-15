import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyCart extends StatelessWidget {
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).accentColor,
        persistentFooterButtons: [
          SizedBox(
            width: screenSize.width,
            child: RaisedButton(
              splashColor: Theme.of(context).accentColor,
              onPressed: () {},
              color: Theme.of(context).backgroundColor,
              child: Text('Check out',
                  style: GoogleFonts.poppins(
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.bold)),
            ),
          ),
        ],
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  child: Text('Cart',
                      style: GoogleFonts.poppins(
                          fontSize: 18, fontWeight: FontWeight.bold))),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: 3,
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) => Container(
                        padding: const EdgeInsets.all(5),
                        margin: const EdgeInsets.only(bottom: 5),
                        width: screenSize.width,
                        height: 100,
                        //color: Colors.red,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 70,
                              width: 80,
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                          //  AspectRatio(
                           //   aspectRatio: 2.5 / 1,
                            //  child: 
                              Container(
                                padding: const EdgeInsets.all(5),
                                margin: const EdgeInsets.only(left: 5, right: 5),
                                decoration: BoxDecoration(
                                    //color: Colors.yellow,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Forza Horizon 4',
                                    style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold
                                    )),
                                    Text('\$0.00',
                                    style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold
                                    )),
                                    Text('XBOX',
                                    style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300
                                    ))
                                  ],
                                ),
                              ),
                          //  )
                          ],
                        ),
                      )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: 
                      Text('TOTAL', 
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                      )),
                    ),
                    Text('\$0.00',
                    style: GoogleFonts.poppins(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                      ))
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}

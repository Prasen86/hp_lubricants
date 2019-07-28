import 'package:flutter/material.dart';
import 'package:hp_lubricants/constants.dart';

class LubeFinderScreen extends StatefulWidget {
  static String id = 'lubeFinder_screen';
  @override
  _LubeFinderScreenState createState() => _LubeFinderScreenState();
}

class _LubeFinderScreenState extends State<LubeFinderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'HP Lubricants',
          style: TextStyle(
              fontFamily: 'LibreBaskerville', fontWeight: FontWeight.bold),
        ),
        leading: Image.asset(
          'assets/images/icon_hplubricrant.png',
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: <Color>[
          kbackgroundStartColor,
          kbackgroundEndColor,
        ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(
                      child: new GridButton(
                        color: kactiveColor,
                      ),
                    ),
                    Expanded(
                      child: new GridButton(
                        color: kinactiveColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(
                      child: new GridButton(
                        color: kinactiveColor,
                      ),
                    ),
                    Expanded(
                      child: new GridButton(
                        color: kinactiveColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                child: ListView(
                  // This next line does the trick.
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(30.0),
                      width: 200.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                            color: Colors.blue,
                            width: 2.0,
                            style: BorderStyle.solid),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(30.0),
                      width: 200.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                            color: Colors.blue,
                            width: 2.0,
                            style: BorderStyle.solid),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(30.0),
                      width: 200.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                            color: Colors.blue,
                            width: 2.0,
                            style: BorderStyle.solid),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GridButton extends StatelessWidget {
  final Color color;

  GridButton({this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
              color: Colors.black12, width: 2.0, style: BorderStyle.solid),
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Text("TYPE OF CAR"),
            ),
            Expanded(
              flex: 2,
              child: Icon(Icons.motorcycle),
            ),
            Expanded(
              flex: 1,
              child: Text("TWO WHEELER"),
            ),
          ],
        ),
      ),
    );
  }
}

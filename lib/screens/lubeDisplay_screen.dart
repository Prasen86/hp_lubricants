import 'package:flutter/material.dart';
import 'package:hp_lubricants/constants.dart';
import 'package:hp_lubricants/Utilities/ExpandableList.dart';
import 'package:hp_lubricants/Utilities/LubeClass.dart';
import 'package:hp_lubricants/Utilities/BaseAppBar.dart';

class LubeDisplayScreen extends StatefulWidget {
  static String id = 'lubeDisplay_screen';
  @override
  _LubeDisplayScreenState createState() => _LubeDisplayScreenState();
}

class _LubeDisplayScreenState extends State<LubeDisplayScreen> {
  List<Lube> filteredLubes = new List<Lube>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Lube> lubes = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: BaseAppBar(
        title: "HP Lubricants",
        leadingImage: 'assets/images/icon_hplubricrant.png',
        appBar: AppBar(),
        widgets: <Widget>[Icon(Icons.shopping_cart)],
      ),
      body: Container(
        decoration: containerDecoration,
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10.0),
              color: kactiveColor,
              child: TextField(
                decoration: InputDecoration(
                    hintText: "Search",
                    contentPadding: EdgeInsets.all(10.0),
                    hintStyle: subTitleTextStyle),
                onChanged: (string) {
                  setState(() {
                    filteredLubes = lubes
                        .where((lube) => (lube.name
                            .toLowerCase()
                            .contains(string.toLowerCase())))
                        .toList();
                    //filteredLubes = filteredLubesTemp;
                    print(filteredLubes.length);
                  });
                },
              ),
            ),
            Expanded(
              child: ExpandableList(
                package: filteredLubes.isEmpty ? lubes : filteredLubes,
                //filteredLubes.isEmpty ? lubes : filteredLubes,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
        child: ExpandableList(
          package: lubes,
        ),
      ),
    );
  }
}

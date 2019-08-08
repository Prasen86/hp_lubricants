import 'package:flutter/material.dart';
import 'package:hp_lubricants/constants.dart';
import 'package:hp_lubricants/Utilities/ExpandableList.dart';
import 'package:hp_lubricants/Utilities/LubeClass.dart';

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
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Recommended',
          style: appBarTextStyle,
        ),
        leading: Image.asset(
          'assets/images/icon_hplubricrant.png',
        ),
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

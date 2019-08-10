import 'package:flutter/material.dart';
import 'package:hp_lubricants/Utilities/BaseAppBar.dart';
import 'package:hp_lubricants/Utilities/LubeClass.dart';
import 'package:hp_lubricants/constants.dart';

class DescriptionScreen extends StatefulWidget {
  static String id = 'lubeDescription_screen';
  @override
  _DescriptionScreenState createState() => _DescriptionScreenState();
}

class _DescriptionScreenState extends State<DescriptionScreen> {
  @override
  Widget build(BuildContext context) {
    final Lube lube = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: BaseAppBar(
        title: lube.name,
        leadingImage: 'assets/images/icon_hplubricrant.png',
        appBar: AppBar(),
        widgets: <Widget>[Icon(Icons.shopping_cart)],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Hero(
                tag: lube.name,
                child: Container(
                  child: new Image(
                    //image: new AssetImage("assets/images/racer4.jpg"),
                    image: NetworkImage(lube.imageUrl),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                child: Text(
                  lube.description,
                  style: packRateTextStyle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

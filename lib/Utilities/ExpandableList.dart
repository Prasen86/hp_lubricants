import 'package:flutter/material.dart';
import 'package:hp_lubricants/constants.dart';
import 'LubeClass.dart';

class ExpandableList extends StatelessWidget {
  final List<Lube> package;

  ExpandableList({this.package});

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemBuilder: (context, index) => ExpansionTile(
              backgroundColor: kListColor,
              leading: new Image(
                //image: new AssetImage("assets/images/racer4.jpg"),
                //TODO
                image: NetworkImage(
                    "https://firebasestorage.googleapis.com/v0/b/hp-lubricants-rhythm.appspot.com/o/Racer%2015W-50%202.5%20Ltr.jpg?alt=media&token=9d39c4fa-b91b-4846-948c-68d3d2b8dbd7"),
                fit: BoxFit.cover,
              ),
              title: ListTile(
                title: new Text(
                  package[index].name.toUpperCase(),
                  style: titleTextStyple,
                ),
                subtitle: Text(
                  package[index].type,
                  style: subTitleTextStyle,
                ),
              ),
              children: [
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: package[index].packages.length,
                    itemBuilder: (_, i) {
                      return Container(
                        margin: EdgeInsets.all(5.0),
                        height: 50.0,
                        child: (Text(
                          (package[index].packages[i].packageName),
                          style: null,
                        )),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.white,
                        ),
                      );
                    })
              ]),
      itemCount: package.length,
    );
  }
}

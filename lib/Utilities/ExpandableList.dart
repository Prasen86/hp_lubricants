import 'package:flutter/material.dart';
import 'LubeClass.dart';

class ExpandableList extends StatelessWidget {
  final List<Lube> package;

  ExpandableList({this.package});

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemBuilder: (context, index) => ExpansionTile(
               title: Container(
                child: new Text(package[index].name),
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

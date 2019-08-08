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
                  style: titleTextStyle,
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
                        height: 40.0,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    "Pack Size :",
                                    style: subTitleTextStyle,
                                  ),
                                  Text(
                                    (package[index].packages[i].packageName),
                                    style: packDescTextStyle,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    ("Rs. "),
                                    style: packDescTextStyle,
                                  ),
                                  Text(
                                    (package[index].packages[i].mrp.toString()),
                                    style: packMrpTextStyle,
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Text(
                                    (package[index]
                                        .packages[i]
                                        .invoicePrice
                                        .toString()),
                                    style: packRateTextStyle,
                                  ),
                                  Icon(
                                    Icons.add_shopping_cart,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
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

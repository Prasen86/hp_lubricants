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
                image: NetworkImage(package[index].imageUrl),
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
                        height: 50.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              flex: 2,
                              child: Container(
                                margin: EdgeInsets.only(left: 5.0),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      "Pack:",
                                      style: subTitleTextStyle,
                                    ),
                                    Text(
                                      (package[index].packages[i].packageName),
                                      style: packDescTextStyle,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Container(
                                margin: EdgeInsets.only(right: 5.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      ("Rs. "),
                                      style: packDescTextStyle,
                                    ),
                                    Text(
                                      (package[index]
                                          .packages[i]
                                          .mrp
                                          .toString()),
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
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Container(
                                      child: Icon(
                                        Icons.add,
                                        size: kIconSize,
                                        color: Colors.white,
                                      ),
                                      decoration: BoxDecoration(
                                          color: kButtonColor,
                                          shape: BoxShape.rectangle,
                                          border: Border.all(
                                              style: BorderStyle.solid)),
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(vertical: 8.0),
                                      child: TextFormField(
                                        initialValue: "1",
                                        textAlign: TextAlign.center,
                                        keyboardType: TextInputType.number,
                                        style: textFieldTextStyle,
                                      ),
                                      constraints: kSizeConstraints,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          border: Border.all(
                                              style: BorderStyle.solid)),
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Container(
                                      child: Icon(
                                        Icons.remove,
                                        size: kIconSize,
                                        color: Colors.white,
                                      ),
                                      decoration: BoxDecoration(
                                          color: kButtonColor,
                                          shape: BoxShape.rectangle,
                                          border: Border.all(
                                              style: BorderStyle.solid)),
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    CircleAvatar(
                                      child: Icon(
                                        Icons.add_shopping_cart,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        //TODO
                        //remove hardcoding of Sized Box and Flex
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

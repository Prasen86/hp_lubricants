import 'package:flutter/material.dart';
import 'package:hp_lubricants/Utilities/BaseAppBar.dart';
import 'package:hp_lubricants/constants.dart';

class PickCar extends StatelessWidget {
  static String id = 'pickCar_screen';

  //PickCar({this.dataList});

  @override
  Widget build(BuildContext context) {
    //receiving passed arguments from Navigator
    final List<String> dataList = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: BaseAppBar(
        title: "Choose your Vehicle",
        leadingImage: 'assets/images/icon_hplubricrant.png',
        appBar: AppBar(),
        //widgets: <Widget>[Icon(Icons.shopping_cart)],
      ),
      body: Container(
        decoration: containerDecoration,
        child: ListView.builder(
          //Retrieve data for StateFul Widget
          itemCount: dataList.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                '${dataList[index].toUpperCase()}',
                style: titleTextStyle,
              ),
              onTap: () {
                // Vehicles vehicles = new Vehicles(wheels: dataList[index]);
                Navigator.pop(context, dataList[index]);
              },
            );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hp_lubricants/VehicleClass.dart';

class PickCar extends StatelessWidget {
  static String id = 'pickCar_screen';

  //PickCar({this.dataList});

  @override
  Widget build(BuildContext context) {
    //receiving passed arguments from Navigator
    final List<String> dataList = ModalRoute.of(context).settings.arguments;

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
      body: ListView.builder(
        //Retrieve data for StateFul Widget
        itemCount: dataList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('${dataList[index]}'),
            onTap: () {
              // Vehicles vehicles = new Vehicles(wheels: dataList[index]);
              Navigator.pop(context, dataList[index]);
            },
          );
        },
      ),
    );
  }
}

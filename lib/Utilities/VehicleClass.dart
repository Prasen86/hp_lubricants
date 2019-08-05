import 'package:cloud_firestore/cloud_firestore.dart';

class Vehicles {
  String wheels;
  String fuel;
  String make;
  String model;

  Vehicles({this.wheels, this.fuel, this.make, this.model});

  static Future<List<String>> getMakeList(Vehicles vehicle) async {
    List<String> list = new List();
    try {
      final messages = await Firestore.instance
          .collection("vehicles")
          .where("type", isEqualTo: vehicle.wheels)
          .getDocuments();
      for (var message in messages.documents) {
        var result = message.data["company"];
        print(result);
        list.add(result);
      }
    } catch (exception) {
      print("Exception : $exception");
      return null;
    }
    return list;
  }

  static Future<List<String>> getModelList(Vehicles vehicle) async {
    List<String> list = new List();
    try {
      final messages = await Firestore.instance
          .collection("vehicles")
          .where("type", isEqualTo: vehicle.wheels)
          .where("company", isEqualTo: vehicle.make)
          .getDocuments();
      for (var message in messages.documents) {
        var result = message.data["model"];
        print(result);
        list.add(result);
      }
    } catch (exception) {
      print("Exception : $exception");
      return null;
    }
    return list;
  }
}

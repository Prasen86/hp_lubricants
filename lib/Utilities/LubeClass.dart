import 'package:hp_lubricants/Utilities/VehicleClass.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Lube {
  String name;
  List<Package> packages;

  Lube({this.name, this.packages});

  static Future<List<Lube>> getPackagesList(Vehicles vehicle) async {
    List<Lube> listLubes = new List<Lube>();

    try {
      List<String> lubeNamesList = new List<String>();
      final messages = await Firestore.instance
          .collection("vehicles")
          .where("type", isEqualTo: vehicle.wheels)
          .where("company", isEqualTo: vehicle.make)
          .where("model", isEqualTo: vehicle.model)
          .getDocuments();
      var result = messages.documents[0].data["lube"];
      lubeNamesList = List.from(result);

      for (int i = 0; i < lubeNamesList.length; i++) {
        String lubeName = lubeNamesList[i];
        List<Package> listPackages = new List<Package>();
        var messages = await Firestore.instance
            .collection("lubes")
            .document(lubeName)
            .collection("package")
            .getDocuments();
        for (var message in messages.documents) {
          Package tempPackage = new Package(
            mrp: message.data["mrp"],
            packageName: message.documentID,
            invoicePrice: message.data["invoice price"],
          );
          listPackages.add(tempPackage);
        }
        Lube tempLube = new Lube(
          name: lubeName,
          packages: listPackages,
        );
        listLubes.add(tempLube);
      }
      print(listLubes[0].name);
    } catch (exception) {
      print("Exception : $exception");
      return null;
    }
    return listLubes;
  }
}

class Package {
  String packageName;
  int invoicePrice;
  int mrp;

  Package({this.packageName, this.mrp, this.invoicePrice});
}

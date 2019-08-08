import 'package:hp_lubricants/Utilities/VehicleClass.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Lube {
  String name;
  String type;
  List<Package> packages;

  Lube({this.name, this.type, this.packages});

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
        final lubeType = await Firestore.instance
            .collection("lubes")
            .document(lubeName)
            .get();
        String type = lubeType.data["type"];
        List<Package> listPackages = new List<Package>();
        var messages = await Firestore.instance
            .collection("lubes")
            .document(lubeName)
            .collection("package")
            .getDocuments();
        for (var message in messages.documents) {
          Package tempPackage = new Package(
            mrp: message.data["mrp"],
            packageName: message.data["packagename"],
            invoicePrice: message.data["invoice price"],
          );
          listPackages.add(tempPackage);
        }
        Lube tempLube = new Lube(
          name: lubeName,
          type: type,
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

  static Future<List<Lube>> getAllLubesList() async {
    List<Lube> listLubes = new List<Lube>();

    try {
      List<String> lubeNamesList = new List<String>();
      final messages =
          await Firestore.instance.collection("lubes").getDocuments();

      for (var message in messages.documents) {
        String lubeName = message.data["name"];
        String type = message.data["type"];
        List<Package> listPackages = new List<Package>();
        var messagePacks = await Firestore.instance
            .collection("lubes")
            .document(lubeName)
            .collection("package")
            .getDocuments();
        for (var messagePack in messagePacks.documents) {
          Package tempPackage = new Package(
            mrp: messagePack.data["mrp"],
            packageName: messagePack.data["packagename"],
            invoicePrice: messagePack.data["invoice price"],
          );
          listPackages.add(tempPackage);
        }
        Lube tempLube = new Lube(
          name: lubeName,
          type: type,
          packages: listPackages,
        );
        listLubes.add(tempLube);
      }
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

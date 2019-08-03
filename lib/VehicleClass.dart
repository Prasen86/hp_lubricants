class Vehicles {
  String wheels;
  String fuel;
  String make;
  String model;

  Vehicles({this.wheels, this.fuel, this.make, this.model});

  Future<dynamic> setWheels(String wheels) async {
    this.wheels = wheels;
    return null;
  }
}

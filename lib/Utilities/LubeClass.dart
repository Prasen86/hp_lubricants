class Lube {
  String name;
  List<Package> packages;

  Lube({this.name, this.packages});
}

class Package {
  String packageName;
  int invoicePrice;
  int mrp;

  Package({this.packageName, this.mrp, this.invoicePrice});
}

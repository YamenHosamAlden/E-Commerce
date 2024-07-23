class FilterModel {
  List<Brands>? brands;
  List<Sizes>? sizes;


  FilterModel({this.brands, this.sizes,});

  FilterModel.fromJson(Map<String, dynamic> json) {
    if (json['brands'] != null) {
      brands = <Brands>[];
      json['brands'].forEach((v) {
        brands!.add(Brands.fromJson(v));
      });
    }
    if (json['sizes'] != null) {
      sizes = <Sizes>[];
      json['sizes'].forEach((v) {
        sizes!.add(Sizes.fromJson(v));
      });
    }

  }
}

class Brands {
  int? id;
  String? name;
  bool? select;

  Brands({this.id, this.name, this.select});

  Brands.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    select = false;
  }
}

class Sizes {
  int? id;
  String? value;
  bool? select;

  Sizes({this.id, this.value, this.select});

  Sizes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    value = json['value'];
    select = false;
  }

   


}

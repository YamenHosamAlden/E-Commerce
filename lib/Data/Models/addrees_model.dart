class AddreesModel {
  int? id;
  String? addressName;
  String? city;
  String? district;
  String? details;
  double? latitude;
  double? longitude;
  String? phoneNumber;
  bool? selected;

  AddreesModel(
      {this.addressName,
      this.city,
      this.district,
      this.details,
      this.latitude,
      this.longitude,
      this.phoneNumber,
      this.selected});

  AddreesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    addressName = json['address_name'];
    city = json['city'];
    district = json['district'];
    details = json['details'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    phoneNumber = json['phone_number'];
    selected = false;
  }
}

import 'dart:io';

class ProfileModel {
  Customer? customer;

  ProfileModel({this.customer});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    customer =
        json['customer'] != null ? Customer.fromJson(json['customer']) : null;
  }
}

class Customer {
  int? id;
  User? user;
  String? phoneNumber;
  String? imageUrl;
  File? fileImage;

  Customer({this.id, this.user, this.phoneNumber, this.imageUrl,this.fileImage});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    phoneNumber = json['phone_number'];
    imageUrl = json['image_url'];
  }
}

class User {
  String? email;
  String? firstName;
  String? lastName;
  String? username;

  User({this.email, this.firstName, this.lastName, this.username});

  User.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    username = json['username'];
  }
}

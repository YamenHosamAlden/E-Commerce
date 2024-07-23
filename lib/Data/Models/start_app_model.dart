import 'package:ecommerce/Data/Models/categories_model.dart';
import 'package:ecommerce/Data/Models/product_model.dart';
import 'package:ecommerce/Data/Models/promotion_model.dart';

class StartAppModel {
  List<Product>? newProducts;
   List<Product>? bestRating;
  List<Promotion>? promotion;
  List<Categories>? categories;

  StartAppModel(
      {this.categories, this.promotion,  this.newProducts});

  StartAppModel.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(Categories.fromJson(v));
      });
    }
    if (json['promotion'] != null) {
      promotion = <Promotion>[];
      json['promotion'].forEach((v) {
        promotion!.add(Promotion.fromJson(v));
      });
    }
    if (json['best_rating'] != null) {
      bestRating = <Product>[];
      json['best_rating'].forEach((v) {
        bestRating!.add(Product.fromJson(v));
      });
    }
    if (json['new products'] != null) {
      newProducts = <Product>[];
      json['new products'].forEach((v) {
        newProducts!.add(Product.fromJson(v));
      });
    }
  }
}





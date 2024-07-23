class CartModel {
  List<Products>? products;
  int? totalPrice;

  CartModel({this.products, this.totalPrice});

  CartModel.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
    totalPrice = json['total_price'];
  }
}

class Products {
  Product? product;
  int? quantity;

  Products({this.product, this.quantity});

  Products.fromJson(Map<String, dynamic> json) {
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
    quantity = json['quantity'];
  }
}

class Product {
  ProductDetail? productDetail;
  int? id;
  String? color;
  String? size;
  int? price;
  int? salePrice;
  int? stock;

  int? stockLength = 5;
  List<int> productStock = [];

  Product(
      {this.productDetail,
      this.id,
      this.color,
      this.size,
      this.price,
      this.salePrice,
      this.stock});

  Product.fromJson(Map<String, dynamic> json) {
    productDetail = json['product'] != null
        ? ProductDetail.fromJson(json['product'])
        : null;
    id = json['id'];
    color = json['color'];
    size = json['size'];
    price = json['price'];
    salePrice = json['sale_price'];

    stock = int.parse(json['stock']);

    if (5 <= stock!) {
      stockLength = 5;
    } else {
      stockLength = stock!;
    }
    for (int i = 1; i <= stockLength!; i++) {
      productStock.add(i);
    }
  }
}

class ProductDetail {
  String? name;
  String? slug;
  String? averageRating;
  int? supplierId;
  int? reviewsCount;
  String? mainImage;

  ProductDetail(
      {this.name,
      this.slug,
      this.averageRating,
      this.reviewsCount,
      this.supplierId,
      this.mainImage});

  ProductDetail.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    slug = json['slug'];
    averageRating = json['average_rating'];
    reviewsCount = json['reviews_count'];
    supplierId = json['supplier'];
    mainImage = json['main_image'];
  }
}

class CouponModel {
  Coupon? coupon;

  CouponModel({this.coupon});

  CouponModel.fromJson(Map<String, dynamic> json) {
    coupon = json['coupon'] != null ? Coupon.fromJson(json['coupon']) : null;
  }
}

class Coupon {
  int? id;
  String? name;
  String? couponCode;
  int? discountValue;
  int? userMaxUse;
  int? productsToEarn;
  int? supplierId;

  Coupon(
      {this.id,
      this.name,
      this.couponCode,
      this.discountValue,
      this.userMaxUse,
      this.supplierId,
      this.productsToEarn});

  Coupon.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    couponCode = json['coupon_code'];
    discountValue = json['discount_value'];
    userMaxUse = json['user_max_use'];
    supplierId = json['supplier'];
    productsToEarn = json['products_to_earn'];
  }
}

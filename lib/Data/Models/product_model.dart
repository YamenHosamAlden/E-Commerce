class FavorateProductListModel {
  List<ProductModel>? productModel;

  FavorateProductListModel({this.productModel});

  FavorateProductListModel.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      productModel = <ProductModel>[];
      json['products'].forEach((v) {
        productModel!.add(ProductModel.fromJson(v));
      });
    }
  }
}

class ProductList {
  List<Product>? products;

  ProductList({this.products});

  ProductList.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <Product>[];
      json['products'].forEach((v) {
        products!.add(Product.fromJson(v));
      });
    }
    if (json['best_rating'] != null) {
      products = <Product>[];
      json['best_rating'].forEach((v) {
        products!.add(Product.fromJson(v));
      });
    }

    if (json['new products'] != null) {
      products = <Product>[];
      json['new products'].forEach((v) {
        products!.add(Product.fromJson(v));
      });
    }
  }
}

class ProductModel {
  Product? product;
  int? price;
  int? id;
  int? salePrice;
  String? color;
  String? size;

  ProductModel({this.product});

  ProductModel.fromJson(Map<String, dynamic> json) {
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;

    if (json['price'] != null) {
      price = json['price'];
    }

    if (json['sale_price'] != null) {
      salePrice = json['sale_price'];
    }
    if (json['color'] != null) {
      color = json['color'];
    }
    if (json['size'] != null) {
      size = json['size'];
    }
    if (json['id'] != null) {
      id = json['id'];
    }
  }
}

class Product {
  int? id;
  String? name;
  String? slug;
  int? mainPrice;
  int? mainSalePrice;
  String? averageRating;
  int? reviewsCount;
  String? description;
  bool? inWishList;
  String? mainImage;
  List<ProductDetails>? productDetail;
  List<ReviewSet>? reviewSet;
  List<Images>? images;
  List<String> colors = [];
  List<String> sizes = [];
  List<String> uniqueSizes = [];
  List<String> uniqueColors = [];

  Product(
      {this.id,
      this.name,
      this.slug,
      this.description,
      this.mainPrice,
      this.mainSalePrice,
      this.averageRating,
      this.reviewsCount,
      this.mainImage,
      this.productDetail,
      this.reviewSet,
      this.inWishList,
      this.images});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    description = json['description'];
    mainPrice = json['main_price'];

    mainSalePrice = json['main_sale_price'];
    averageRating = json['average_rating'];
    reviewsCount = json['reviews_count'];
    mainImage = json['main_image'];
      if (json['review_set'] != null) {
      reviewSet = <ReviewSet>[];
      json['review_set'].forEach((v) {
        reviewSet!.add( ReviewSet.fromJson(v));
      });
    }
    inWishList = json['in_wishlist'];
    if (json['product_detail'] != null) {
      productDetail = <ProductDetails>[];
      json['product_detail'].forEach((v) {
        productDetail!.add(ProductDetails.fromJson(v));

        for (var element in productDetail!) {
          if (element.color != null) {
            colors.add(element.color!);
          }
          if (element.size != null) {
            sizes.add(element.size!);
          }
        }

        for (var item in sizes) {
          if (!uniqueSizes.contains(item)) {
            uniqueSizes.add(item);
          }
        }

        for (var item in colors) {
          if (!uniqueColors.contains(item)) {
            uniqueColors.add(item);
          }
        }
      });
    }

    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
  }
}

class ProductDetails {
  int? id;
  String? color;
  String? size;
  String? sku;
  int? price;
  int? salePrice;
  bool? isActive;
  bool? isMain;
  bool? inWishList;

  ProductDetails(
      {this.id,
      this.color,
      this.size,
      this.sku,
      this.price,
      this.salePrice,
      this.isActive,
      this.inWishList,
      this.isMain});

  ProductDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    color = json['color'];
    size = json['size'];
    sku = json['sku'];
    price = json['price'];
    salePrice = json['sale_price'];
    isActive = json['is_active'];
    isMain = json['is_main'];
    inWishList = json['in_wishlist'];
  }
}

class ReviewSet {
  int? id;
  int? rating;
  String? comment;
  String? customer;

  ReviewSet({this.id, this.rating, this.comment, this.customer});

  ReviewSet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rating = json['rating'];
    comment = json['comment'];
    customer = json['customer'];
  }
}

class Images {
  String? imageUrl;

  Images({this.imageUrl});

  Images.fromJson(Map<String, dynamic> json) {
    imageUrl = json['image_url'];
  }
}

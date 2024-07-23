class OrdersListModel {
  List<Orders>? orders;
  List<Orders>? ordersCancelled;
  List<Orders>? ordersPreprocessing;
  List<Orders>? ordersDeliverd;
  List<Orders>? ordersPickedUp;

  OrdersListModel({this.orders});

  OrdersListModel.fromJson(Map<String, dynamic> json) {
    ordersCancelled = <Orders>[];
    ordersPreprocessing = <Orders>[];
    ordersDeliverd = <Orders>[];
    ordersPickedUp = <Orders>[];
    if (json['orders'] != null) {
      orders = <Orders>[];
      json['orders'].forEach((v) {
        orders!.add(Orders.fromJson(v));
      });

      for (Orders element in orders!) {
        if (element.orderStatus == "Preprocessing") {
          ordersPreprocessing!.add(element);
        }
        if (element.orderStatus == "Cancelled") {
          ordersCancelled!.add(element);
        }

        if (element.orderStatus == "Deliverd") {
          ordersDeliverd!.add(element);
        }
        if (element.orderStatus == "Picked up") {
          ordersPickedUp!.add(element);
        }
      }
    }
  }
}

class Orders {
  int? id;
  String? dateCreated;
  String? timeCreated;
  String? dateDeliverd;
  String? orderStatus;
  int? totalPrice;
  List<String>? images;
  DateTime? dateTime;

  Orders(
      {this.id,
      this.dateCreated,
      this.dateDeliverd,
      this.orderStatus,
      this.totalPrice,
      this.images});

  Orders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateTime = DateTime.parse(json['date_created']);
    dateCreated = "${dateTime!.year}-${dateTime!.month}-${dateTime!.day}";
    if (dateTime!.hour > 12) {
      timeCreated = "${dateTime!.hour - 12}:${dateTime!.minute}:PM";
    } else {
      timeCreated = "${dateTime!.hour}:${dateTime!.minute}:AM";
    }

    dateDeliverd = json['date_deliverd'];
    orderStatus = json['order_status'];
    totalPrice = json['total_price'];

    images = json['images'].cast<String>();
  }
}

class OrderDetailsModel {
  int? id;
  String? dateCreated;
  String? timeCreated;
  String? dateDeliverd;
  String? orderStatus;
  List<Order>? order;
  String? pickUpMethod;
  DateTime? dateTime;
  OrderDetailsModel(
      {this.id,
      this.dateCreated,
      this.dateDeliverd,
      this.orderStatus,
      this.order,
      this.pickUpMethod});

  OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateTime = DateTime.parse(json['date_created']);
    dateCreated = "${dateTime!.year}-${dateTime!.month}-${dateTime!.day}";
    if (dateTime!.hour > 12) {
      timeCreated = "${dateTime!.hour - 12}:${dateTime!.minute}:PM";
    } else {
      timeCreated = "${dateTime!.hour}:${dateTime!.minute}:AM";
    }

    dateDeliverd = json['date_deliverd'];
    orderStatus = json['order_status'];
    if (json['order'] != null) {
      order = <Order>[];
      json['order'].forEach((v) {
        order!.add(Order.fromJson(v));
      });
    }
    pickUpMethod = json['pick_up_method'];
  }
}

class Order {
  Products? products;
  int? quantity;

  Order({this.products, this.quantity});

  Order.fromJson(Map<String, dynamic> json) {
    products =
        json['products'] != null ? Products.fromJson(json['products']) : null;
    quantity = json['quantity'];
  }
}

class Products {
  Product? product;
  int? id;
  String? color;
  String? size;
  int? price;
  int? salePrice;

  Products(
      {this.product,
      this.id,
      this.color,
      this.size,
      this.price,
      this.salePrice});

  Products.fromJson(Map<String, dynamic> json) {
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
    id = json['id'];
    color = json['color'];
    size = json['size'];
    price = json['price'];
    salePrice = json['sale_price'];
  }
}

class Product {
  String? name;
  String? slug;
  String? averageRating;
  int? reviewsCount;
  String? mainImage;
  int? supplier;

  Product(
      {this.name,
      this.slug,
      this.averageRating,
      this.reviewsCount,
      this.mainImage,
      this.supplier});

  Product.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    slug = json['slug'];
    averageRating = json['average_rating'];
    reviewsCount = json['reviews_count'];
    mainImage = json['main_image'];
    supplier = json['supplier'];
  }
}

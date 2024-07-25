class PromotionModel {
  List<Promotion>? promotion;

  PromotionModel({
    this.promotion,
  });

  PromotionModel.fromJson(Map<String, dynamic> json) {
    if (json['promotions'] != null) {
      promotion = <Promotion>[];
      json['promotions'].forEach((v) {
        promotion!.add(Promotion.fromJson(v));
      });
    }
  }
}

class Promotion {
  int? id;
  String? name;
  String? description;
  int? discountPercentege;
  String? timeStart;
  String? timeEnd;
  String? imageUrl;
  bool? isActive;
  bool? isScheduled;

  Promotion(
      {this.id,
      this.name,
      this.description,
      this.discountPercentege,
      this.imageUrl,
      this.timeStart,
      this.timeEnd,
      this.isActive,
      this.isScheduled});

  Promotion.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    discountPercentege = json['discount_percentege'];
    timeStart = json['time_start'];
    timeEnd = json['time_end'];
    isActive = json['is_active'];
    isScheduled = json['is_scheduled'];
    imageUrl = json['image_url'];
  }
}

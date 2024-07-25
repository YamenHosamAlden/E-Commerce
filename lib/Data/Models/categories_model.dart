class CategoryModel {
  List<Categories>? categories;

  CategoryModel({this.categories});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(Categories.fromJson(v));
      });
    }
  }
}

class Categories {
  int? id;
  String? name;
  String? slug;
  int? parent;
  bool? isLeaf;
  bool? isActive;
  String? imageUrl;

  Categories(
      {this.id,
      this.name,
      this.parent,
      this.slug,
      this.isLeaf,
      this.isActive,
      this.imageUrl});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    parent = json['parent'];
    isLeaf = json['is_leaf'];
    isActive = json['is_active'];
    imageUrl = json['image_url'];
  }
}

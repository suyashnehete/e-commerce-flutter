class ProductHighlightModel {
  String image;
  String title;
  String description;

  ProductHighlightModel({this.image, this.title, this.description});

  factory ProductHighlightModel.fromJson(dynamic json) {
    return ProductHighlightModel(
      image: json["image"],
      title: json["title"],
      description: json["description"],
    );
  }
}

class ProductReviewModel {
  double rating;
  String user;
  String description;
  int id;

  ProductReviewModel({this.rating, this.user, this.description, this.id});

  factory ProductReviewModel.fromJson(dynamic json) {
    return ProductReviewModel(
      user: json["user"],
      description: json["description"],
      rating: json["rating"],
      id: json["id"],
    );
  }
}

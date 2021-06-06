class ProductModel {
  int id;
  String name;
  int price;
  String description;
  int stock;
  double rating;
  String category;
  String image;
  String soldBy;
  String warrantySummary;
  String coveredInWarranty;
  String notCoveredInWarranty;

  ProductModel(
      {this.id,
      this.name,
      this.price,
      this.description,
      this.stock,
      this.rating,
      this.category,
      this.image,
      this.soldBy,
      this.warrantySummary,
      this.coveredInWarranty,
      this.notCoveredInWarranty});

  factory ProductModel.fromJson(dynamic json) {
    return ProductModel(
      id: json["id"],
      name: json["name"],
      price: json["price"],
      description: json["description"],
      stock: json["stock"],
      rating: json["rating"],
      soldBy: json["sold_by"],
      warrantySummary: json["warranty_summary"],
      category: json["category"],
      image: json["image"],
      coveredInWarranty: json["covered_in_warranty"],
      notCoveredInWarranty: json["not_covered_in_warranty"],
    );
  }
}

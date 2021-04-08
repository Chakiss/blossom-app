class PackageResponseModel {
  int code;
  int price;
  String priceText;
  int quota;
  String quotaText;
  String imageUrl;
  String description;

  PackageResponseModel(
      {this.code, this.price, this.priceText, this.quota, this.quotaText, this.imageUrl, this.description});

  factory PackageResponseModel.fromJson(Map<String, dynamic> json) {
    return PackageResponseModel(
        code: json["code"],
        price: json["price"],
        priceText: json["priceText"],
        quota: json["quota"],
        quotaText: json["quotaText"],
        imageUrl: json["imageUrl"],
        description: json["description"]
    );
  }
}
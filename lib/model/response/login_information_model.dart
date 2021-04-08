class LoginInformationModel {

  String titleText;
  String titleColor;
  String descriptionText;
  String descriptionColor;
  String imageURL;
  String imageLink;
  String bannerURL;
  String bannerLink;

  LoginInformationModel({
      this.titleText,
      this.titleColor,
      this.descriptionText,
      this.descriptionColor,
      this.imageURL,
      this.imageLink,
      this.bannerURL,
      this.bannerLink});

  factory LoginInformationModel.fromJson(Map<String, dynamic> json) {
    return LoginInformationModel(
        titleText: json['titleText'],
        titleColor: json['titleColor'],
        descriptionText: json['descriptionText'],
        descriptionColor: json['descriptionColor'],
        imageURL: json['imageURL'],
        imageLink: json['imageLink'],
        bannerURL: json['bannerURL'],
        bannerLink: json['bannerLink']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'titleText': titleText,
      'titleColor': titleColor,
      'descriptionText': descriptionText,
      'descriptionColor': descriptionColor,
      'imageURL': imageURL,
      'imageLink': imageLink,
      'bannerURL': bannerURL,
      'bannerLink': bannerLink,
    };
  }
}
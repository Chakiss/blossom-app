class GetBookingHistoryResponseModel {

  String image;  
  String title;
  String description;
  String showBtnFlag;
  String expiredFlag;
  String cubeId;

  GetBookingHistoryResponseModel({
      this.image, this.title, this.description, this.showBtnFlag, this.expiredFlag, this.cubeId});
  
  factory GetBookingHistoryResponseModel.fromJson(Map<String, dynamic> json) {
    return GetBookingHistoryResponseModel(
      image: json["image"],
      title: json["title"],
      description: json["description"],
      showBtnFlag: json["showBtnFlag"],
      expiredFlag: json["expiredFlag"],
      cubeId: json["cubeId"],
    );
  }
}
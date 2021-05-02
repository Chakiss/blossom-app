class SavePatientFormRequestModel {
  String appointmentID;
  String acnePeriod;
  String acneCared;
  String changeProduct;
  bool isStressed;
  bool sleepDeprivation;
  bool normalMenstruation;
  bool frequenceSweet;
  List<String> images;

  SavePatientFormRequestModel(
      {this.appointmentID,
      this.acnePeriod,
      this.acneCared,
      this.changeProduct,
      this.isStressed,
      this.sleepDeprivation,
      this.normalMenstruation,
      this.frequenceSweet,
      this.images});

  Map<String, dynamic> toJson() {
    return {
      "appointmentID": appointmentID,
      "acnePeriod": acnePeriod,
      "acneCared": acneCared,
      "changeProduct": changeProduct,
      "isStressed": isStressed,
      "sleepDeprivation": sleepDeprivation,
      "normalMenstruation": normalMenstruation,
      "frequenceSweet": frequenceSweet,
      "images": images,
    };
  }
}

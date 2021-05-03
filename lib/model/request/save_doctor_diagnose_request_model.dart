class SaveDoctorDiagnoseRequestModel {
  String appointmentID;
  String skinOverview;
  String skinType;
  String diagnose;
  String carePlan;
  String careRecommendation;
  String productsRecommendation;
  String nextAppointment;

  SaveDoctorDiagnoseRequestModel(
      {this.appointmentID,
      this.skinOverview,
      this.skinType,
      this.diagnose,
      this.carePlan,
      this.careRecommendation,
      this.productsRecommendation,
      this.nextAppointment});

  Map<String, dynamic> toJson() {
    return {
      "appointmentID": appointmentID,
      "skinOverview": skinOverview,
      "skinType": skinType,
      "diagnose": diagnose,
      "carePlan": carePlan,
      "careRecommendation": careRecommendation,
      "productsRecommendation": productsRecommendation,
      "nextAppointment": nextAppointment,
    };
  }
}

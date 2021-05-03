class SaveDoctorDiagnoseRequestModel {
  String appointmentID;
  String skinOverview;
  String skinType;
  String diagnoses;
  String carePlan;
  String careRecommendation;
  String productsRecommendation;
  String nextAppointment;

  SaveDoctorDiagnoseRequestModel(
      {this.appointmentID,
      this.skinOverview,
      this.skinType,
      this.diagnoses,
      this.carePlan,
      this.careRecommendation,
      this.productsRecommendation,
      this.nextAppointment});

  Map<String, dynamic> toJson() {
    return {
      "appointmentID": appointmentID,
      "skinOverview": skinOverview,
      "skinType": skinType,
      "diagnoses": diagnoses,
      "carePlan": carePlan,
      "careRecommendation": careRecommendation,
      "productsRecommendation": productsRecommendation,
      "nextAppointment": nextAppointment,
    };
  }
}

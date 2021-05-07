class SaveDoctorDiagnoseRequestModel {
  String appointmentID;
  String skinOverview;
  String skinType;
  String previousFeedback;
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
      this.previousFeedback,
      this.carePlan,
      this.careRecommendation,
      this.productsRecommendation,
      this.nextAppointment});

  Map<String, dynamic> toJson() {
    return {
      "appointmentID": appointmentID,
      "skinOverview": skinOverview,
      "skinType": skinType,
      "previousFeedback" : previousFeedback,
      "diagnoses": diagnoses,
      "carePlan": carePlan,
      "careRecommendation": careRecommendation,
      "productsRecommendation": productsRecommendation,
      "nextAppointment": nextAppointment,
    };
  }
}

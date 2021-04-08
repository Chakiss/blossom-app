class EndVideoConferenceRequestModel {

  String sourceCubeId;
  String destCubeId;
  String transactionRef;

  EndVideoConferenceRequestModel(this.sourceCubeId, this.destCubeId, this.transactionRef);

  Map<String, dynamic> toJson() {
    return {
      "sourceCubeId": sourceCubeId,
      "destCubeId": destCubeId,
      "transactionRef": transactionRef
    };
  }
}
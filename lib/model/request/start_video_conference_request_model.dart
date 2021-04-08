class StartVideoConferenceRequestModel {

  String sourceCubeId;
  String destCubeId;

  StartVideoConferenceRequestModel(this.sourceCubeId, this.destCubeId);

  Map<String, dynamic> toJson() {
    return {"sourceCubeId": sourceCubeId, "destCubeId": destCubeId};
  }
}

class GetSourceDestinationResponseModel {

  String sourceImgUrl;
  String sourceName;

  GetSourceDestinationResponseModel({this.sourceImgUrl, this.sourceName});

  factory GetSourceDestinationResponseModel.fromJson(Map<String, dynamic> json) {
    return GetSourceDestinationResponseModel(
      sourceImgUrl: json["sourceImgUrl"],
      sourceName: json["sourceName"]
    );
  }
}
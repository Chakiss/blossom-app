class DoctorInfo {
  final String firstName;
  final String lastName;
  final String profileTitle;
  final String profileDesc;
  final String profileImg;
  final String citizenCode;
  final String mobileNo;
  final String statusOnline;
  final String cubeId;
  final int doctorId;

  DoctorInfo({
    this.firstName,
    this.lastName,
    this.profileTitle,
    this.profileDesc,
    this.profileImg,
    this.citizenCode,
    this.mobileNo,
    this.statusOnline,
    this.cubeId,
    this.doctorId
  });

  factory DoctorInfo.formJsonBody(Map<String, dynamic> json) {
    return DoctorInfo.fromJson(json['data']);
  }

  factory DoctorInfo.fromJson(Map<String, dynamic> data) {
    return DoctorInfo(
      firstName: data['firstName'],
      lastName: data['lastName'],
      profileTitle: data['profileTitle'],
      profileDesc: data['profileDesc'],
      profileImg: data['profileImg'],
      citizenCode: data['citizenCode'],
      mobileNo: data['mobileNo'],
      statusOnline: data['statusOnline'],
      cubeId: data['cubeId'],
      doctorId: data['doctorId']
    );
  }
}

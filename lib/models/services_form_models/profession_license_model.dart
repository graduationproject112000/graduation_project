class ProfessionLicenseModel {
  bool? status;
  dynamic message;
  ProfessionLicenseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}

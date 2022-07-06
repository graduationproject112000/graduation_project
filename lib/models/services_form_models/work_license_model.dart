class WorkLicenseModel {
  bool? status;
  dynamic message;

  WorkLicenseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}

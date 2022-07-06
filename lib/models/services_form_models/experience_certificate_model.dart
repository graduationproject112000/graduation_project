class ExperienceCertificateModel {
  bool? status;
  dynamic message;

  ExperienceCertificateModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}

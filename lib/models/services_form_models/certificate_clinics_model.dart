class CertificateClinicsModel {
  bool? status;
  dynamic message;

  CertificateClinicsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}

class EvictionCertificateModel {
  bool? status;
  dynamic message;

  EvictionCertificateModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}

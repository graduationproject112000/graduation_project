class PrivateClinicModel {
  bool? status;
  dynamic message;

  PrivateClinicModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}

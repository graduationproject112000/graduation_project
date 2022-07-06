class ConsultantCardModel {
  bool? status;
  dynamic message;
  ConsultantCardModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}

class MemberRenewalModel {
  bool? status;
  dynamic message;
  MemberRenewalModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}

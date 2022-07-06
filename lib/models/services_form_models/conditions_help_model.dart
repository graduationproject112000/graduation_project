class ConditionsHelpModel {
  bool? status;
  dynamic message;
  ConditionsHelpModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}

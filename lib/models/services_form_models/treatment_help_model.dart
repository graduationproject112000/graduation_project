class TreatmentHelpModel {
  bool? status;
  dynamic message;
  TreatmentHelpModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}

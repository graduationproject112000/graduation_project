class LearningHelpModel {
  bool? status;
  dynamic message;
  LearningHelpModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}

class DiseasesHelpModel {
  bool? status;
  dynamic message;
  DiseasesHelpModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}

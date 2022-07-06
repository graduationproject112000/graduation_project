class RecruitmentHelpModel {
  bool? status;
  dynamic message;

  RecruitmentHelpModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}

class SpecialistCardModel{
  bool? status;
  dynamic message;

  SpecialistCardModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
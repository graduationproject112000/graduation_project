class SpecialistTableModel {
  bool? status;
  dynamic message;

  SpecialistTableModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}

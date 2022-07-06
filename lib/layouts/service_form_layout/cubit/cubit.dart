import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layouts/service_form_layout/cubit/states.dart';
import 'package:graduation_project/shared/constants.dart';
import '../../../shared/networks/remote/dio_helper.dart';

class ServiceFormCubit extends Cubit<ServiceFormStates> {
  ServiceFormCubit() : super(ServiceFormInitialState());

  static ServiceFormCubit get(context) => BlocProvider.of(context);
  List? serviceInformation;

  late List<String> texts;
  late List<File> images;
  late List<File> imagesLast;
  late List<Color> errorColors;

  void changeErrorColor() {
    for (int i = 0 ; i < texts.length ; i ++){
      if ( texts[i] == 'أختار صورة' && isStartButtonPressed == true){
        errorColors[i] = Colors.red;
      }else{
        errorColors[i] = Colors.grey[50] as Color;
      }
    }
    emit(ServiceFormSuccessChangeErrorColorState());
  }

  void readServiceInformationFromJson(isUpdate, unionName, title) {
    print(unionName + "     " + title);
    emit(ServiceFormLoadingServiceInformationState());
    rootBundle.loadString('assets/json/service_info.json').then((value) {
      final data = json.decode(value);
      serviceInformation = data["النقابات"][unionName][title];
      if (isUpdate){
        for (int i = 0 ; i < serviceInformation!.length ; i++){
          texts = List<String>.generate(
              serviceInformation!.length, (counter) => serviceInformation![counter]);
        }
      }else{
        texts = List<String>.generate(
            serviceInformation!.length, (counter) => 'أختار صورة');
      }
      images = List<File>.generate(
          serviceInformation!.length, (counter) => File(''));
      imagesLast = List<File>.generate(
          serviceInformation!.length, (counter) => File(''));
      errorColors = List<Color>.generate(
          serviceInformation!.length, (counter) => Colors.grey[50] as Color);
      emit(ServiceFormSuccessGetServiceInformationState());
      readServiceDBFromJson(unionName, title);
    });
  }

   late List serviceDB;
  late List serviceDBLast;

  void readServiceDBFromJson(unionName, title) {
    emit(ServiceFormLoadingServiceDBState());
    rootBundle.loadString('assets/json/service_info_db.json').then((value) {
      final data = json.decode(value);
      serviceDB = data["النقابات"][unionName][title];
      serviceDBLast = data["النقابات"][unionName][title];
      emit(ServiceFormSuccessGetServiceDBState());
    });
  }

  void changeFile(pickedFile, index) {
    print("jdkfhskhfkshfkshhshks");
    images[index] = File(pickedFile.path);
    var fileName = (pickedFile.path.split('/').last);
    texts[index] = fileName;
    changeErrorColor();
    emit(ServiceFormSuccessChangeFileState());
  }

  String startServiceMessage = '';
  List<int> indexes = [];

  void startService(serviceId, url) {
    print(serviceDBLast.toString());
    for(int i = 0 ; i < serviceDB.length ; i++){
      if (texts[i].contains('image_picker')){
        serviceDBLast[i] = serviceDB[i];
        imagesLast[i] = images[i];
      }else{
        indexes.add(i);
      }
    }
    for(int i = serviceDBLast.length - 1 ; i >= 0 ; i--){
      if (indexes.contains(i)){
        serviceDBLast.removeAt(i);
        imagesLast.removeAt(i);
      }
    }
    print(serviceDBLast.toString());
    emit(ServiceFormLoadingStartServiceState());
    DioHelper.uploadImage(
      url: url + serviceId,
      files: imagesLast,
      token: token,
      test: serviceDBLast,
    ).then((value) {
      if (value.data['message'] is String) {
        startServiceMessage = value.data['message'];
      }
      emit(ServiceFormSuccessStartServiceState(value.data['status']));
    }).catchError((error) {
      print("object111111111"+ error.toString());
      emit(ServiceFormErrorStartServiceState());
    });
  }

  bool isStartButtonPressed = false;

  void changeIsStartButtonPressed() {
    isStartButtonPressed = true;
    emit(ServiceFormSuccessChangeIsStartButtonPressedState());
  }
}

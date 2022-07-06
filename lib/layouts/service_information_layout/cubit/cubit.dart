import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layouts/service_information_layout/cubit/states.dart';
import 'package:graduation_project/shared/networks/remote/dio_helper.dart';

import '../../../shared/constants.dart';

class ServiceInformationCubit extends Cubit<ServiceInformationStates> {
  ServiceInformationCubit() : super(ServiceInformationInitialState());

  static ServiceInformationCubit get(context) => BlocProvider.of(context);
  List? serviceInformation;

  void readServiceInformationFromJson(unionName, title) {
    emit(ServiceInformationLoadingServiceInformationState());
    rootBundle.loadString('assets/json/service_info.json').then((value) {
      final data = json.decode(value);
      serviceInformation = data["النقابات"][unionName][title];
      print('ahmed 1 ' + serviceInformation.toString());
      emit(ServiceInformationSuccessGetServiceInformationState());
    });
  }

  void checkServices(serviceId) {
    print("before");
    DioHelper.getData(url: 'serviceInfo/$serviceId', token: token)
        .then((value) {
      print("after");
      print(value.data['message']);

      emit(CheckServicesSuccessState(
          message: value.data['message'], status: value.data['status']));
    }).catchError((error) {
      print("check Service Error is " + error.toString());
      emit(CheckServicesErrorState());
    });
  }

  void deleteService(serviceId, test) {
    emit(DeleteServiceLoadingState());
    DioHelper.getData(url: 'services/delete/' + serviceId, token: token)
        .then((value) {
          print(value.data.toString());
      emit(DeleteServiceSuccessState());
      test();
    }).catchError((error) {
      print(error.toString());
      emit(DeleteServiceErrorState());
    });
  }
}

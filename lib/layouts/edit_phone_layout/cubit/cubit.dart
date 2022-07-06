import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layouts/edit_phone_layout/cubit/states.dart';
import 'package:graduation_project/shared/networks/remote/dio_helper.dart';

import '../../../shared/constants.dart';

class EditPhoneCubit extends Cubit<EditPhoneStates> {
  EditPhoneCubit() : super(EditPhoneInitialState());

  bool isPassword = true;
  IconData suffix = Icons.visibility;
  Map<String, dynamic> errors = {};

  static EditPhoneCubit get(context) => BlocProvider.of(context);

  void changePhonePasswordVisibility() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility : Icons.visibility_off;
    emit(EditPhoneChangeVisibilityState());
  }

  void changePhoneNumber({required phone, required password}) {
    emit(ChangePhoneLoadingState());
    DioHelper.postData(
        url: "changePhone",
        token: token,
        data: {'phone': phone, 'password': password}).then((value) {
      print(value.data['message']);
      errors.clear();
      if (value.data['status'] == true) {
        errors.clear();
      }
      if (value.data['message'] is Map<String, dynamic>) {
        errors = value.data['message'];
      }
      emit(ChangePhoneSuccessState(
          status: value.data['status'], message: value.data['message']));
    }).catchError((error) {
      print("error is $error");
      emit(ChangePhoneErrorState());
    });
  }
}

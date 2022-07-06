import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layouts/edit_email_layout/cubit/states.dart';

import '../../../shared/constants.dart';
import '../../../shared/networks/remote/dio_helper.dart';

class EditEmailCubit extends Cubit<EditEmailStates> {
  EditEmailCubit() : super(EditEmailInitialState());

  bool isPassword = true;
  IconData suffix = Icons.visibility_outlined;
  Map<String, dynamic> errors = {};

  static EditEmailCubit get(context) => BlocProvider.of(context);

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility : Icons.visibility_off;

    emit(EditEmailChangeVisibilityState());
  }

  void changeEmail({required email, required password}) {
    emit(ChangeEmailLoadingState());
    DioHelper.postData(
        url: "changeEmail",
        token: token,
        data: {'email': email, 'password': password}).then((value) {
      print(value.data['message']);
      errors.clear();
      if (value.data['status'] == true) {
        errors.clear();
      }
      if (value.data['message'] is Map<String, dynamic>) {
        errors = value.data['message'];
      }
      emit(ChangeEmailLSuccessState(
          status: value.data['status'], message: value.data['message']));
    }).catchError((error) {
      print("error is $error");
      emit(ChangeEmailLErrorState());
    });
  }
}

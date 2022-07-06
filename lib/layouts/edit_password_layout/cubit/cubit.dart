import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layouts/edit_password_layout/cubit/states.dart';
import 'package:graduation_project/shared/networks/remote/dio_helper.dart';

import '../../../shared/constants.dart';

class EditPasswordCubit extends Cubit<EditPasswordStates> {
  EditPasswordCubit() : super(EditPasswordInitialState());

  bool isOldPassword = true;
  bool isNewPassword = true;
  bool isConfirmPassword = true;

  IconData oldSuffix = Icons.visibility;
  IconData newSuffix = Icons.visibility;
  IconData confirmSuffix = Icons.visibility;

  static EditPasswordCubit get(context) => BlocProvider.of(context);

  void changeOldPasswordVisibility() {
    isOldPassword = !isOldPassword;
    oldSuffix = isOldPassword ? Icons.visibility : Icons.visibility_off;
    emit(EditPasswordChangeVisibilityState());
  }

  void changeNewPasswordVisibility() {
    isNewPassword = !isNewPassword;
    newSuffix = isNewPassword ? Icons.visibility : Icons.visibility_off;
    emit(EditPasswordChangeVisibilityState());
  }

  void changeConfirmPasswordVisibility() {
    isConfirmPassword = !isConfirmPassword;
    confirmSuffix = isConfirmPassword ? Icons.visibility : Icons.visibility_off;
    emit(EditPasswordChangeVisibilityState());
  }

  Map<String, dynamic> errors = {};
  void deleteVariable() {
    errors.clear();
  }

  void changePassword(
      {required oldPassword,
      required newPassword,
      required newPasswordConfirmation}) {
    emit(ChangePasswordLoadingState());
    DioHelper.postData(
            url: "changePassword",
            data: {
              'Oldpassword': oldPassword,
              'Newpassword': newPassword,
              'Newpassword_confirmation': newPasswordConfirmation
            },
            token: token)
        .then((value) {
      print(value.data['message']);
      errors.clear();
      if (value.data['status'] == true) {
        errors.clear();
      }
      if (value.data['message'] is Map<String, dynamic>) {
        errors = value.data['message'];
      }
      emit(ChangePasswordSuccessState(
          status: value.data['status'], message: value.data['message']));
    }).catchError((errors) {
      print("error is $errors");
      emit(ChangePasswordErrorState());
    });
  }
}

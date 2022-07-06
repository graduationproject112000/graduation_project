import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/layouts/register_layout/cubit/states.dart';

import '../../../models/register_model.dart';
import '../../../shared/networks/end_point.dart';
import '../../../shared/networks/remote/dio_helper.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  bool isPassword = true;
  bool isConfirmPassword = true;
  IconData passwordSuffix = Icons.visibility_outlined;
  IconData confirmSuffix = Icons.visibility_outlined;

  static RegisterCubit get(context) => BlocProvider.of(context);

  void changePasswordVisibility() {
    isPassword = !isPassword;
    passwordSuffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(RegisterChangeVisibilityState());
  }

  void changeConfirmPasswordVisibility() {
    isConfirmPassword = !isConfirmPassword;
    confirmSuffix = isConfirmPassword
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(RegisterChangeVisibilityState());
  }

  RegisterModel? registerModel;

  void userRegister(
      {required String email,
        required String password,
        required String confirmPassword,
        required String unionNumber,
        required String ssn}) {
    emit(RegisterLoadingUserState());
    DioHelper.postData(url: REGISTER, data: {
      'email': email,
      'password': password,
      'password_confirmation': confirmPassword,
      'union_number': unionNumber,
      'ssn': ssn
    }).then((value) {
      registerModel = RegisterModel.fromJson(value.data);
      emit(RegisterSuccessUserState(registerModel));
    }).catchError((error) {
      print("error is " + error.toString());
      emit(RegisterErrorUserState());
    });
  }


}

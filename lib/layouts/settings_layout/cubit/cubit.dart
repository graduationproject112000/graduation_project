import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layouts/settings_layout/cubit/states.dart';
import 'package:graduation_project/shared/constants.dart';
import 'package:graduation_project/shared/networks/remote/dio_helper.dart';

import '../../../models/User_information.dart';

class SettingCubit extends Cubit<SettingState> {
  SettingCubit() : super(SettingInitialState());
  static SettingCubit get(context) => BlocProvider.of(context);
  UserInformation? userInformation;
  void getUserInfo() {
    emit(UserInformationLoadingState());
    DioHelper.getData(url: 'userInfo', token: token).then((value) {
      userInformation = UserInformation.fromJson(value.data);
      emit(UserInformationSuccessState(userInformation: userInformation));
    }).catchError((error) {
      emit(UserInformationErrorState());
    });
  }

  void sendEmailVerified() {
    print("before");
    emit(EmailVerifiedLoadingState());
    DioHelper.postData(url: 'email/verification-notification', token: token).then((value) {

      print("success");
      emit(EmailVerifiedSuccessState());
    }).catchError((error) {
      print("error");
      emit(EmailVerifiedErrorState());
    });
  }
}

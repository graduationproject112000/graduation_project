import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layouts/settings_layout/cubit/states.dart';
import 'package:graduation_project/models/email_model.dart';
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

  EmailModel? emailModel;

  void sendEmailVerified() {
    print("before");
    emit(EmailVerifiedLoadingState());
    DioHelper.postData(url: 'email/verification-notification', token: token)
        .then((value) {
      emailModel = EmailModel.fromJson(value.data);
      emit(EmailVerifiedSuccessState(message: emailModel!.message.toString()));
      print(emailModel!.message.toString());
    }).catchError((error) {
      print("error");
      emit(EmailVerifiedErrorState());
    });
  }
}

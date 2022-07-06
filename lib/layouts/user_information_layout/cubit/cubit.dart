import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layouts/user_information_layout/cubit/states.dart';
import 'package:graduation_project/shared/constants.dart';
import 'package:graduation_project/shared/networks/remote/dio_helper.dart';

import '../../../models/User_information.dart';

class UserInformationCubit extends Cubit<UserInformationState> {
  UserInformationCubit() : super(UserInformationInitialState());

  static UserInformationCubit get(context) => BlocProvider.of(context);

  UserInformation? userInformation;
  void getUserInfo() {
    emit(UserInformationLoadingState());
    DioHelper.getData(url: 'userInfo', token: token).then((value) {
      userInformation = UserInformation.fromJson(value.data);
      print(userInformation!.data!.name);
      emit(UserInformationSuccessState(userInformation: userInformation));
    }).catchError((error) {
      emit(UserInformationErrorState());
    });
  }
}

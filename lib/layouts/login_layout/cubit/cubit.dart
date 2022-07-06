import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/layouts/home_layout/cubit/cubit.dart';
import 'package:graduation_project/layouts/login_layout/cubit/states.dart';

import '../../../models/user_model.dart';
import '../../../shared/constants.dart';
import '../../../shared/networks/end_point.dart';
import '../../../shared/networks/local/cache_helper.dart';
import '../../../shared/networks/remote/dio_helper.dart';

class LoginCubit extends Cubit<LoginStates>{
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);
  bool isPassword=true;
  IconData suffix = Icons.visibility_outlined;

  void changeLoginPasswordVisibility()
  {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined ;
    emit(LoginChangeVisibilityState());
  }
  late UserModel userModel;

  void userLogin({required String email, required String password, required context}) {
    emit(LoginLoadingUserState());
    print("before");
    DioHelper.postData(url: LOGIN, data: {'email': email, 'password': password})
        .then((value) {
      print("while");
      userModel = UserModel.fromJson(value.data);
      if (userModel.data != null){
        print("inside");
        unionId = userModel.data!.unionId;
        token = userModel.token;
        CacheHelper.saveData(key: 'token', value: userModel.token);
        CacheHelper.saveData(key: 'unionId', value: userModel.data!.unionId);

      }
      emit(LoginSuccessUserState(userModel));
      print("after");
    }).catchError((error) {
      print("error is" + error.toString());
      emit(LoginErrorUserState());
    });
  }

}
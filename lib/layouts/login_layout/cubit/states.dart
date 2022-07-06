import 'package:graduation_project/models/user_model.dart';

abstract class LoginStates{}

class LoginInitialState extends LoginStates{}

class LoginChangeVisibilityState extends LoginStates{}

class LoginSuccessGetServicesState extends LoginStates{}

class LoginLoadingUserState extends LoginStates{}
class LoginSuccessUserState extends LoginStates{
  final UserModel? userModel;

  LoginSuccessUserState(this.userModel);
}
class LoginErrorUserState extends LoginStates{}

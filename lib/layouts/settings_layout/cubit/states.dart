import '../../../models/User_information.dart';

abstract class SettingState {}

class SettingInitialState extends SettingState {}

class UserInformationLoadingState extends SettingState {}

class UserInformationSuccessState extends SettingState {
  final UserInformation? userInformation;

  UserInformationSuccessState({required this.userInformation});
}

class UserInformationErrorState extends SettingState {}

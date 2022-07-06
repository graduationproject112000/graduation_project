import '../../../models/User_information.dart';

abstract class UserInformationState {}

class UserInformationInitialState extends UserInformationState {}

class UserInformationLoadingState extends UserInformationState {}

class UserInformationSuccessState extends UserInformationState {
  final UserInformation? userInformation;

  UserInformationSuccessState({required this.userInformation});
}

class UserInformationErrorState extends UserInformationState {}

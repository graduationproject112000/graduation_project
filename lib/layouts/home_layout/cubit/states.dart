abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

class SliderIndexSuccessChange extends HomeStates {}

class HomeBottomNavigationChangeState extends HomeStates {}

class HomeSuccessGetServicesState extends HomeStates {}

class HomeLoadingUnionServicesState extends HomeStates {}

class HomeSuccessUnionServicesState extends HomeStates {}

class HomeErrorUnionServicesState extends HomeStates {}

class GetUserOrdersLoadingState extends HomeStates {}

class GetUserOrdersSuccessUnionState extends HomeStates {}

class GetUserOrdersErrorState extends HomeStates {}

class DeleteUserOrderSuccessUnionState extends HomeStates {
  final String deleteMessage;

  DeleteUserOrderSuccessUnionState(this.deleteMessage);
}

class DeleteUserOrderErrorState extends HomeStates {}

class UserInformationLoadingState extends HomeStates {}

class UserInformationSuccessState extends HomeStates {}

class UserInformationErrorState extends HomeStates {}

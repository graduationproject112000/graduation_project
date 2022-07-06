abstract class EditPhoneStates {}

class EditPhoneInitialState extends EditPhoneStates {}

class EditPhoneChangeVisibilityState extends EditPhoneStates {}

class ChangePhoneLoadingState extends EditPhoneStates {}

class ChangePhoneSuccessState extends EditPhoneStates {
  final bool status;
  final message;

  ChangePhoneSuccessState({required this.status, required this.message});
}

class ChangePhoneErrorState extends EditPhoneStates {}

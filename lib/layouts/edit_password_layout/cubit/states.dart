abstract class EditPasswordStates {}

class EditPasswordInitialState extends EditPasswordStates {}

class EditPasswordChangeVisibilityState extends EditPasswordStates {}

class ChangePasswordLoadingState extends EditPasswordStates {}

class ChangePasswordSuccessState extends EditPasswordStates {
  final bool status;
  final message;

  ChangePasswordSuccessState({required this.status, required this.message});
}

class ChangePasswordErrorState extends EditPasswordStates {}

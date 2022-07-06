abstract class EditEmailStates {}

class EditEmailInitialState extends EditEmailStates {}

class EditEmailChangeVisibilityState extends EditEmailStates {}

class ChangeEmailLoadingState extends EditEmailStates {}

class ChangeEmailLSuccessState extends EditEmailStates {
  final status;
  final message;

  ChangeEmailLSuccessState({required this.status, required this.message});
}

class ChangeEmailLErrorState extends EditEmailStates {}

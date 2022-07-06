abstract class ServiceInformationStates {}

class ServiceInformationInitialState extends ServiceInformationStates {}

class ServiceInformationLoadingServiceInformationState
    extends ServiceInformationStates {}

class ServiceInformationSuccessGetServiceInformationState
    extends ServiceInformationStates {}

class CheckServicesSuccessState extends ServiceInformationStates {
  final String message;
  final bool status;

  CheckServicesSuccessState({required this.message, required this.status});
}

class CheckServicesErrorState extends ServiceInformationStates {}

class DeleteServiceSuccessState extends ServiceInformationStates {
  DeleteServiceSuccessState();
}

class DeleteServiceErrorState extends ServiceInformationStates {}
class DeleteServiceLoadingState extends ServiceInformationStates {}
class ChangeIsDeletedSuccessState extends ServiceInformationStates {

}

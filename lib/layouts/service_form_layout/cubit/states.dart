abstract class ServiceFormStates{}
class ServiceFormInitialState extends ServiceFormStates{}
class ServiceFormLoadingServiceInformationState extends ServiceFormStates{}
class ServiceFormSuccessGetServiceInformationState extends ServiceFormStates{}

class ServiceFormLoadingServiceDBState extends ServiceFormStates{}
class ServiceFormSuccessGetServiceDBState extends ServiceFormStates{}

class ServiceFormSuccessChangeFileState extends ServiceFormStates{}

class ServiceFormSuccessChangeErrorColorState extends ServiceFormStates{}

class ServiceFormLoadingStartServiceState extends ServiceFormStates{}
class ServiceFormSuccessStartServiceState extends ServiceFormStates{
  final bool updateState;

  ServiceFormSuccessStartServiceState(this.updateState);
}
class ServiceFormErrorStartServiceState extends ServiceFormStates{}

class ServiceFormSuccessChangeIsStartButtonPressedState extends ServiceFormStates{}


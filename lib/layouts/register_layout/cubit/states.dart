import '../../../models/register_model.dart';

abstract class RegisterStates{}

class RegisterInitialState extends RegisterStates{}

class RegisterChangeVisibilityState extends RegisterStates{}

class RegisterLoadingUserState extends RegisterStates{}
class  RegisterSuccessUserState extends  RegisterStates{
  final  RegisterModel? registerModel;

  RegisterSuccessUserState(this.registerModel);
}
class  RegisterErrorUserState extends  RegisterStates{}


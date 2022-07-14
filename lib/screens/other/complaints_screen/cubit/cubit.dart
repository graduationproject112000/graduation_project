import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/screens/other/complaints_screen/cubit/states.dart';
import 'package:graduation_project/shared/networks/remote/dio_helper.dart';

import '../../../../models/problems_model.dart';
import '../../../../models/union_phone.dart';

class ProblemCubit extends Cubit<ProblemStates> {
  ProblemCubit() : super(ProblemInitialState());

  static ProblemCubit get(context) => BlocProvider.of(context);
  late ProblemsModel problemsModel = ProblemsModel();
  Data? newValue;
  String phone = '';
  void changeValue(value) {
    newValue = value;
    emit(ChangeNewValueSuccessState());
  }

  void getUnionsNames() {
    DioHelper.getData(url: "unions").then((value) {
      problemsModel = ProblemsModel.fromJson(value.data);
      print(problemsModel.data[0].name.toString());
      emit(GetUnionsNamesSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetUnionsNamesErrorState());
    });
  }

  UnionsPhone? unionsPhone;
  void getUnionsPhones(int id) {
    DioHelper.getData(url: "unions/problem/" + id.toString()).then((value) {
      unionsPhone = UnionsPhone.fromJson(value.data);
      print(phone);
      phone = unionsPhone!.data!.phone!;
      print(phone);
      emit(GetUnionPhoneSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetUnionPhoneErrorState());
    });
  }
}

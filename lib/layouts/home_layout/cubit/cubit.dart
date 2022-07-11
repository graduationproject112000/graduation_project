import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layouts/home_layout/cubit/states.dart';

import '../../../models/User_information.dart';
import '../../../models/union_model.dart';
import '../../../models/user_order.dart';
import '../../../screens/home/home_screen/home_screen.dart';
import '../../../screens/home/news_screen/news_screen.dart';
import '../../../screens/home/orders_screen/orders_screen.dart';
import '../../../screens/home/services_screen/services_screen.dart';
import '../../../shared/constants.dart';
import '../../../shared/networks/remote/dio_helper.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  int sliderIndex = 0;

  List<String> screenTitles = [
    'الرئيسية',
    'خدماتي',
    'طلباتي',
    'الأخبار',
  ];

  List? services;
  void sliderIndexChange(index) {
    sliderIndex = index;
    emit(SliderIndexSuccessChange());
  }

  void getServices(List data) {
    services = data;
  }

  List<Widget> screens = [
    HomeScreen(),
    ServicesScreen(),
    OrdersScreen(),
    NewsScreen(),
  ];

  UserInformation? userInformation;
  void getUserInfo() {
    emit(UserInformationLoadingState());
    DioHelper.getData(url: 'userInfo', token: token).then((value) {
      userInformation = UserInformation.fromJson(value.data);
      emit(UserInformationSuccessState(userInformation: userInformation));
    }).catchError((error) {
      emit(UserInformationErrorState());
    });
  }

  void changeBottomBar(index) {
    currentIndex = index;
    emit(HomeBottomNavigationChangeState());
  }

  void readServicesFromJson() {
    rootBundle.loadString('assets/json/services.json').then((value) {
      final data = json.decode(value);
      services = data["النقابات"]["نقابة الصيادلة"];
      emit(HomeSuccessGetServicesState());
    });
  }

  late UnionModel unionModel = new UnionModel();

  void getUnionServices() {
    getUserOrders();
    emit(HomeLoadingUnionServicesState());
    DioHelper.getData(url: 'unions/show/$unionId').then((value) {
      unionModel = UnionModel.fromJson(value.data);
      getUserOrders();
      print('image url is : ' + unionModel.data.services[0].image.toString());
      emit(HomeSuccessUnionServicesState());
    }).catchError((error) {
      print(error.toString());
      emit(HomeErrorUnionServicesState());
    });
  }

  late UserOrder userOrder = new UserOrder();

  void getUserOrders() {
    emit(GetUserOrdersLoadingState());
    DioHelper.getData(url: 'services/myservice', token: token).then((value) {
      userOrder = UserOrder.fromJson(value.data);
      emit(GetUserOrdersSuccessUnionState());
      getUserInfo();
    }).catchError((error) {
      print("get user Order Error " + error.toString());
      emit(GetUserOrdersErrorState());
    });
  }

  void deleteUserOrder(serviceId) {
    DioHelper.getData(url: 'services/delete/' + serviceId, token: token)
        .then((value) {
      if (value.data['status'] == true) {
        getUserOrders();
      }
      print(value.data['message']);
      emit(DeleteUserOrderSuccessUnionState(value.data['message']));
    }).catchError((error) {
      print(error.toString());
      emit(DeleteUserOrderErrorState());
    });
  }
}

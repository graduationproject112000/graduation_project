import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layouts/edit_email_layout/cubit/cubit.dart';
import 'package:graduation_project/layouts/edit_password_layout/cubit/cubit.dart';
import 'package:graduation_project/layouts/edit_phone_layout/cubit/cubit.dart';
import 'package:graduation_project/layouts/login_layout/cubit/cubit.dart';
import 'package:graduation_project/layouts/login_layout/dart/login_layout.dart';
import 'package:graduation_project/layouts/register_layout/cubit/cubit.dart';
import 'package:graduation_project/screens/other/complaints_screen/cubit/cubit.dart';
import 'package:graduation_project/shared/styles/colors.dart';

import 'layouts/home_layout/cubit/cubit.dart';
import 'layouts/service_information_layout/cubit/cubit.dart';
import 'layouts/user_information_layout/cubit/cubit.dart';
import 'shared/constants.dart';
import 'shared/networks/local/cache_helper.dart';
import 'shared/networks/remote/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DioHelper.init();
  await CacheHelper.init();

  token = CacheHelper.getData(key: 'token');
  unionId = CacheHelper.getData(key: 'unionId');
  print(token);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => EditEmailCubit()),
        BlocProvider(create: (context) => EditPasswordCubit()),
        BlocProvider(create: (context) => EditPhoneCubit()),
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => RegisterCubit()),
        BlocProvider(create: (context) => ServiceInformationCubit()),
        BlocProvider(
            create: (context) => UserInformationCubit()..getUserInfo()),
        BlocProvider(create: (context) => HomeCubit()..getUserOrders()),
        BlocProvider(create: (context) => ProblemCubit()..getUnionsNames()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginLayout(),
        // OnBoardingScreen(),
        // const SplashLayout(),
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'DefaultFont',
          appBarTheme: const AppBarTheme(
            backgroundColor: mainColor,
            centerTitle: true,
          ),
        ),
      ),
    );
  }
}

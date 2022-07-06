import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layouts/login_layout/cubit/cubit.dart';
import 'package:graduation_project/layouts/login_layout/cubit/states.dart';
import 'package:graduation_project/screens/other/forget_password_screen.dart';
import 'package:lottie/lottie.dart';

import '../../../shared/constants.dart';
import '../../../shared/networks/local/cache_helper.dart';
import '../../../shared/styles/colors.dart';
import '../../../shared/widgets/widgets.dart';
import '../../home_layout/dart/home_layout.dart';
import '../../register_layout/dart/register_layout.dart';

class LoginLayout extends StatelessWidget {
  LoginLayout({Key? key}) : super(key: key);

  var emailCotroller = TextEditingController();
  var passwordCotroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {
        if (state is LoginSuccessUserState) {
          if (state.userModel!.status == true) {
            print(state.userModel!.message);
            CacheHelper.saveData(key: 'token', value: state.userModel!.token);
            CacheHelper.saveData(
                key: 'unionId', value: state.userModel!.data!.unionId);
            unionId = state.userModel!.data!.unionId;
            token = state.userModel!.token;
            print("union id =" + unionId.toString());
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (ctx) => HomeLayout(0),
              ),
            );
          } else {
            if (state.userModel!.message is String) {
              print(state.userModel!.message);
              ShowToast(
                text: state.userModel!.message.toString(),
              );
            } else {
              if (state.userModel!.message['email'] != null) {
                ShowToast(
                  text: state.userModel!.message['email'][0].toString(),
                );
              } else if (state.userModel!.message['password'] != null) {
                ShowToast(
                  text: state.userModel!.message['password'][0].toString(),
                );
              }
            }
          }
        } else if (state is LoginErrorUserState) {
          ShowToast(
            text: 'خطأ في الاتصال',
          );
        }
      },
      builder: (context, state) {
        var cubit = LoginCubit.get(context);
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                statusBarIconBrightness: Brightness.dark,
              ),
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      'assets/json/sign.json',
                      width: 200,
                      height: 200,
                      animate: false,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "تسجيل الدخول",
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 30),
                    inputField(
                      controller: emailCotroller,
                      hint: 'ادخل البريد الالكتروني',
                      title: 'البريد الالكتروني',
                      prefixIcon: const Icon(
                        Icons.mail,
                      ),
                      inputType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 10),
                    inputField(
                      controller: passwordCotroller,
                      hint: 'ادخل كلمة المرور',
                      title: 'كلمة المرور',
                      prefixIcon: const Icon(
                        Icons.lock,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(cubit.suffix),
                        onPressed: () {
                          cubit.changeLoginPasswordVisibility();
                        },
                      ),
                      inputType: TextInputType.visiblePassword,
                      isPassword: cubit.isPassword,
                    ),
                    const SizedBox(height: 15),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) => const ForgetPasswordScreen(
                                url: 'http://127.0.0.1:8000/requestPassword')),
                          ),
                        );
                      },
                      child: const Text(
                        "هل نسيت كلمة السر؟",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: secondaryColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    ConditionalBuilder(
                      condition: state is! LoginLoadingUserState,
                      builder: (context) {
                        return Container(
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: mainColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: MaterialButton(
                            onPressed: () {
                              LoginCubit.get(context).userLogin(
                                email: emailCotroller.text,
                                password: passwordCotroller.text,
                                context: context,
                              );
                            },
                            child: const Text(
                              "تسجيل الدخول",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        );
                      },
                      fallback: (context) {
                        return const Center(
                            child: CircularProgressIndicator(
                          color: secondaryColor,
                        ));
                      },
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "ليس لديك حساب؟ ",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.blueGrey,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (ctx) => RegisterLayout(),
                              ),
                            );
                          },
                          child: const Text(
                            "إنشاء حساب",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: secondaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

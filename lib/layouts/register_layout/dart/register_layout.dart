import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layouts/login_layout/dart/login_layout.dart';
import 'package:graduation_project/layouts/register_layout/cubit/cubit.dart';
import 'package:graduation_project/layouts/register_layout/cubit/states.dart';
import 'package:lottie/lottie.dart';

import '../../../shared/styles/colors.dart';
import '../../../shared/widgets/widgets.dart';

class RegisterLayout extends StatelessWidget {
   RegisterLayout({Key? key}) : super(key: key);

  var emailCotroller = TextEditingController();
  var passwordCotroller = TextEditingController();
  var confirmPasswordCotroller = TextEditingController();
  var ssnCotroller = TextEditingController();
  var unionCotroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterStates>(
      listener: (context, state) {
        if (state is RegisterSuccessUserState) {
          if (state.registerModel!.status == true) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (ctx) => LoginLayout(),
              ),
            );
          } else {
            if (state.registerModel!.message is Map) {
              if (state.registerModel!.message['email'] != null) {
                ShowToast(text: state.registerModel!.message['email'][0]);
              } else if (state.registerModel!.message['password'] != null) {
                ShowToast(text: state.registerModel!.message['password'][0]);
              } else if (state.registerModel!.message['ssn'] != null) {
                ShowToast(text: state.registerModel!.message['ssn'][0]);
              } else if (state.registerModel!.message['union_number'] != null) {
                ShowToast(
                    text: state.registerModel!.message['union_number'][0]);
              }
            } else {
              ShowToast(text: state.registerModel!.message.toString());
            }
          }
        }else if (state is RegisterErrorUserState){
          ShowToast(text: "خطأ في الإتصال");
        }

      },
      builder: (context, state) {
        var cubit = RegisterCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Center(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset(
                        'assets/json/signup.json',
                        width: 200,
                        height: 200,
                        animate: false,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "إنشاء حساب",
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
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
                          icon: Icon(cubit.passwordSuffix),
                          onPressed: () {
                            cubit.changePasswordVisibility();
                          },
                        ),
                        inputType: TextInputType.visiblePassword,
                        isPassword: cubit.isPassword,
                      ),
                      const SizedBox(height: 10),
                      inputField(
                        controller: confirmPasswordCotroller,
                        hint: 'ادخل كلمة المرور',
                        title: 'تاكيد كلمة المرور',
                        prefixIcon: const Icon(
                          Icons.lock,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            cubit.confirmSuffix
                          ),
                          onPressed: () {
                            cubit.changeConfirmPasswordVisibility();
                          },
                        ),
                        inputType: TextInputType.visiblePassword,
                        isPassword: cubit.isConfirmPassword,
                      ),
                      const SizedBox(height: 10),
                      inputField(
                        controller: ssnCotroller,
                        hint: 'ادخل الرقم القومي',
                        title: 'الرقم القومي',
                        prefixIcon: const Icon(
                          Icons.credit_card_rounded,
                        ),
                        inputType: TextInputType.number,
                      ),
                      const SizedBox(height: 10),
                      inputField(
                        controller: unionCotroller,
                        hint: 'ادخل الكود النقابي',
                        title: 'الكود النقابي',
                        prefixIcon: const Icon(
                          Icons.credit_card_rounded,
                        ),
                        inputType: TextInputType.number,
                      ),
                      const SizedBox(height: 15),
                      ConditionalBuilder(
                        condition: state is! RegisterLoadingUserState,
                        builder: (context) => Container(
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: mainColor,
                          ),
                          child: MaterialButton(
                            onPressed: () {
                              RegisterCubit.get(context).userRegister(
                                  email: emailCotroller.text,
                                  password: passwordCotroller.text,
                                  confirmPassword: confirmPasswordCotroller.text,
                                  unionNumber: unionCotroller.text,
                                  ssn: ssnCotroller.text);
                            },
                            child: const Text(
                              "تسجيل",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
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
                            "هل لديك حساب؟ ",
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
                                  builder: (ctx) =>  LoginLayout(),
                                ),
                              );
                            },
                            child: const Text(
                              "تسجيل الدخول",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: secondaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

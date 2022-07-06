import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layouts/settings_layout/dart/settings_layout.dart';

import '../../../shared/styles/colors.dart';
import '../../../shared/widgets/widgets.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';

class EditEmailLayout extends StatelessWidget {
  EditEmailLayout({Key? key}) : super(key: key);

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditEmailCubit, EditEmailStates>(
      listener: (context, state) {
        if (state is ChangeEmailLSuccessState) {
          if (state.status == true) {
            ShowToast(text: state.message);
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
                  return SettingsLayout();
                }));
          }
        }
      },
      builder: (context, state) {
        var cubit = EditEmailCubit.get(context);
        return Directionality(
          textDirection: TextDirection.rtl,
          child: WillPopScope(
            onWillPop: () async {
              final shouldPop = await showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text(
                    'هل انت متأكد أنك لا تريد تغير البريد الإلكتروني ؟',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(fontSize: 15),
                  ),
                  //content: Text('Do you want to leave without saving?'),
                  actions: <Widget>[
                    MaterialButton(
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      child: const Text('لا'),
                      // color: Colors.red,
                    ),
                    MaterialButton(
                      onPressed: () {
                        cubit.errors.clear();
                        Navigator.of(context).pop(true);
                      },
                      child: const Text('نعم'),
                      // color: mainColor,
                    ),
                  ],
                ),
              );

              return shouldPop ?? false;
            },
            child: Scaffold(
              appBar: AppBar(
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF1E88E5),

                        //secondaryColor,
                        mainColor.withOpacity(0.6),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
                title: const Text('تعديل البريد الإلكتروني'),
              ),
              body: Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.only(top: 50),
                child: Column(
                  children: [
                    defaultFormField(
                        label: " أدخل البريد الإلكتروني الجديد",
                        controller: emailController,
                        prefix: Icons.email,
                        validate: (value) {},
                        onSubmit: (value) {},
                        // onChange: (value) {
                        //   cubit.changeEmail(
                        //       email: emailController.text,
                        //       password: emailController.text);
                        // },
                        error: cubit.errors.containsKey('email')
                            ? cubit.errors['email'][0]
                            : '',
                        type: TextInputType.emailAddress),
                    const SizedBox(height: 15),
                    defaultFormField(
                      label: " كلمة المرور",
                      controller: passwordController,
                      prefix: Icons.lock,
                      validate: (value) {},
                      type: TextInputType.visiblePassword,
                      isPassword: EditEmailCubit.get(context).isPassword,
                      suffix: EditEmailCubit.get(context).suffix,
                      error: cubit.errors.containsKey('password')
                          ? cubit.errors['password'][0]
                          : '',
                      suffixPressed: () {
                        EditEmailCubit.get(context).changePasswordVisibility();
                      },
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 130,
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        onPressed: () {
                          cubit.changeEmail(
                              email: emailController.text,
                              password: passwordController.text);
                        },
                        child: const Text(
                          "تعديل",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        color: mainColor,
                        highlightColor: secondaryColor,
                        splashColor: secondaryColor,
                      ),
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

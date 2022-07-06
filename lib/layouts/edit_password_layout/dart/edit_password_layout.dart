import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layouts/edit_password_layout/cubit/cubit.dart';
import 'package:graduation_project/layouts/edit_password_layout/cubit/states.dart';
import 'package:graduation_project/layouts/settings_layout/dart/settings_layout.dart';

import '../../../shared/styles/colors.dart';
import '../../../shared/widgets/widgets.dart';

class EditPasswordLayout extends StatelessWidget {
  EditPasswordLayout({Key? key}) : super(key: key);

  var oldPasswordController = TextEditingController();
  var conformPasswordController = TextEditingController();
  var newPasswordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditPasswordCubit, EditPasswordStates>(
      listener: (context, state) {
        if (state is ChangePasswordSuccessState) {
          if (state.status == true) {
            ShowToast(text: state.message);
            Navigator.pop(context);
          }
        }
      },
      builder: (context, state) {
        var cubit = EditPasswordCubit.get(context);
        return Directionality(
          textDirection: TextDirection.rtl,
          child: WillPopScope(
            onWillPop: () async {
              final shouldPop = await showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text(
                    'هل انت متأكد أنك لا تريد تغير كلمة السر ؟',
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
                title: const Text('تغير كلمة المرور'),
              ),
              body: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.only(top: 50),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        defaultFormField(
                            label: " أدخل كلمة المرور الحالية",
                            controller: oldPasswordController,
                            prefix: Icons.lock,
                            suffix: cubit.oldSuffix,
                            validate: (value) {},
                            error: cubit.errors.containsKey('Oldpassword')
                                ? cubit.errors['Oldpassword'][0]
                                : '',
                            isPassword: cubit.isOldPassword,
                            suffixPressed: () {
                              cubit.changeOldPasswordVisibility();
                            },
                            type: TextInputType.visiblePassword),
                        // Container(
                        //   width: double.infinity,
                        //   child: Text(
                        //     "dddddddddddddddd",
                        //     style: TextStyle(color: Colors.red),
                        //     textAlign: TextAlign.start,
                        //   ),
                        // ),
                        const SizedBox(height: 15),
                        defaultFormField(
                          label: " أدخل كلمة المرور الجديدة",
                          controller: newPasswordController,
                          prefix: Icons.lock,
                          validate: (value) {},
                          suffix: cubit.newSuffix,
                          suffixPressed: () {
                            cubit.changeNewPasswordVisibility();
                          },
                          error: cubit.errors.containsKey('Newpassword')
                              ? cubit.errors['Newpassword'][0]
                              : '',
                          isPassword: cubit.isNewPassword,
                          type: TextInputType.visiblePassword,
                        ),
                        const SizedBox(height: 15),
                        defaultFormField(
                          label: " تأكيد كلمة المرورالجديدة ",
                          controller: conformPasswordController,
                          prefix: Icons.lock,
                          validate: (value) {},
                          error: cubit.errors.containsKey('Newpassword')
                              ? cubit.errors['Newpassword'][0]
                              : '',
                          type: TextInputType.visiblePassword,
                          suffix: cubit.confirmSuffix,
                          suffixPressed: () {
                            cubit.changeConfirmPasswordVisibility();
                          },
                          isPassword: cubit.isConfirmPassword,
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
                              cubit.changePassword(
                                  oldPassword: oldPasswordController.text,
                                  newPassword: newPasswordController.text,
                                  newPasswordConfirmation:
                                      conformPasswordController.text);
                              // if (formKey.currentState!.validate()) {}
                            },
                            child: const Text(
                              "تعديل",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
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
            ),
          ),
        );
      },
    );
  }
}

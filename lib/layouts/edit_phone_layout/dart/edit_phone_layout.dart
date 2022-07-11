import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layouts/edit_phone_layout/cubit/cubit.dart';
import 'package:graduation_project/layouts/edit_phone_layout/cubit/states.dart';

import '../../../shared/styles/colors.dart';
import '../../../shared/widgets/widgets.dart';

class EditPhoneLayout extends StatelessWidget {
  EditPhoneLayout({Key? key}) : super(key: key);

  var phoneController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditPhoneCubit, EditPhoneStates>(
      listener: (context, state) {
        if (state is ChangePhoneSuccessState) {
          if (state.status == true) {
            ShowToast(text: state.message);
            Navigator.pop(context, phoneController.text);
          }
        }
      },
      builder: (context, state) {
        var cubit = EditPhoneCubit.get(context);
        return Directionality(
          textDirection: TextDirection.rtl,
          child: WillPopScope(
            onWillPop: () async {
              final shouldPop = await showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text(
                    'هل انت متأكد أنك لا تريد تغير رقم الهاتف ؟',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                  //content: Text('Do you want to leave without saving?'),
                  actions: <Widget>[
                    MaterialButton(
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      child: const Text('لا'),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      textColor: Colors.white,
                      minWidth: 140,
                      color: Colors.red,
                      // color: Colors.red,
                    ),
                    MaterialButton(
                      onPressed: () {
                        cubit.errors.clear();
                        Navigator.of(context).pop(true);
                      },
                      child: const Text('نعم'),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      textColor: Colors.white,
                      minWidth: 140,
                      color: secondaryColor,
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
                title: const Text("تغيير رقم الهاتف"),
              ),
              body: Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.only(top: 50),
                child: Column(
                  children: [
                    defaultFormField(
                      label: " أدخل رقم الهاتف الجديد",
                      controller: phoneController,
                      prefix: Icons.phone,
                      validate: (value) {},
                      type: TextInputType.phone,
                      error: cubit.errors.containsKey('phone')
                          ? cubit.errors['phone'][0]
                          : '',
                    ),
                    const SizedBox(height: 15),
                    defaultFormField(
                      label: " كلمة المرور",
                      controller: passwordController,
                      prefix: Icons.lock,
                      validate: (value) {},
                      type: TextInputType.visiblePassword,
                      isPassword: cubit.isPassword,
                      suffix: cubit.suffix,
                      error: cubit.errors.containsKey('password')
                          ? cubit.errors['password'][0]
                          : '',
                      suffixPressed: () {
                        cubit.changePhonePasswordVisibility();
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
                          cubit.changePhoneNumber(
                              phone: phoneController.text,
                              password: passwordController.text);
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
        );
      },
    );
  }
}

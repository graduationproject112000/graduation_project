import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layouts/edit_password_layout/dart/edit_password_layout.dart';

import '../../../shared/styles/colors.dart';
import '../../../shared/widgets/widgets.dart';
import '../../edit_email_layout/dart/edit_email_layout.dart';
import '../../edit_phone_layout/dart/edit_phone_layout.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';

class SettingsLayout extends StatelessWidget {
  SettingsLayout({Key? key}) : super(key: key);

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var numberController = TextEditingController();
  var passwordController = TextEditingController();
  String name = '';

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocProvider(
          create: (context) => SettingCubit()..getUserInfo(),
          child: BlocConsumer<SettingCubit, SettingState>(
            listener: (context, state) {
              if (state is UserInformationSuccessState) {
                name = state.userInformation!.data!.name.toString();
                phoneController.text =
                    state.userInformation!.data!.phone.toString();
                emailController.text =
                    state.userInformation!.data!.email.toString();
                numberController.text =
                    state.userInformation!.data!.ssn.toString();
                passwordController.text = "12345678";
              }
            },
            builder: (context, state) {
              return Scaffold(
                body: ConditionalBuilder(
                  condition: state is! UserInformationLoadingState,
                  builder: (context) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 260,
                            child: Stack(
                              alignment: AlignmentDirectional.bottomCenter,
                              children: [
                                Align(
                                  alignment: AlignmentDirectional.topCenter,
                                  child: Container(
                                    width: double.infinity,
                                    height: 200,
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          secondaryColor,
                                          mainColor,
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 30),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                icon: const Icon(
                                                  Icons.arrow_back,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 130,
                                              ),
                                              const Text(
                                                "الإعدادات",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const CircleAvatar(
                                  radius: 65,
                                  backgroundColor: Colors.red,
                                  backgroundImage:
                                      AssetImage('assets/images/person.png'),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(height: 15),
                                const SizedBox(height: 15),
                                defaultFormField(
                                    controller: emailController,
                                    type: TextInputType.emailAddress,
                                    validate: (value) {},
                                    label: "البريد الألكتروني",
                                    prefix: Icons.email,
                                    isRead: true,
                                    suffix: Icons.edit,
                                    suffixPressed: () {
                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(builder: (context) {
                                        return EditEmailLayout();
                                      }));
                                    }),
                                // SettingCubit().userInformation!.email_verified_at== ""?
                                state is UserInformationSuccessState
                                    ? state.userInformation!
                                                .email_verified_at ==
                                            ""
                                        ? Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              const SizedBox(width: 15),
                                              const Expanded(
                                                  child: Text(
                                                "يرجي تأكيد حسابك",
                                                style: TextStyle(
                                                    color: Colors.red),
                                              )),
                                              TextButton(
                                                onPressed: () {},
                                                child:
                                                    const Text("ارسال الرابط"),
                                              ),
                                            ],
                                          )
                                        : const SizedBox(height: 15)
                                    : const SizedBox(height: 15),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    const SizedBox(width: 15),
                                    const Expanded(
                                        child: Text(
                                      "يرجي تأكيد حسابك",
                                      style: TextStyle(color: Colors.red),
                                    )),
                                    TextButton(
                                      onPressed: () {},
                                      child: const Text("ارسال الرابط"),
                                    ),
                                  ],
                                ),
                                // :const SizedBox.shrink(),
                                defaultFormField(
                                    controller: phoneController,
                                    type: TextInputType.phone,
                                    validate: (value) {},
                                    label: "رقم الهاتف",
                                    prefix: Icons.phone,
                                    isRead: true,
                                    suffix: Icons.edit,
                                    suffixPressed: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return EditPhoneLayout();
                                          },
                                        ),
                                      ).then((value) {
                                        SettingCubit().getUserInfo();
                                      });
                                    }),
                                const SizedBox(height: 15),
                                defaultFormField(
                                  controller: numberController,
                                  type: TextInputType.number,
                                  validate: (value) {},
                                  isRead: true,
                                  label: "الرقم القومي",
                                  prefix: Icons.pin,
                                ),
                                const SizedBox(height: 15),
                                defaultFormField(
                                    controller: passwordController,
                                    type: TextInputType.emailAddress,
                                    validate: (value) {},
                                    label: "كلمة المرور",
                                    isPassword: true,
                                    prefix: Icons.lock,
                                    isRead: true,
                                    suffix: Icons.edit,
                                    suffixPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) {
                                          return EditPasswordLayout();
                                        }),
                                      );
                                    }),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  fallback: (context) {
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              );
            },
          )),
    );
  }
}

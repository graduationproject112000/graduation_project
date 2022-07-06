import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/styles/colors.dart';
import '../../../shared/widgets/widgets.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';

class UserInformationLayout extends StatelessWidget {
  UserInformationLayout({Key? key}) : super(key: key);

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocProvider(
        create: (context) => UserInformationCubit()..getUserInfo(),
        child: BlocConsumer<UserInformationCubit, UserInformationState>(
          listener: (context, state) {
            if (state is UserInformationSuccessState) {
              nameController.text =
                  state.userInformation!.data!.name.toString();
              phoneController.text =
                  state.userInformation!.data!.phone.toString();
              emailController.text =
                  state.userInformation!.data!.email.toString();
              numberController.text =
                  state.userInformation!.data!.ssn.toString();
            }
          },
          builder: (context, state) {
            var cubit = UserInformationCubit.get(context);

            return Scaffold(
              appBar: AppBar(
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        secondaryColor,
                        mainColor.withOpacity(0.6),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
                title: const Text("معلوماتي الشخصية"),
              ),
              body: Padding(
                padding: const EdgeInsets.all(20),
                child: ConditionalBuilder(
                  condition: state is! UserInformationLoadingState,
                  builder: (context) {
                    return Column(
                      children: [
                        defaultFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          validate: (value) {},
                          isClickable: false,
                          label: "الأسم",
                          prefix: Icons.person,
                        ),
                        const SizedBox(height: 15),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (value) {},
                          isClickable: false,
                          label: "البريد الألكتروني",
                          prefix: Icons.email,
                        ),
                        const SizedBox(height: 15),
                        defaultFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          validate: (value) {},
                          isClickable: false,
                          label: "رقم الهاتف",
                          prefix: Icons.phone,
                        ),
                        const SizedBox(height: 15),
                        defaultFormField(
                          controller: numberController,
                          type: TextInputType.number,
                          validate: (value) {},
                          isClickable: false,
                          label: "الرقم القومي",
                          prefix: Icons.pin,
                        ),
                      ],
                    );
                  },
                  fallback: (context) {
                    return const LinearProgressIndicator();
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

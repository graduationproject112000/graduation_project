import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../shared/styles/colors.dart';
import '../../../shared/widgets/widgets.dart';

class ForgetPasswordLayout extends StatelessWidget {
  ForgetPasswordLayout({Key? key}) : super(key: key);

  var emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: mainColor.withOpacity(0.1),
            statusBarIconBrightness: Brightness.light,
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    secondaryColor,
                    mainColor.withOpacity(0.6),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/forget_password.png',
                    height: 150,
                    width: double.infinity,
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'قم بأدخال البريد الألكترني صحيح ليتم إرسال كلمة المرور إليك',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 20),
                  defaultFormField(
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    validate: (value) {},
                    label: 'البريد الإلكتروني',
                    prefix: Icons.email,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 130,
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      onPressed: () {},
                      child: const Text(
                        "إرسال",
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
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

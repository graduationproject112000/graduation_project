import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layouts/settings_layout/dart/settings_layout.dart';
import 'package:graduation_project/shared/widgets/widgets.dart';

import '../../../shared/styles/colors.dart';
import '../../../shared/styles/text_styles.dart';
import '../../service_form_layout/dart/service_form_layout.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';

class ServiceInformationLayout extends StatelessWidget {
  final title;
  final description;
  final unionName;
  final serviceId;
  final serviceCost;
  final String bankNumber;
  final String phone;

  const ServiceInformationLayout({
    Key? key,
    required this.title,
    required this.description,
    required this.unionName,
    required this.serviceId,
    required this.serviceCost,
    required this.bankNumber,
    required this.phone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ServiceInformationCubit()
        ..readServiceInformationFromJson(unionName, title),
      child: BlocConsumer<ServiceInformationCubit, ServiceInformationStates>(
        listener: (context, state) {
          if (state is CheckServicesSuccessState) {
            if (state.status == true) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ServiceFormLayout(
                    unionName: unionName,
                    title: title,
                    serviceId: serviceId,
                    isUpdate: false,
                  ),
                ),
              );
            } else if (state.status == false) {
              showDialog<void>(
                context: context,
                barrierDismissible: false, // user must tap button!
                builder: (BuildContext context) {
                  return state.message == "يرجى تأكيد البريد الألكترونى"
                      ? AlertDialog(
                          //title: const Text('AlertDialog Title'),
                          content: Text(
                            state.message,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                            textDirection: TextDirection.rtl,
                          ),
                          actions: <Widget>[
                            MaterialButton(
                              child: const Text('أوافق'),
                              color: secondaryColor,
                              textColor: Colors.white,
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SettingsLayout(),
                                  ),
                                );
                              },
                              minWidth: double.infinity,
                            ),
                          ],
                        )
                      : AlertDialog(
                          //title: const Text('AlertDialog Title'),
                          content: const Text(
                            "قد قمت بطلب هذه الخدمة من قبل يرجي إلغاء الطلب القديم.!",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w400),
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.center,
                          ),

                          actions: <Widget>[
                            MaterialButton(
                              child: const Text(
                                'إلغاء',
                              ),
                              color: Colors.red,
                              textColor: Colors.white,
                              minWidth: 140,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            MaterialButton(
                              child: const Text('حذف الطلب'),
                              color: secondaryColor,
                              textColor: Colors.white,
                              minWidth: 140,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                                ServiceInformationCubit.get(context)
                                    .deleteService(
                                  serviceId,
                                  () {
                                    ShowToast(text: 'تم حذف الطلب بنجاح');
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ServiceFormLayout(
                                          unionName: unionName,
                                          title: title,
                                          serviceId: serviceId,
                                          isUpdate: false,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        );
                },
              );
            }
          }
        },
        builder: (context, state) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  title,
                  style: headingStyle,
                ),
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
                    ),
                  ),
                ),
              ),
              body: ConditionalBuilder(
                condition:
                    state is! ServiceInformationLoadingServiceInformationState,
                fallback: (context) =>
                    const Center(child: CircularProgressIndicator()),
                builder: (context) => Container(
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Icon(
                              Icons.arrow_right,
                              size: 30,
                            ),
                            Text(
                              "وصف الخدمة",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 40),
                          child: Text(
                            "$description",
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black54),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          width: double.infinity,
                          height: 1,
                          color: Colors.grey[300],
                        ),
                        Row(
                          children: const [
                            Icon(
                              Icons.arrow_right,
                              size: 30,
                            ),
                            Text(
                              "متطلبات الخدمة",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        ListView.builder(
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 40.0),
                              child: Text(
                                "- ${ServiceInformationCubit.get(context).serviceInformation![index]} ",
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.black54),
                              ),
                            );
                          },
                          itemCount: ServiceInformationCubit.get(context)
                              .serviceInformation!
                              .length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          width: double.infinity,
                          height: 1,
                          color: Colors.grey[300],
                        ),
                        Row(
                          children: const [
                            Icon(
                              Icons.arrow_right,
                              size: 30,
                            ),
                            Text(
                              "الرسوم",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 40.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "- رسوم الخدمة : " + serviceCost,
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.black54),
                              ),
                              const Text(
                                "- يتم دفع الرسوم عن طريق تحويل المبلغ علي أحد الحسابات الاتية والإحتفاظ بصورة لوصل الدفع :",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black54),
                              ),
                              const SizedBox(height: 5),
                              Padding(
                                padding: const EdgeInsets.only(right: 40),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "- فودافون كاش : " + phone,
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.black54),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      "- رقم الحساب البنكي : " + bankNumber,
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.black54),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        Center(
                          child: MaterialButton(
                            onPressed: () {
                              print('serviceId' + serviceId);
                              ServiceInformationCubit.get(context)
                                  .checkServices(serviceId);
                            },
                            minWidth: 150,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: const Text(
                              "بدأ الخدمة ",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            color: const Color(0xff0B54A1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            highlightColor: secondaryColor,
                            splashColor: secondaryColor,
                          ),
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
      ),
    );
  }
}

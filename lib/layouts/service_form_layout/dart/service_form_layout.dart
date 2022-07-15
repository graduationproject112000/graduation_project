import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../shared/styles/colors.dart';
import '../../../shared/styles/text_styles.dart';
import '../../../shared/widgets/widgets.dart';
import '../../home_layout/dart/home_layout.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';

class ServiceFormLayout extends StatelessWidget {
  ServiceFormLayout({
    Key? key,
    required this.title,
    required this.unionName,
    required this.serviceId,
    required this.isUpdate,
  }) : super(key: key);
  final title;
  final unionName;
  final serviceId;
  final isUpdate;

  final picker = ImagePicker();

  var color = Colors.white;

  Future getImage(ImageSource src, context, index) async {
    final pickedFile = await picker.pickImage(source: src);
    if (pickedFile != null) {
      ServiceFormCubit.get(context).changeFile(pickedFile, index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ServiceFormCubit()
        ..readServiceInformationFromJson(isUpdate, unionName, title),
      child: BlocConsumer<ServiceFormCubit, ServiceFormStates>(
        listener: (context, state) {
          if (state is ServiceFormSuccessStartServiceState) {
            if (state.updateState) {
              ShowToast(
                text: ServiceFormCubit.get(context).startServiceMessage,
              );
              isUpdate
                  ? Navigator.pop(context)
                  : Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeLayout(2),
                      ),
                    );
            }else{
              ShowToast(
                text: ServiceFormCubit.get(context).startServiceMessage,
              );
            }
          }else if (state is ServiceFormErrorStartServiceState){
            ShowToast(
              text: ServiceFormCubit.get(context).startServiceMessage,
            );
          }
        },
        builder: (context, state) {
          var cubit = ServiceFormCubit.get(context);
          return WillPopScope(
            onWillPop: () => onWillPop(context),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                appBar: AppBar(
                  title: Text(
                    title,
                    style: headingStyle,
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
                      state is! ServiceFormLoadingServiceInformationState,
                  fallback: (context) =>
                      const Center(child: CircularProgressIndicator()),
                  builder: (context) => Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      width: double.infinity,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return serviceForm(
                                  hint: ServiceFormCubit.get(context)
                                      .texts[index],
                                  title: cubit.serviceInformation![index],
                                  error: cubit.texts[index] != 'أختار صورة' &&
                                          cubit.isStartButtonPressed == true
                                      ? ""
                                      : ServiceFormCubit.get(context)
                                              .isStartButtonPressed
                                          ? "يرجي رفع الصورة المطلوبة"
                                          : "",
                                  // error: cubit.texts[index] != 'أختار صورة' && cubit.isStartButtonPressed == true?"":ServiceFormCubit.get(context).isStartButtonPressed?'برجاء ادراج الصورة' +
                                  //     ServiceFormCubit.get(context)
                                  //         .serviceInformation![index]:"",
                                  color: ServiceFormCubit.get(context)
                                      .errorColors[index],
                                  function: () {
                                    getImage(
                                        ImageSource.gallery, context, index);
                                  },
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 10),
                              itemCount: cubit.serviceInformation!.length,
                            ),
                            const SizedBox(height: 30),
                            Center(
                              child: Container(
                                width: 200,
                                child: MaterialButton(
                                  onPressed: () {
                                    ServiceFormCubit.get(context)
                                        .changeIsStartButtonPressed();
                                    if (ServiceFormCubit.get(context)
                                        .texts
                                        .contains('أختار صورة')) {
                                      ShowToast(
                                          text:
                                              "يرجي رفع جميع الصورة المطلوبة");
                                      ServiceFormCubit.get(context)
                                          .changeErrorColor();
                                    } else {
                                      for (int i = 0;
                                          i <
                                              ServiceFormCubit.get(context)
                                                  .texts
                                                  .length;
                                          i++) {
                                        if (ServiceFormCubit.get(context)
                                            .texts[i]
                                            .contains('image_picker')) {
                                          ServiceFormCubit.get(context)
                                              .startService(
                                            serviceId,
                                            isUpdate
                                                ? 'services/update/'
                                                : 'services/store/',
                                          );
                                          break;
                                        } else if (i ==
                                            ServiceFormCubit.get(context)
                                                    .texts
                                                    .length -
                                                1) {
                                          ShowToast(
                                            text:
                                                "يرجي رفع صورة واحدة علي الاقل للتعديل",
                                          );
                                        }
                                      }
                                    }
                                  },
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: ConditionalBuilder(
                                    condition: state
                                        is ServiceFormLoadingStartServiceState,
                                    builder: (context) => const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                    fallback: (context) => const Text(
                                      "تسجيل",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    ),
                                  ),
                                  color: mainColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: const BorderSide(width: 1),
                                  ),
                                  highlightColor: secondaryColor,
                                  splashColor: secondaryColor,
                                ),
                              ),
                            ),
                            // if (images.isNotEmpty)
                            //   AssetThumb(
                            //     asset: images[0],
                            //     width: 100,
                            //     height: 100,
                            //   ),
                          ],
                        ),
                      ),
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

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layouts/service_information_layout/dart/service_information_layout.dart';

import '../../../layouts/home_layout/cubit/cubit.dart';
import '../../../layouts/home_layout/cubit/states.dart';
import '../../../shared/styles/colors.dart';

class ServicesScreen extends StatelessWidget {
  ServicesScreen({Key? key}) : super(key: key);

  late String title;
  late String description;
  late String unionName;
  late String serviceId;
  late String serviceCost;
  late String bankNumber;
  late String phone;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
            condition:
                HomeCubit.get(context).unionModel.data.services.isNotEmpty,
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.all(15),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Directionality(
                      textDirection: TextDirection.rtl,
                      child: GestureDetector(
                        onTap: () {
                          title = HomeCubit.get(context)
                              .unionModel
                              .data
                              .services[index]
                              .namear
                              .toString();
                          description = HomeCubit.get(context)
                              .unionModel
                              .data
                              .services[index]
                              .title
                              .toString();
                          unionName = HomeCubit.get(context)
                              .unionModel
                              .data
                              .name
                              .toString();
                          print(unionName);
                          serviceId = HomeCubit.get(context)
                              .unionModel
                              .data
                              .services[index]
                              .id
                              .toString();
                          serviceCost = HomeCubit.get(context)
                              .unionModel
                              .data
                              .serviceCost[index]
                              .serviceCost
                              .toString();
                          bankNumber = HomeCubit.get(context)
                              .unionModel
                              .data
                              .bank
                              .toString();
                          phone = HomeCubit.get(context)
                              .unionModel
                              .data
                              .phone
                              .toString();

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ServiceInformationLayout(
                                title: title,
                                phone: phone,
                                bankNumber: bankNumber,
                                description: description,
                                unionName: unionName,
                                serviceId: serviceId,
                                serviceCost: serviceCost,
                              ),
                            ),
                          );
                        },
                        child: Card(
                          shadowColor: secondaryColor,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              color: Colors.black54,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FadeInImage.assetNetwork(
                                  width: 150,
                                  height: 150,
                                  image: HomeCubit.get(context)
                                      .unionModel
                                      .data
                                      .services[index]
                                      .image
                                      .toString(),
                                  placeholder: 'assets/images/loading.gif',
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(width: 5),
                                    Text(
                                      HomeCubit.get(context)
                                          .unionModel
                                          .data
                                          .services[index]
                                          .namear
                                          .toString(),
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      HomeCubit.get(context)
                                          .unionModel
                                          .data
                                          .services[index]
                                          .title
                                          .toString(),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.right,
                                    )
                                  ],
                                )),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                  itemCount:
                      HomeCubit.get(context).unionModel.data.services.length,
                ),
              );
            },
            fallback: (context) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            });
      },
    );
  }
}

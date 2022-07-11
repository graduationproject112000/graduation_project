import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/shared/styles/colors.dart';

import '../../../layouts/home_layout/cubit/cubit.dart';
import '../../../layouts/home_layout/cubit/states.dart';
import '../../../layouts/service_information_layout/dart/service_information_layout.dart';
import '../../../shared/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  late String title;
  late String description;
  late String unionName;
  late String serviceId;
  late String serviceCost;
  late String bankNumber;
  late String phone;
  var sliderController = CarouselController();

  Widget buildIndicator(context, index) {
    return Container(
      width: 10,
      height: 10,
      margin: const EdgeInsets.symmetric(horizontal: 3),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: HomeCubit.get(context).sliderIndex == index
              ? secondaryColor
              : Colors.grey),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
            condition:
                HomeCubit.get(context).unionModel.data.services.isNotEmpty,
            builder: (context) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          const Text(
                            "اكثر الخدمات طلبا",
                            style: TextStyle(fontSize: 18),
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: () {
                              HomeCubit.get(context).changeBottomBar(1);
                            },
                            child: const Text(
                              "المزيد...",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 18, color: secondaryColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                    CarouselSlider.builder(
                      carouselController: sliderController,
                      itemCount: 4,
                      itemBuilder:
                          (BuildContext context, int index, int pageViewIndex) {
                        return SizedBox(
                          width: double.infinity,
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
                                  builder: (context) =>
                                      ServiceInformationLayout(
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
                            child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                FadeInImage.assetNetwork(
                                    image: HomeCubit.get(context)
                                        .unionModel
                                        .data
                                        .services[index]
                                        .image
                                        .toString(),
                                    fit: BoxFit.cover,
                                    placeholder: 'assets/images/loading.gif'),
                                Container(
                                  height: 50,
                                  width: double.infinity,
                                  color: Colors.black45,
                                  child: Center(
                                    child: Text(
                                      HomeCubit.get(context)
                                          .unionModel
                                          .data
                                          .services[index]
                                          .namear
                                          .toString(),
                                      style: const TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      options: CarouselOptions(
                        height: 150,
                        onPageChanged: (index, _) {
                          HomeCubit.get(context).sliderIndexChange(index);
                        },
                        autoPlay: true,
                        autoPlayAnimationDuration: const Duration(seconds: 1),
                        scrollDirection: Axis.horizontal,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        initialPage: 0,
                        autoPlayInterval: const Duration(seconds: 3),
                        viewportFraction: 1,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buildIndicator(context, 0),
                        buildIndicator(context, 1),
                        buildIndicator(context, 2),
                        buildIndicator(context, 3),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Text(
                        "أخبارنا",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    buildNewsItem(
                        HomeCubit.get(context).unionModel.data.information,
                        HomeCubit.get(context)
                            .unionModel
                            .data
                            .information
                            .length,
                        context),
                  ],
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

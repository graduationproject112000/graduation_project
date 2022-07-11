import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../layouts/home_layout/cubit/cubit.dart';
import '../../../layouts/home_layout/cubit/states.dart';
import '../../../layouts/service_form_layout/dart/service_form_layout.dart';
import '../../../shared/styles/colors.dart';
import '../../../shared/widgets/widgets.dart';

class OrdersScreen extends StatelessWidget {
  OrdersScreen({Key? key}) : super(key: key);

  final keyRefresh = GlobalKey<RefreshIndicatorState>();

  Future<void> _onRefresh(context) async {
    HomeCubit.get(context).getUserOrders();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is DeleteUserOrderSuccessUnionState) {
          ShowToast(
            text: state.deleteMessage,
          );
        }
      },
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return ConditionalBuilder(
            condition: state is! GetUserOrdersLoadingState,
            builder: (context) {
              return ConditionalBuilder(
                  condition: cubit.userOrder.data.isNotEmpty,
                  builder: (context) => Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Expanded(
                              child: RefreshIndicator(
                                key: keyRefresh,
                                backgroundColor: secondaryColor,
                                color: Colors.white,
                                onRefresh: () => _onRefresh(context),
                                child: ListView.separated(
                                  itemBuilder: (context, index) {
                                    return Dismissible(
                                      key: UniqueKey(),
                                      confirmDismiss: (direction) async {
                                        return await showDialog(
                                          context: context,
                                          barrierDismissible:
                                              false, // user must tap button!
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              content: SingleChildScrollView(
                                                child: Text(
                                                  direction ==
                                                          DismissDirection
                                                              .endToStart
                                                      ? 'هل انت متأكد أنك تريد حذف هذه الخدمة؟'
                                                      : "هل انت متأكد أنك تريد تعديل هذه الخدمة؟",
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              actions: <Widget>[
                                                MaterialButton(
                                                  child: const Text('إلغاء'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  color: Colors.red,
                                                  textColor: Colors.white,
                                                  minWidth: 140,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                ),
                                                MaterialButton(
                                                  child: const Text('نعم'),
                                                  onPressed: () {
                                                    if (direction ==
                                                        DismissDirection
                                                            .endToStart) {
                                                      cubit.deleteUserOrder(
                                                          cubit
                                                              .userOrder
                                                              .data[index]
                                                              .pivot!
                                                              .serviceId
                                                              .toString());
                                                      Navigator.of(context)
                                                          .pop();
                                                    } else {
                                                      Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              ServiceFormLayout(
                                                            unionName: cubit
                                                                .unionModel
                                                                .data
                                                                .name
                                                                .toString(),
                                                            title: cubit
                                                                .userOrder
                                                                .data[index]
                                                                .namear,
                                                            serviceId: cubit
                                                                .userOrder
                                                                .data[index]
                                                                .pivot!
                                                                .serviceId
                                                                .toString(),
                                                            isUpdate: true,
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                  },
                                                  color: secondaryColor,
                                                  textColor: Colors.white,
                                                  minWidth: 140,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      background: Container(
                                        padding: const EdgeInsets.all(10),
                                        margin: EdgeInsets.only(
                                          right: 10,
                                          bottom: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              (15 / 812.0),
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              (8 / 812.0),
                                        ),
                                        decoration: BoxDecoration(
                                          color: secondaryColor,
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        alignment: Alignment.centerRight,
                                        child: const Padding(
                                          padding: EdgeInsets.only(right: 15),
                                          child: Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      secondaryBackground: Container(
                                        margin: EdgeInsets.only(
                                          left: 10,
                                          bottom: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              (15 / 812.0),
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              (8 / 812.0),
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        alignment: Alignment.centerLeft,
                                        child: const Padding(
                                          padding: EdgeInsets.only(left: 15),
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      child:
                                          AnimationConfiguration.staggeredList(
                                        position: index,
                                        duration:
                                            const Duration(milliseconds: 1375),
                                        child: SlideAnimation(
                                          horizontalOffset: 300,
                                          child: FadeInAnimation(
                                            child: Container(
                                              // padding: EdgeInsets.symmetric(
                                              //   horizontal: MediaQuery.of(context).size.width *
                                              //       (MediaQuery.of(context).orientation ==
                                              //               Orientation.landscape
                                              //           ? 4
                                              //           : 10 / 375.0),
                                              // ),
                                              width: MediaQuery.of(context)
                                                          .orientation ==
                                                      Orientation.landscape
                                                  ? MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2
                                                  : MediaQuery.of(context)
                                                      .size
                                                      .width,
                                              margin: EdgeInsets.only(
                                                  bottom: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      (12 / 812.0)),
                                              child: Card(
                                                elevation: 10,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                ),
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16),
                                                      color: Colors.white),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child:
                                                            SingleChildScrollView(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Row(
                                                                textBaseline:
                                                                    TextBaseline
                                                                        .alphabetic,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  const Icon(
                                                                    Icons
                                                                        .arrow_right,
                                                                    size: 30,
                                                                  ),
                                                                  Expanded(
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          top:
                                                                              4),
                                                                      child:
                                                                          Text(
                                                                        cubit
                                                                            .userOrder
                                                                            .data[index]
                                                                            .namear
                                                                            .toString(),
                                                                        maxLines:
                                                                            2,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              16,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          color:
                                                                              Colors.black,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                height: 5,
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            15),
                                                                child: Row(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .access_time_rounded,
                                                                      color: Colors
                                                                              .grey[
                                                                          500],
                                                                      size: 18,
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 12,
                                                                    ),
                                                                    Text(
                                                                      DateFormat.yMMMd().format(DateTime.parse(cubit
                                                                          .userOrder
                                                                          .data[
                                                                              index]
                                                                          .pivot!
                                                                          .createdAt
                                                                          .toString())),
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            13,
                                                                        color: Colors
                                                                            .grey[500],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 12,
                                                              ),
                                                              const Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        right:
                                                                            15),
                                                                child: Text(
                                                                  'ملاحظات الطلب :',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        13,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            20),
                                                                child: Text(
                                                                  cubit
                                                                      .userOrder
                                                                      .data[
                                                                          index]
                                                                      .pivot!
                                                                      .message
                                                                      .toString(),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        13,
                                                                    color: Colors
                                                                            .grey[
                                                                        500],
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        margin: const EdgeInsets
                                                                .symmetric(
                                                            horizontal: 10),
                                                        height: 85,
                                                        width: 0.7,
                                                        color: Colors.grey[600],
                                                      ),
                                                      RotatedBox(
                                                        quarterTurns: 3,
                                                        child: Text(
                                                          cubit
                                                                      .userOrder
                                                                      .data[
                                                                          index]
                                                                      .pivot!
                                                                      .status
                                                                      .toString() ==
                                                                  "جاري مراجعة البيانات"
                                                              ? 'تحت المراجعة'
                                                              : cubit
                                                                  .userOrder
                                                                  .data[index]
                                                                  .pivot!
                                                                  .status
                                                                  .toString(),
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
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
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(height: 0);
                                  },
                                  itemCount: cubit.userOrder.data.length,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  fallback: (context) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/images/empty_order.svg',
                              width: 200,
                              height: 200,
                              fit: BoxFit.fill,
                              color: Colors.grey[400],
                            ),
                            const SizedBox(height: 15),
                            const Text(
                              'لا يوجد طلب حتي الأن !',
                              style: TextStyle(
                                  fontSize: 20, color: Colors.black87),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            },
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()));
      },
    );
  }
}

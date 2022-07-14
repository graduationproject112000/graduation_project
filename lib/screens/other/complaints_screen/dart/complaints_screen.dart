import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layouts/register_layout/dart/register_layout.dart';
import 'package:graduation_project/screens/other/complaints_screen/cubit/cubit.dart';
import 'package:graduation_project/screens/other/complaints_screen/cubit/states.dart';

import '../../../../models/problems_model.dart';

class ComplaintsScreen extends StatefulWidget {
  @override
  State<ComplaintsScreen> createState() => _ComplaintsScreenState();
}

class _ComplaintsScreenState extends State<ComplaintsScreen> {
  String? dropdownValue;

  // List of items in our dropdown menu
  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProblemCubit()..getUnionsNames(),
      child: BlocConsumer<ProblemCubit, ProblemStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              appBar: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.white,
                  systemOverlayStyle: const SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    statusBarIconBrightness: Brightness.dark,
                  ),
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    color: Colors.black87,
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterLayout()),
                        (route) => false, // الغي الصفحة الي قبلي
                      );
                    },
                  )),
              backgroundColor: Colors.white,
              body: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Image.asset(
                      "assets/images/problem.png",
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "عند وجود مشكلة في بيانات إنشاء الحساب يرجي التواصل مع النقابة.!",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, color: Colors.black87),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    width: 200,
                    decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.black87),
                        borderRadius: BorderRadius.circular(10)),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                          hint: Text(
                            'أختر النقابة...',
                            style: TextStyle(
                                fontSize: 18, color: Colors.grey[500]),
                          ),
                          value: ProblemCubit.get(context).newValue,
                          isExpanded: true,
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black87,
                          ),
                          items: ProblemCubit.get(context)
                              .problemsModel
                              .data
                              .map((items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Text(
                                  items.name.toString(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            ProblemCubit.get(context).changeValue(newValue);
                            newValue as Data;
                            ProblemCubit.get(context)
                                .getUnionsPhones(newValue.id);
                            print(newValue.id);
                          }),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "رقم الشكاوي الخاص بالنقابة",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, color: Colors.black87),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    padding: const EdgeInsets.all(10),
                    width: 350,
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.black87),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        const Text(
                          "اطلب هذا الرقم :",
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        Text(
                          " " + ProblemCubit.get(context).phone,
                          style: const TextStyle(
                              fontSize: 18, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

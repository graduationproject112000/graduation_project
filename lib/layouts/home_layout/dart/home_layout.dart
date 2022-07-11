import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:graduation_project/layouts/home_layout/cubit/cubit.dart';
import 'package:graduation_project/layouts/home_layout/cubit/states.dart';

import '../../../shared/styles/colors.dart';
import '../../../shared/styles/text_styles.dart';
import '../../../shared/widgets/widgets.dart';

class HomeLayout extends StatelessWidget {
  int index = 0;

  HomeLayout(index) {
    this.index = index;
  }

  Widget noInternetWidget() {
    return Center(
      child: Container(
        color: mainColor,
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              "يرجي التحقق من الإتصال بالإنترنت",
              style: TextStyle(fontSize: 22),
            ),
            Image.asset('assets/images/no_internet.gif')
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()
        ..getUserOrders()
        ..getUnionServices()
        ..changeBottomBar(index),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                elevation: 0,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: mainColor.withOpacity(0.1),
                  statusBarIconBrightness: Brightness.light,
                ),
                flexibleSpace: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF1E88E5),
                        //secondaryColor,
                        mainColor,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
                title: Text(
                  cubit.screenTitles[cubit.currentIndex],
                  style: headingStyle,
                ),
                centerTitle: true,
              ),
              body: OfflineBuilder(
                connectivityBuilder: (
                  BuildContext context,
                  ConnectivityResult connectivity,
                  Widget child,
                ) {
                  final bool connected =
                      connectivity != ConnectivityResult.none;
                  if (connected) {
                    return cubit.screens[cubit.currentIndex];
                  } else {
                    return noInternetWidget();
                  }
                },
                child: const Center(
                  child: CircularProgressIndicator(
                    color: mainColor,
                  ),
                ),
              ),

              //cubit.screens[cubit.currentIndex],
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: "الرئيسية",
                      tooltip: "الرئيسية"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.apps_outlined),
                      label: "خدماتي",
                      tooltip: "خدماتي"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.local_grocery_store_outlined),
                      label: "طلباتي",
                      tooltip: "طلباتي"),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.newspaper,
                      ),
                      label: "الأخبار",
                      tooltip: "الأخبار"),
                ],
                unselectedItemColor: Colors.grey,
                // iconSize: 20,
                // unselectedFontSize: 5,
                backgroundColor: Colors.white,
                selectedItemColor: secondaryColor,
                currentIndex: cubit.currentIndex,
                elevation: 20,
                onTap: (index) {
                  cubit.changeBottomBar(index);
                  if (index == 2) {
                    cubit.getUserOrders();
                  }
                },
              ),
              drawer: myDrawer(context),
              //drawer: cubit.currentIndex == 2 ? myDrawer(context) : null,
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:graduation_project/layouts/home_layout/cubit/cubit.dart';
import 'package:graduation_project/layouts/home_layout/cubit/states.dart';
import 'package:graduation_project/layouts/login_layout/dart/login_layout.dart';
import 'package:graduation_project/layouts/settings_layout/dart/settings_layout.dart';

import '../../layouts/news_details_layout/news_details_layout.dart';
import '../../models/union_model.dart';
import '../constants.dart';
import '../networks/local/cache_helper.dart';
import '../styles/colors.dart';
import '../styles/text_styles.dart';

Widget inputField({
  required String hint,
  required String title,
  required TextEditingController controller,
  required TextInputType inputType,
  Icon? prefixIcon,
  IconButton? suffixIcon,
  bool isPassword = false,
}) {
  return Directionality(
    textDirection: TextDirection.rtl,
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            height: 52,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                width: 1,
                color: Colors.black45,
              ),
            ),
            child: TextFormField(
              controller: controller,
              autofocus: false,
              textAlign: TextAlign.start,
              cursorColor: Colors.grey[700],
              keyboardType: inputType,
              obscureText: isPassword,
              textDirection: TextDirection.rtl,
              decoration: InputDecoration(
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                prefixIcon: prefixIcon,
                suffixIcon: suffixIcon,
                hintTextDirection: TextDirection.rtl,
                hintText: hint,
                hintStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget serviceFormField(
        {required TextEditingController controller,
        onTap,
        required validate,
        required String title,
        required String error}) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          textAlign: TextAlign.start,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        const SizedBox(height: 10),
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: controller,
                onTap: onTap,
                readOnly: true,
                validator: validate,
                decoration: const InputDecoration(
                  hintText: "أدخل صورة",
                  hintStyle: TextStyle(fontSize: 18),
                  suffixIcon: Icon(
                    Icons.add_a_photo_outlined,
                    size: 40,
                    color: Colors.black45,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1),
                  ),
                ),
              ),
              if (error.isNotEmpty)
                Row(
                  children: [
                    const Icon(
                      Icons.error,
                      color: Colors.red,
                      size: 15,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      error.toString(),
                      style: const TextStyle(color: Colors.red),
                    ),
                  ],
                )
            ],
          ),
        ),
      ],
    );

Widget defaultFormField(
        {required TextEditingController controller,
        required TextInputType type,
        onSubmit,
        onChange,
        bool isRead = false,
        onTap,
        bool isPassword = false,
        required validate,
        required String label,
        required IconData prefix,
        IconData? suffix,
        suffixPressed,
        bool isClickable = true,
        error = ''}) =>
    Container(
        child: Column(
      children: [
        TextFormField(
          controller: controller,
          keyboardType: type,
          obscureText: isPassword,
          enabled: isClickable,
          onFieldSubmitted: onSubmit,
          onChanged: onChange,
          onTap: onTap,
          readOnly: isRead,
          validator: validate,
          decoration: InputDecoration(
            labelText: label,
            prefixIcon: Icon(
              prefix,
            ),
            suffixIcon: suffix != null
                ? IconButton(
                    onPressed: suffixPressed,
                    icon: Icon(
                      suffix,
                    ),
                  )
                : null,
            border: const OutlineInputBorder(),
          ),
        ),
        if (error.isNotEmpty)
          Row(
            children: [
              const Icon(
                Icons.error,
                color: Colors.red,
                size: 15,
              ),
              const SizedBox(width: 5),
              Text(
                error.toString(),
                style: const TextStyle(color: Colors.red),
              ),
            ],
          )
      ],
    ));
//
Widget myDrawer(context) {
  return BlocConsumer<HomeCubit, HomeStates>(
    listener: (context, state) {},
    builder: (context, state) {
      var cubit = HomeCubit.get(context);
      return Drawer(
        child: Column(children: [
          Container(
            width: double.infinity,
            height: 220,
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                // ClipRRect(
                //   borderRadius: BorderRadius.circular(100),
                //   child: Image.asset(
                //     "assets/images/profile.gif",
                //     height: 100,
                //     width: 100,
                //   ),
                // ),
                const CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.red,
                  backgroundImage: AssetImage('assets/images/profile.gif'),
                ),
                const SizedBox(height: 10),
                state is UserInformationLoadingState
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 4,
                        ),
                      )
                    : Text(
                        HomeCubit.get(context)
                            .userInformation!
                            .data!
                            .name
                            .toString(),
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                      ),
              ],
            ),
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: ListTile(
              selected: HomeCubit.get(context).currentIndex == 0 ? true : false,
              title: const Text(
                "الصفحة الرئيسية",
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                cubit.changeBottomBar(1);
                Navigator.pop(context);
              },
              trailing: const Icon(
                Icons.home,
                color: secondaryColor,
              ),
            ),
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: ListTile(
              selected: HomeCubit.get(context).currentIndex == 1 ? true : false,
              title: const Text(
                "خدماتي",
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                cubit.changeBottomBar(1);
                Navigator.pop(context);
              },
              trailing: const Icon(
                Icons.apps_outlined,
                color: secondaryColor,
              ),
            ),
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: ListTile(
              selected: HomeCubit.get(context).currentIndex == 2 ? true : false,
              title: const Text(
                "طلباتي",
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                cubit.changeBottomBar(2);
                Navigator.pop(context);
              },
              trailing: const Icon(
                Icons.local_grocery_store_outlined,
                color: secondaryColor,
              ),
            ),
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: ListTile(
              selected: HomeCubit.get(context).currentIndex == 3 ? true : false,
              title: const Text(
                "الأخبار",
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                cubit.changeBottomBar(3);
                Navigator.pop(context);
              },
              trailing: const Icon(
                Icons.newspaper,
                color: secondaryColor,
              ),
            ),
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: ListTile(
              title: const Text(
                "الأعدادات",
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SettingsLayout()));
              },
              trailing: const Icon(
                Icons.settings,
                color: secondaryColor,
              ),
            ),
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: ListTile(
              title: const Text(
                "تسجيل الخروج",
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                CacheHelper.removeData(key: 'unionId');
                CacheHelper.removeData(key: 'token');
                unionId = null;
                token = null;
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginLayout()),
                  (route) => false, // الغي الصفحة الي قبلي
                );
              },
              trailing: const Icon(
                Icons.logout,
                color: secondaryColor,
              ),
            ),
          ),
        ]),
      );
    },
  );
}

Widget serviceForm({
  required Function() function,
  required String title,
  required String hint,
  required String error,
  required color,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        textAlign: TextAlign.start,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      const SizedBox(height: 10),
      GestureDetector(
        onTap: function,
        child: Container(
          padding: const EdgeInsets.all(5),
          height: 57,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.black,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 5),
              Expanded(
                child: Text(hint,
                    style: const TextStyle(fontSize: 18),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
              ),
              const SizedBox(width: 15),
              const Icon(
                Icons.add_a_photo,
                size: 25,
                color: Colors.black54,
              ),
              const SizedBox(width: 8),
            ],
          ),
        ),
      ),
      if (error.isNotEmpty)
        Row(
          children: [
            const Icon(
              Icons.error,
              color: Colors.red,
              size: 15,
            ),
            const SizedBox(width: 5),
            Text(
              error.toString(),
              style: const TextStyle(color: Colors.red),
            ),
          ],
        ),
      // Text(
      //   error,
      //   style: TextStyle(color: color),
      // ),
    ],
  );
}

Widget buildServicesInfo(List? data) {
  return Column(
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
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      const SizedBox(height: 10),
      Padding(
        padding: const EdgeInsets.only(right: 20),
        child: Text(
          data![1],
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
      Container(
        margin: const EdgeInsets.symmetric(vertical: 15),
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
            "متطلبات  الخدمة",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      const SizedBox(height: 10),
      ListView.builder(
        itemCount: data.length - 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Text(
              "-  " + data[index + 2],
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          );
        },
      ),
      Container(
        margin: const EdgeInsets.symmetric(vertical: 15),
        height: 1,
        color: Colors.grey[300],
      ),
    ],
  );
}

Widget buildSettingItem(
    {required String title,
    required IconData icon,
    required Function() function}) {
  return ListTile(
    onTap: function,
    title: Text(
      title,
      style: titleStyle,
    ),
    leading: Icon(
      icon,
      color: secondaryColor,
    ),
  );
}

void ShowToast({
  required String text,
}) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: Colors.grey[200],
      textColor: Colors.black,
      fontSize: 16.0);
}

Future<bool> onWillPop(context) async {
  final shouldPop = await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text(
        'هل انت متأكد أنك تريد إنهاء الخدمة ؟',
        style: TextStyle(fontSize: 15),
      ),
      //content: Text('Do you want to leave without saving?'),
      actions: <Widget>[
        MaterialButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Text('لا'),
          textColor: Colors.white,
          minWidth: 140,
          color: Colors.red,
        ),
        MaterialButton(
          onPressed: () {
            //ServicesFormCubit.get(context).deleteVariable();
            Navigator.of(context).pop(true);
          },
          child: const Text('نعم'),
          color: secondaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          textColor: Colors.white,
          minWidth: 140,
        ),
      ],
    ),
  );

  return shouldPop ?? false;
}

Widget buildNewsItem(List<Information> news, index, context) {
  return ListView.separated(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemBuilder: (ctx, index) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (ctx) {
                return NewsDetailsLayout(
                  image: news[index].img.toString(),
                  title: news[index].header.toString(),
                  date: news[index].createdAt.toString(),
                  description: news[index].titel.toString(),
                );
              }),
            );
          },
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          news[index].header.toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          news[index].titel.toString(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(
                              Icons.access_time_rounded,
                              size: 18,
                              color: Colors.grey[600],
                            ),
                            const SizedBox(width: 5),
                            Text(
                              news[index].createdAt.toString(),
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: FadeInImage.assetNetwork(
                      image: news[index].img.toString(),
                      height: 100,
                      width: 120,
                      fit: BoxFit.cover,
                      placeholder: 'assets/images/loading.gif',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
    itemCount: index,
    separatorBuilder: (BuildContext context, int index) {
      return Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Divider(
          color: Colors.grey[700],
        ),
      );
    },
  );
}

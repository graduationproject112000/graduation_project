import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graduation_project/layouts/register_layout/dart/register_layout.dart';

class ComplaintsScreen extends StatefulWidget {
  ComplaintsScreen({Key? key}) : super(key: key);

  @override
  State<ComplaintsScreen> createState() => _ComplaintsScreenState();
}

class _ComplaintsScreenState extends State<ComplaintsScreen> {
  String selected = 'aaaa';

  String? dropdownvalue;

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
                  MaterialPageRoute(builder: (context) => RegisterLayout()),
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
                    style: TextStyle(fontSize: 18, color: Colors.grey[500]),
                  ),

                  value: dropdownvalue,
                  isExpanded: true,
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black87,
                  ),

                  // Array list of items
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(
                        items,
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                    );
                  }).toList(),

                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownvalue = newValue!;
                    });
                  },
                ),
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
                children: const [
                  Text(
                    "اطلب هذا الرقم :",
                    style: TextStyle(fontSize: 18, color: Colors.black54),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

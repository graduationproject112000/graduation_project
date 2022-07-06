import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../shared/styles/colors.dart';

class NewsDetailsLayout extends StatelessWidget {
  final String image;
  final String date;
  final String title;
  final String description;

  const NewsDetailsLayout(
      {Key? key,
      required this.image,
      required this.date,
      required this.title,
      required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            "تفاصيل الخبر",
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
            )),
          ),
        ),
        body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Image.network(
              image,
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            Row(
              textBaseline: TextBaseline.alphabetic,
              children: [
                const Icon(
                  Icons.arrow_left,
                  size: 30,
                ),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Text(
                description,
                textAlign: TextAlign.start,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              textBaseline: TextBaseline.alphabetic,
              children: const [
                Icon(
                  Icons.arrow_left,
                  size: 30,
                ),
                Text(
                  "تاريخ النشر",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.access_time_rounded,
                    size: 18,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: 5),
                  Text(
                    date,
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

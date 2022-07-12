import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graduation_project/layouts/login_layout/dart/login_layout.dart';
import 'package:graduation_project/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({required this.image, required this.title, required this.body});
}

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();
  bool isLast = false;

  List<BoardingModel> boarding = [
    BoardingModel(
        image: 'assets/images/onboard2.png',
        title: 'خدماتك النقابية من مكان واحد',
        body:
            'هذا الموقع صُمم لكي يساعد الأعضاء على إتمام الخدمات النقابية أونلاين وبسهولة'),
    BoardingModel(
        image: 'assets/images/onboard1.png',
        title: 'وفر وقتك و استفد من خدمات الموقع فى دقائق معدودة',
        body: ''),
    BoardingModel(
        image: 'assets/images/onboard3.png',
        title:
            'التطبيق يُتيج للاعضاء تنفيذ الخدمات النقابية اونلاين لتوفير الوقت والجهد على جميع اعضاء النقابات',
        body: ''),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginLayout()));
            },
            child: const Text(
              ".. تخطي",
              style: TextStyle(
                  color: mainColor, fontSize: 15, fontWeight: FontWeight.w800),
            ),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: boardController,
                onPageChanged: (index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    buildOnBoardItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            const SizedBox(height: 40),
            Row(
              children: <Widget>[
                SmoothPageIndicator(
                  controller: boardController,
                  count: boarding.length,
                  effect: const ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: mainColor,
                    dotHeight: 10,
                    dotWidth: 10,
                    spacing: 5,
                    expansionFactor: 4,
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast == true) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginLayout()));
                    } else {
                      boardController.nextPage(
                          duration: const Duration(microseconds: 750),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  backgroundColor: mainColor,
                  child: Icon(Icons.arrow_forward_ios),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOnBoardItem(BoardingModel model) {
    return Column(
      children: [
        Expanded(
          child: Image(
            image: AssetImage(model.image),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          model.title,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24, color: mainColor),
        ),
        const SizedBox(height: 15),
        Text(
          model.body,
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

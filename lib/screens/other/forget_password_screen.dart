import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../shared/styles/colors.dart';


class ForgetPasswordScreen extends StatelessWidget {
  final String url;

  const ForgetPasswordScreen({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reset Password"),
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
      body: WebView(
        initialUrl: url,
      ),
    );
  }
}

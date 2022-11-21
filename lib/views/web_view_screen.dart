import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:toast/toast.dart';

import '../components/ad_widget.dart';

class WebScreen extends StatefulWidget {
  const WebScreen({Key? key}) : super(key: key);

  @override
  State<WebScreen> createState() => _WebScreenState();
}

class _WebScreenState extends State<WebScreen> {
  late WebViewController controller;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  double progress = 0;
  int progressPercent = 0;
  bool isNetworkAvailable = true;
  DateTime? lastPressed;
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  void showToast(String msg, {int? duration, int? gravity}) {
    Toast.show(msg, duration: duration, gravity: gravity);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () async {
              if (await controller.canGoBack()) {
                controller.goBack();
              }
            },
            icon: const Icon(Icons.arrow_back)),
        elevation: 0.0,
        backgroundColor: const Color(0xff40404F),
        title: const Text('Insidegist Blog'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                controller.reload();
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: WillPopScope(
        onWillPop: () async {
          final now = DateTime.now();
          const maxDuration = Duration(seconds: 2);
          final isWarning =
              lastPressed == null || now.difference(lastPressed!) > maxDuration;

          if (await controller.canGoBack()) {
            controller.goBack();
            return false;
          } else if (isWarning) {
            lastPressed = DateTime.now();
            // Toast.show('msg', gravity: Toast.bottom);
            showToast("Press Back button again to Exit", gravity: Toast.bottom);

            return false;
          } else {
            return true;
          }
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                Expanded(
                  child: Opacity(
                    opacity: progressPercent == 100 || progressPercent == 0
                        ? 1.0
                        : 0.0,
                    child: WebView(
                      javascriptMode: JavascriptMode.unrestricted,
                      //https://insidegistblog.com/
                      initialUrl: 'https://insidegistblog.com/',
                      onWebViewCreated: (controller) {
                        this.controller = controller;
                      },
                      gestureNavigationEnabled: true,
                      debuggingEnabled: true,
                      onProgress: (progress) {
                        setState(() {
                          this.progress = progress / 100;
                          progressPercent = progress;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            progressPercent != 100 && progressPercent != 0
                ? SizedBox(
                    height: 150,
                    width: 150,
                    child: LiquidLinearProgressIndicator(
                      value: progress, // Defaults to 0.5.
                      valueColor: const AlwaysStoppedAnimation(Color(
                          0xff40404F)), // Defaults to the current Theme's accentColor.
                      backgroundColor: const Color(
                          0xffffffff), // Defaults to the current Theme's backgroundColor.
                      borderColor: Colors.green,
                      borderWidth: 0.0,
                      borderRadius: 100.0,
                      direction: Axis
                          .vertical, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.horizontal.
                      center: Text(
                        "$progressPercent%",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 32,
                            color: progressPercent > 50
                                ? Colors.white
                                : Colors.black),
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:math' as math;
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late WebViewController controller;
  double progress = 0;
  int progressPercent = 0;
  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WillPopScope(
        onWillPop: () async {
          if (await controller.canGoBack()) {
            controller.goBack();
            return false;
          } else {
            return false;
          }
        },
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () async {
                  if (await controller.canGoBack()) {
                    controller.goBack();
                  }
                },
                icon: Icon(Icons.arrow_back)),
            elevation: 0.0,
            backgroundColor: Color(0xff333333),
            title: Text('Quantum Meta Health'),
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () {
                    controller.reload();
                  },
                  icon: Icon(Icons.refresh))
            ],
          ),
          body: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                children: [
                  // CircularProgressIndicator(
                  //   backgroundColor: Colors.black,
                  //   valueColor: AlwaysStoppedAnimation<Color>(
                  //     Colors.white, //<-- SEE HERE
                  //   ),
                  //   value: progress,
                  // ),
                  // LinearProgressIndicator(
                  //   value: progress,
                  //   color: Colors.red,
                  // ),
                  Expanded(
                    child: WebView(
                      javascriptMode: JavascriptMode.unrestricted,
                      initialUrl: 'https://quantummetahealth.com/',
                      onWebViewCreated: (controller) {
                        this.controller = controller;
                      },
                      onProgress: (progress) {
                        setState(() {
                          this.progress = progress / 100;
                          progressPercent = progress;
                        });
                      },
                    ),
                  ),
                ],
              ),
              // Center(
              //   child: Transform.rotate(
              //     angle: -math.pi / 6.0,
              //     child: Text(
              //       'Your App Will Look Like\n(At the upper right corner refresh and back button included.) ',
              //       style: TextStyle(fontSize: 20, color: Colors.red),
              //     ),
              //   ),
              // ),
              progressPercent != 100 && progressPercent != 0
                  ? SizedBox(
                      height: 150,
                      width: 150,
                      child: LiquidLinearProgressIndicator(
                        value: progress, // Defaults to 0.5.
                        valueColor: AlwaysStoppedAnimation(Colors
                            .pink), // Defaults to the current Theme's accentColor.
                        backgroundColor: Color(
                            0xff333333), // Defaults to the current Theme's backgroundColor.
                        borderColor: Colors.green,
                        borderWidth: 0.0,
                        borderRadius: 100.0,
                        direction: Axis
                            .vertical, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.horizontal.
                        center: Text(
                          "$progressPercent%",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 32),
                        ),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}

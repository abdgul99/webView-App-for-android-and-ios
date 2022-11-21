import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'views/web_view_screen.dart';

//Ios app id= ca-app-pub-7906307089596123~2929580041
//ca-app-pub-7906307089596123/6558081280 open app
//ca-app-pub-7906307089596123/7132796352 banner
//android app id= ca-app-pub-7906307089596123~1160654063
// ca-app-pub-7906307089596123/9020593099 open app ad
// ca-app-pub-7906307089596123/2838328124 banner ad
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Insidegist Blog',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WebScreen(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../services/admobe_banner.dart';

class ReusableAdsWidget extends StatelessWidget {
  const ReusableAdsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      child: AdWidget(
        key: UniqueKey(),
        ad: AdmobService.createBannerAd()..load(),
      ),
    );
  }
}

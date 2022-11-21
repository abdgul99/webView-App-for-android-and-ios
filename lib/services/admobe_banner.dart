import 'dart:io' show Platform;
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdmobService {
  static BannerAd? _bannerAd;
  static BannerAd? get bannerAd => _bannerAd;
  static String get bannerAdUnitId => Platform.isAndroid
      ? 'ca-app-pub-7906307089596123/2838328124'
      : 'ca-app-pub-7906307089596123/7132796352';

// 	ca-app-pub-3940256099942544/6300978111 test unit id
  static BannerAd createBannerAd() {
    BannerAd ad = BannerAd(
      adUnitId: bannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) => print('Ad loaded.'),
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('Ad failed to load: $error');
          ad.dispose();
        },
        onAdOpened: (Ad ad) => print('Ad opened.'),
        onAdClosed: (Ad ad) => ad.dispose(),
      ),
    );

    return ad;
  }

  void disposeAds() {
    print("disposeAds");
    if (_bannerAd != null) {
      _bannerAd?.dispose();
    }
  }
}

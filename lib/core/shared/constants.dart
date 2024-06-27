import 'package:tscore/core/shared/shared.dart';

const String appVersion = "1.0.1";

// Admob add Reward Unit Id

class AddMobConfig {
  static const String appId = "ca-app-pub-7083447738557720~2005171954";

  // reward ad unit id
  static final String adsRewardUnitIdProduction = Platform.isAndroid
      ? "ca-app-pub-7083447738557720/6928838339"
      : "ca-app-pub-3940256099942544/1712485313";
  static final String adsRewardUnitIdTest = Platform.isAndroid
      ? "ca-app-pub-3940256099942544/5224354917"
      : "ca-app-pub-3940256099942544/1712485313";

  // banner ad unit id
  static final String bannerAdUnitId = Platform.isAndroid
      ? "ca-app-pub-7083447738557720/3757605859"
      : "ca-app-pub-3940256099942544/1712485313";

  // banner test ad unit id
  static final String bannerAdUnitIdTest = Platform.isAndroid
      ? "ca-app-pub-3940256099942544/6300978111"
      : "ca-app-pub-3940256099942544/2934735716";

  // native ad unit id
  static final String nativeAdUnitId = Platform.isAndroid
      ? "ca-app-pub-7083447738557720/2311009850"
      : "ca-app-pub-3940256099942544/1712485313";

  // native test ad unit id
  static final String nativeAdUnitIdTest = Platform.isAndroid
      ? "ca-app-pub-3940256099942544/2247696110"
      : "ca-app-pub-3940256099942544/3986624511";

  final String bannerUnit = kReleaseMode ? bannerAdUnitId : bannerAdUnitIdTest;

  final String rewardUnit =
      kReleaseMode ? adsRewardUnitIdProduction : adsRewardUnitIdTest;

  // final String nativeUnit = kReleaseMode ? nativeAdUnitId : nativeAdUnitIdTest;
}

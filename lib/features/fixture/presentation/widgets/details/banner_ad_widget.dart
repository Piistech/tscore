import 'package:tscore/core/shared/shared.dart';

import '../../../../../core/shared/constants.dart';

class BannerAdWidget extends StatefulWidget {
  const BannerAdWidget({super.key});

  @override
  State<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  bool adIsLoaded = false;
  BannerAd banner() {
    BannerAd bannerAd = BannerAd(
      adUnitId: bannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(
        nonPersonalizedAds: true,
      ),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          adIsLoaded = true;
          if (kDebugMode) {
            print('Ad loaded.');
          }
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
          if (kDebugMode) {
            print('BannerAd failed to load: $error');
          }
        },
      ),
    );
    return bannerAd;
  }

  @override
  void initState() {
    super.initState();
    banner().load();
  }

  @override
  void dispose() {
    super.dispose();
    banner().dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: banner().size.height.toDouble(),
      width: double.infinity,
      child: adIsLoaded
          ? AdWidget(
              ad: banner(),
              key: UniqueKey(),
            )
          : const CircularProgressIndicator(),
    );
  }
}

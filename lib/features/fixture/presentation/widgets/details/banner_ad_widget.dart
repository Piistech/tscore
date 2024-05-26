import '../../../../../core/shared/shared.dart';

class BannerAdWidget extends StatefulWidget {
  const BannerAdWidget({super.key});

  @override
  State<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  bool adIsLoaded = false;
  late final BannerAd banner;

  void _loadBanner() {
    banner = BannerAd(
      adUnitId: bannerAdUnitId,
      size: AdSize.mediumRectangle,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          setState(() {
            adIsLoaded = true;
          });
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
    )..load();
  }

  @override
  void initState() {
    super.initState();
    _loadBanner();
  }

  @override
  void dispose() {
    super.dispose();
    banner.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: context.verticalMargin16),
      height: banner.size.height.toDouble(),
      width: double.infinity,
      child: adIsLoaded
          ? AdWidget(
              ad: banner,
              key: UniqueKey(),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}

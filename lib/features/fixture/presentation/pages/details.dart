import 'dart:developer';

import '../../../../core/shared/shared.dart';
import '../../../analysis/analysis.dart';
import '../../fixture.dart';
import '../widgets/details/result.dart';

class FixtureDetailsPage extends StatefulWidget {
  final String guid;
  static const String path = '/fixtures/:id';
  static const String name = 'FixtureDetailsPage';

  const FixtureDetailsPage({
    super.key,
    required this.guid,
  });

  @override
  State<FixtureDetailsPage> createState() => _FixtureDetailsPageState();
}

class _FixtureDetailsPageState extends State<FixtureDetailsPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadAd(context);
  }

  BannerAd? _bannerAd;
  bool _isLoaded = false;
  final String adUnitId = AddMobConfig().bannerUnit;
  AdSize size = AdSize.fullBanner;

  /// Loads a banner ad.
  Future<void> loadAd(BuildContext context) async {
    final AnchoredAdaptiveBannerAdSize? size =
        await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
            MediaQuery.of(context).size.width.truncate());

    if (size == null) {
      debugPrint('Unable to get height of anchored banner.');
      return;
    }
    _bannerAd = BannerAd(
      // TODO: replace these test ad units with your own ad unit.
      adUnitId: Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/6300978111'
          : 'ca-app-pub-3940256099942544/2934735716',
      size: size,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          print('$ad loaded: ${ad.responseInfo}');
          setState(() {
            // When the ad is loaded, get the ad size and use it to set
            // the height of the ad container.
            _bannerAd = ad as BannerAd;
            _isLoaded = true;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('Anchored adaptive banner failedToLoad: $error');
          ad.dispose();
        },
      ),
    );
    return _bannerAd!.load();
  }

  @override
  void dispose() {
    super.dispose();
    _bannerAd?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// get full path
    log("${GoRouterState.of(context).fullPath}");
    return Scaffold(
      appBar: AppBar(
        title: MatchTitleWidget(
          fixtureGuid: widget.guid,
        ),
        leading: BackButton(
          onPressed: () {
            context.pop();
          },
        ),
      ),
      bottomNavigationBar: (_bannerAd != null && _isLoaded)
          ? SizedBox(
              height: _bannerAd!.size.height.abs().h,
              width: _bannerAd!.size.width.abs().w,
              child: AdWidget(
                ad: _bannerAd!,
                key: const Key("ad_widget"),
              ),
            )
          : null,
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: context.horizontalMargin15,
          vertical: context.verticalMargin15,
        ),
        children: [
          AnalysisWidget(fixtureGuid: widget.guid),
          SizedBox(height: context.verticalMargin16),
          PredictionWidget(fixtureGuid: widget.guid),
          SizedBox(height: context.verticalMargin16),
          MatchResult(fixtureGuid: widget.guid),
        ],
      ),
    );
  }
}

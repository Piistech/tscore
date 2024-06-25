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
  final String adUnitId = AddMobConfig().bannerUnit;

  /// Loads a banner ad.
  Future<void> loadAd(BuildContext context) async {
    final AnchoredAdaptiveBannerAdSize? size =
        await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
            MediaQuery.of(context).size.width.truncate());
    _bannerAd = BannerAd(
      adUnitId: adUnitId,
      request: const AdRequest(),
      size: size ?? AdSize.fullBanner,
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          debugPrint('$ad loaded.');
          setState(() {});
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, err) {
          debugPrint('${ad.responseInfo} BannerAd failed to load: $err');
          // Dispose the ad here to free resources.
          ad.dispose();
        },
      ),
    )..load();
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
      bottomNavigationBar: (_bannerAd != null)
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

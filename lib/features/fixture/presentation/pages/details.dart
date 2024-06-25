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
  void initState() {
    super.initState();
    loadAd(context);
  }

  BannerAd? _bannerAd;
  final String adUnitId = AddMobConfig().bannerUnit;

  /// Loads a banner ad.
  void loadAd(BuildContext context) {
    _bannerAd = BannerAd(
      adUnitId: adUnitId,
      request: const AdRequest(),
      size: const AdSize(height: 100, width: 320),
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          debugPrint('$ad loaded.');
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
          SizedBox(height: context.verticalMargin16),
          if (_bannerAd != null)
            Align(
              alignment: Alignment.bottomCenter,
              child: SafeArea(
                child: SizedBox(
                  width: _bannerAd!.size.width.toDouble(),
                  height: _bannerAd!.size.height.toDouble(),
                  child: AdWidget(ad: _bannerAd!),
                ),
              ),
            )
        ],
      ),
    );
  }
}

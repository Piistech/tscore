import '../../../../core/shared/shared.dart';
import '../../fixture.dart';

class AdPage extends StatefulWidget {
  final String guid;
  static const String path = '/ad/:id';
  static const String name = 'AdPage';
  const AdPage({super.key, required this.guid});

  @override
  State<AdPage> createState() => _AdPageState();
}

class _AdPageState extends State<AdPage> {
  bool adIsLoaded = false;
  late RewardedAd? rewarded;
  void _loadBanner() {
    RewardedAd.load(
      adUnitId: adUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          setState(() {
            rewarded = ad;
          });
          ad.onUserEarnedRewardCallback = (ad, reward) {
            
          };
        },
        onAdFailedToLoad: (LoadAdError error) {
          setState(() {
            adIsLoaded = false;
          });
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadBanner();
  }

  @override
  void dispose() {
    super.dispose();
    rewarded!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return rewarded != null
        ? IconButton(
            onPressed: () {
              rewarded!.show(
                onUserEarnedReward: (ad, reward) {
                  setState(() {
                    adIsLoaded = true;
                  });
                  //Next page
                  context.pushNamed(
                    FixtureDetailsPage.name,
                    pathParameters: {
                      'id': widget.guid,
                    },
                  );
                },
              );
            },
            icon: const Icon(Icons.close))
        : Container();
  }
}

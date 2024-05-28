import 'package:flutter/cupertino.dart';

import '../../../../core/config/config.dart';
import '../../../../core/shared/shared.dart';
import '../../../fixture/fixture.dart';
import '../../../team/team.dart';
import 'team.dart';

class PredictionItemWidget extends StatefulWidget {
  final FixtureEntity fixture;
  const PredictionItemWidget({
    super.key,
    required this.fixture,
  });

  @override
  State<PredictionItemWidget> createState() => _PredictionItemWidgetState();
}

class _PredictionItemWidgetState extends State<PredictionItemWidget> {
  late bool isAddLoaded;
    @override
  void initState() {
    super.initState();
    isAddLoaded = false;
  }

  @override
  void dispose() {
    super.dispose();
    isAddLoaded = false;
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (_, state) {
        final theme = state.scheme;
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: context.horizontalMargin12,
            vertical: context.verticalMargin12,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(context.radius12),
            color: theme.backgroundSecondary,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Text(
                      "${widget.fixture.matchTitle},${widget.fixture.stadiumName}",
                      style: context.textStyle10Medium(color: theme.textPrimary).copyWith(height: 1.2),
                    ),
                  ),
                  Text(
                    widget.fixture.startTime,
                    style: context.textStyle10Medium(color: theme.textPrimary).copyWith(height: 1.2),
                  ),
                ],
              ),
              SizedBox(height: context.verticalMargin8),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BlocProvider(
                    create: (context) => sl<TeamBloc>()..add(FetchTeam(teamGuid: widget.fixture.homeTeamId)),
                    child: const TeamNameAndFlagWidget(
                      isEnd: false,
                    ),
                  ),
                  SizedBox(width: context.horizontalMargin12),
                  BlocProvider(
                    create: (context) => sl<TeamBloc>()..add(FetchTeam(teamGuid: widget.fixture.awayTeamId)),
                    child: const TeamNameAndFlagWidget(
                      isEnd: true,
                    ),
                  ),
                ],
              ),
              SizedBox(height: context.verticalMargin8),
              Align(
                alignment: Alignment.center,
                child: Text(
                  widget.fixture.startDate,
                  style: context.textStyle12Medium(color: Colors.blue),
                ),
              ),
              SizedBox(height: context.verticalMargin8),
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                      borderRadius: BorderRadius.circular(context.radius5),
                      onTap: () async {
                        setState(() {
                          isAddLoaded = true;
                        });
                        await RewardedAd.loadWithAdManagerAdRequest(
                          adUnitId: adUnitId,
                          adManagerRequest: const AdManagerAdRequest(),
                          rewardedAdLoadCallback: RewardedAdLoadCallback(
                            onAdLoaded: (RewardedAd ad) async {
                              await ad.show(
                                onUserEarnedReward: (view, reward) {
                                  context.pushNamed(
                                    FixtureDetailsPage.name,
                                    pathParameters: {
                                      'id': widget.fixture.guid,
                                    },
                                  );
                                },
                              );
                            },
                            onAdFailedToLoad: (LoadAdError error) {},
                          ),
                        );
                      },
                      child: isAddLoaded
                          ? Container(
                              width: 72.w,
                              height: 20.h,
                              padding: EdgeInsets.symmetric(
                                  horizontal: context.horizontalMargin8, vertical: context.verticalMargin4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(context.radius5),
                                color: theme.backgroundTertiary,
                              ),
                              child: const CupertinoActivityIndicator(),
                            )
                          : Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: context.horizontalMargin8, vertical: context.verticalMargin4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(context.radius5),
                                color: theme.backgroundTertiary,
                              ),
                              child: Text(
                                "Prediction",
                                style: context.textStyle10Medium(color: theme.textPrimary).copyWith(height: 1.2),
                              ),
                            ),
                    ),
                  ),
            ],
          ),
        );
      },
    );
  }
}

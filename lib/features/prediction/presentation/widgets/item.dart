import 'dart:developer';

import 'package:flutter/cupertino.dart';

import '../../../../core/config/config.dart';
import '../../../../core/shared/shared.dart';
import '../../../fixture/fixture.dart';
import '../../../lookup/lookup.dart';
import '../../../team/team.dart';
import 'team.dart';

enum AdsLoadStatus {
  initial,
  loading,
  loaded,
  failed,
}

class PredictionItemWidget extends StatefulWidget {
  final PredictionsEntity predictionModel;
  const PredictionItemWidget({
    super.key,
    required this.predictionModel,
  });

  @override
  State<PredictionItemWidget> createState() => _PredictionItemWidgetState();
}

class _PredictionItemWidgetState extends State<PredictionItemWidget> {
  AdsLoadStatus adsLoadStatus = AdsLoadStatus.initial;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    adsLoadStatus = AdsLoadStatus.initial;
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
                      widget.predictionModel.predictionMatchName,
                      style: context
                          .textStyle10Medium(color: theme.textPrimary)
                          .copyWith(height: 1.2),
                    ),
                  ),
                  Text(
                    widget.predictionModel.startTime,
                    style: context
                        .textStyle10Medium(color: theme.textPrimary)
                        .copyWith(height: 1.2),
                  ),
                ],
              ),
              SizedBox(height: context.verticalMargin8),
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: BlocProvider(
                      create: (context) => sl<TeamBloc>()
                        ..add(FetchTeam(
                            teamGuid: widget.predictionModel.homeTeamId)),
                      child: const TeamNameAndFlagWidget(
                        isEnd: false,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: SvgPicture.asset(
                      "images/icons/vs.svg",
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: BlocProvider(
                      create: (context) => sl<TeamBloc>()
                        ..add(FetchTeam(
                            teamGuid: widget.predictionModel.awayTeamId)),
                      child: const TeamNameAndFlagWidget(
                        isEnd: true,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: context.verticalMargin8),
              Align(
                alignment: Alignment.center,
                child: Text(
                  widget.predictionModel.startDate,
                  style: context.textStyle12Medium(color: Colors.blue),
                ),
              ),
              SizedBox(height: context.verticalMargin8),
              BlocBuilder<LookupBloc, LookupState>(
                builder: (context, state) {
                  if (state is LookupLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is LookupDone) {
                    /// Turning ```OFF``` ADS and navigate to page
                    // final adUnitId = state.lookups.firstOrNull;
                    ///----------------------------------------------
                    return Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(context.radius5),
                        onTap: () async {
                          if (state.lookups.first.dataValue.isEmpty) {
                            context.pushNamed(
                              FixtureDetailsPage.name,
                              pathParameters: {
                                'id': widget.predictionModel.guid,
                              },
                            );
                            setState(() {
                              adsLoadStatus = AdsLoadStatus.initial;
                            });
                          } else {
                            setState(() {
                              adsLoadStatus = AdsLoadStatus.loading;
                            });
                            await rewardAds(state);
                          }
                        },
                        child: adsLoadStatus == AdsLoadStatus.loading
                            ? Container(
                                width: 72.w,
                                height: 20.h,
                                padding: EdgeInsets.symmetric(
                                    horizontal: context.horizontalMargin8,
                                    vertical: context.verticalMargin4),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(context.radius5),
                                  color: theme.backgroundTertiary,
                                ),
                                child: const CupertinoActivityIndicator(),
                              )
                            : Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: context.horizontalMargin8,
                                    vertical: context.verticalMargin4),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(context.radius5),
                                  color: theme.backgroundTertiary,
                                ),
                                child: Text(
                                  "Prediction",
                                  style: context
                                      .textStyle10Medium(
                                          color: theme.textPrimary)
                                      .copyWith(height: 1.2),
                                ),
                              ),
                      ),
                    );
                  } else {
                    return Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(context.radius5),
                        onTap: () async {
                          context.pushNamed(
                            FixtureDetailsPage.name,
                            pathParameters: {
                              'id': widget.predictionModel.guid,
                            },
                          );
                        },
                        child: adsLoadStatus == AdsLoadStatus.loading
                            ? Container(
                                width: 72.w,
                                height: 20.h,
                                padding: EdgeInsets.symmetric(
                                    horizontal: context.horizontalMargin8,
                                    vertical: context.verticalMargin4),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(context.radius5),
                                  color: theme.backgroundTertiary,
                                ),
                                child: const CupertinoActivityIndicator(),
                              )
                            : Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: context.horizontalMargin8,
                                    vertical: context.verticalMargin4),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(context.radius5),
                                  color: theme.backgroundTertiary,
                                ),
                                child: Text(
                                  "Prediction",
                                  style: context
                                      .textStyle10Medium(
                                          color: theme.textPrimary)
                                      .copyWith(height: 1.2),
                                ),
                              ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> rewardAds(LookupDone state) async {
    final String rewardAddUnitID = state.lookups.first.dataValue;
    await RewardedAd.loadWithAdManagerAdRequest(
      adUnitId: kReleaseMode ? rewardAddUnitID : AddMobConfig().rewardUnit,
      adManagerRequest: const AdManagerAdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) async {
          log("ads checks loaded ${adsLoadStatus.name}");
          await ad.show(
            onUserEarnedReward: (view, reward) {
              context.pushNamed(
                FixtureDetailsPage.name,
                pathParameters: {
                  'id': widget.predictionModel.guid,
                },
              );
            },
          ).whenComplete(() {
            log("ads checks shown and completed ${adsLoadStatus.name}");
            setState(() {
              adsLoadStatus = AdsLoadStatus.loaded;
            });
          });
        },
        onAdFailedToLoad: (LoadAdError error) {
          setState(() {
            adsLoadStatus = AdsLoadStatus.failed;
          });
          context.pushNamed(
            FixtureDetailsPage.name,
            pathParameters: {
              'id': widget.predictionModel.guid,
            },
          );
        },
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';

import '../../../../../core/shared/shared.dart';
import '../../../../commentary/commentary.dart';
import '../../../domain/entities/fixtures.dart';
import '../../../fixture.dart';

class FixtureItemWidget extends StatefulWidget {
  final FixturesEntity fixture;
  const FixtureItemWidget({
    super.key,
    required this.fixture,
  });

  @override
  State<FixtureItemWidget> createState() => _FixtureItemWidgetState();
}

class _FixtureItemWidgetState extends State<FixtureItemWidget> {
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
        return InkWell(
          borderRadius: BorderRadius.circular(context.radius12),
          onTap: isAddLoaded
              ? null
              : () {
                  if (widget.fixture.isLive) {
                    context.pushNamed(
                      LivePage.name,
                      pathParameters: {'fixtureGuid': widget.fixture.guid},
                    );
                  } else if (widget.fixture.isUpcoming) {
                    TaskNotifier.instance.warning(context, message: "Match is not started yet!");
                  } else {
                    TaskNotifier.instance.success(context, message: "Match has been finished");
                  }
                },
          child: Container(
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
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(context.radius8),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: CachedNetworkImage(
                        imageUrl: widget.fixture.logo,
                        fit: BoxFit.cover,
                        width: 50.w,
                        height: 50.h,
                        placeholder: (context, url) => SizedBox(
                          width: 50.w,
                          height: 50.h,
                          child: ShimmerIcon(radius: context.radius8),
                        ),
                        errorWidget: (context, url, error) => SizedBox(
                          width: 50.w,
                          height: 50.h,
                          child: Image.asset('images/splash.png'),
                        ),
                      ),
                    ),
                    SizedBox(width: context.horizontalMargin8),
                    Expanded(
                      child: Text(
                        widget.fixture.matchTitle,
                        style: context.textStyle17Medium(color: theme.textPrimary).copyWith(height: 1.2),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: context.verticalMargin12),
                Text(
                  widget.fixture.matchDescription,
                  style: context.textStyle10Regular(color: theme.textPrimary).copyWith(height: 1.2),
                ),
                Visibility(visible: widget.fixture.isLive, child: SizedBox(height: context.verticalMargin16)),
                Visibility(
                  visible: widget.fixture.isLive,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BlocBuilder<CommentaryBloc, CommentaryState>(
                        builder: (context, state) {
                          if (state is CommentaryDone) {
                            final String channelId = state.commentary.channelId;
                            return BlocBuilder<CurrentlyPlayingCommentaryBloc, CurrentlyPlayingCommentaryState>(
                              builder: (context, state) {
                                final isPlaying = state is CurrentlyPlayingCommentaryChannel && state.channelId == channelId;
                                if (isPlaying) {
                                  return Lottie.asset(
                                    'animation/waveform.json',
                                    height: 24.h,
                                  );
                                }
                                return Row(
                                  children: [
                                    CircleAvatar(
                                      radius: context.radius12,
                                      backgroundColor: theme.white,
                                      child: Icon(
                                        Icons.play_arrow_rounded,
                                        color: theme.backgroundPrimary,
                                      ),
                                    ),
                                    SizedBox(width: context.horizontalMargin4),
                                    Text(
                                      "Play Now",
                                      style: context.textStyle12Medium(color: theme.textPrimary).copyWith(letterSpacing: -0.04),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                          return Row(
                            children: [
                              CircleAvatar(
                                radius: context.radius12,
                                backgroundColor: theme.white,
                                child: Icon(
                                  Icons.play_arrow_rounded,
                                  color: theme.backgroundPrimary,
                                ),
                              ),
                              SizedBox(width: context.horizontalMargin4),
                              Text(
                                "Play Now",
                                style: context.textStyle12Medium(color: theme.textPrimary).copyWith(letterSpacing: -0.04),
                              ),
                            ],
                          );
                        },
                      ),
                      Text(
                        widget.fixture.startDate,
                        style: context.textStyle10Regular(color: theme.textPrimary).copyWith(height: 1.2),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: context.verticalMargin16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: context.horizontalMargin8, vertical: context.verticalMargin4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(context.radius5),
                        color: widget.fixture.willLiveToday
                            ? theme.willLive
                            : widget.fixture.isLive
                                ? theme.negative
                                : widget.fixture.isUpcoming
                                    ? widget.fixture.isTomorrow
                                        ? theme.tomorrow
                                        : theme.warning
                                    : theme.positive,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Visibility(
                            visible: widget.fixture.isLive,
                            child: Icon(
                              Icons.circle,
                              size: 8.h,
                              color: theme.textPrimary,
                            )
                                .animate(
                                  onPlay: (controller) => controller.repeat(),
                                  onComplete: (controller) => controller.repeat(),
                                )
                                .fadeIn(duration: const Duration(milliseconds: 700)),
                          ),
                          SizedBox(width: context.verticalMargin5),
                          Text(
                            widget.fixture.willLiveToday
                                ? "Match yet to begin"
                                : widget.fixture.isLive
                                    ? "Live now"
                                    : widget.fixture.isUpcoming
                                        ? widget.fixture.isTomorrow
                                            ? "Tomorrow"
                                            : "Upcoming"
                                        : "Finished",
                            style: context
                                .textStyle10Regular(
                                  color: widget.fixture.willLiveToday
                                      ? theme.backgroundPrimary
                                      : widget.fixture.isLive
                                          ? theme.textPrimary
                                          : (widget.fixture.isUpcoming || widget.fixture.isTomorrow)
                                              ? theme.backgroundPrimary
                                              : theme.backgroundPrimary,
                                )
                                .copyWith(height: 1.2, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: widget.fixture.isPredictionAvailable,
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
              ],
            ),
          ),
        );
      },
    );
  }
}

import '../../../../../core/shared/shared.dart';
import '../../../../commentary/commentary.dart';
import '../../../domain/entities/fixtures.dart';

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
                    TaskNotifier.instance
                        .warning(context, message: "Match is not started yet!");
                  } else if (widget.fixture.willLiveToday) {
                    TaskNotifier.instance
                        .warning(context, message: "Match will start today!");
                  } else if (widget.fixture.isTomorrow) {
                    TaskNotifier.instance.warning(context,
                        message: "Match will start tomorrow!");
                  } else if (widget.fixture.isOnGoing) {
                    TaskNotifier.instance
                        .success(context, message: "Match on going!");
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
                        style: context
                            .textStyle17Medium(color: theme.textPrimary)
                            .copyWith(height: 1.2),
                      ),
                    ),
                  ],
                ),
                Visibility(
                    visible: widget.fixture.matchDescription.isNotEmpty,
                    child: SizedBox(height: context.verticalMargin12)),
                Visibility(
                  visible: widget.fixture.matchDescription.isNotEmpty,
                  child: Text(
                    widget.fixture.matchDescription,
                    style: context
                        .textStyle10Regular(color: theme.textPrimary)
                        .copyWith(height: 1.2),
                  ),
                ),
                SizedBox(height: context.verticalMargin16),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Visibility(
                      visible: widget.fixture.isLive,
                      child: BlocBuilder<CommentaryBloc, CommentaryState>(
                        builder: (context, state) {
                          if (state is CommentaryDone) {
                            final String channelId = state.commentary.channelId;
                            return BlocBuilder<CurrentlyPlayingCommentaryBloc,
                                CurrentlyPlayingCommentaryState>(
                              builder: (context, state) {
                                final isPlaying = state
                                        is CurrentlyPlayingCommentaryChannel &&
                                    state.channelId == channelId;
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
                                      style: context
                                          .textStyle12Medium(
                                              color: theme.textPrimary)
                                          .copyWith(letterSpacing: -0.04),
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
                                style: context
                                    .textStyle12Medium(color: theme.textPrimary)
                                    .copyWith(letterSpacing: -0.04),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
                Visibility(
                    visible: widget.fixture.isLive,
                    child: SizedBox(height: context.verticalMargin16)),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: context.horizontalMargin8,
                          vertical: context.verticalMargin4),
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
                                    : Colors.cyan,
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
                                  onComplete: (controller) =>
                                      controller.repeat(),
                                )
                                .fadeIn(
                                    duration:
                                        const Duration(milliseconds: 700)),
                          ),
                          SizedBox(width: context.verticalMargin5),
                          Text(
                            widget.fixture.willLiveToday
                                ? "Starting soon"
                                : widget.fixture.isLive
                                    ? "Live now"
                                    : widget.fixture.isUpcoming
                                        ? widget.fixture.isTomorrow
                                            ? "Tomorrow"
                                            : "Upcoming"
                                        : "On-Going",
                            style: context
                                .textStyle10Regular(
                                  color: widget.fixture.willLiveToday
                                      ? theme.backgroundPrimary
                                      : widget.fixture.isLive
                                          ? theme.textPrimary
                                          : (widget.fixture.isUpcoming ||
                                                  widget.fixture.isTomorrow)
                                              ? theme.backgroundPrimary
                                              : theme.backgroundPrimary,
                                )
                                .copyWith(
                                    height: 1.2, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: context.horizontalMargin8),
                    Container(
                      alignment: Alignment.center,
                      clipBehavior: Clip.antiAlias,
                      padding: EdgeInsets.symmetric(
                        horizontal: context.horizontalMargin4,
                        vertical: context.verticalMargin4,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(context.radius5),
                        color: theme.backgroundTertiary,
                      ),
                      child: Text(
                        widget.fixture.startDate,
                        style: context
                            .textStyle10Medium(color: theme.textPrimary)
                            .copyWith(fontSize: 12.sp, height: 1.2),
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

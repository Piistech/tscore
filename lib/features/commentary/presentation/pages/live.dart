import '../../../../core/shared/shared.dart';
import '../../../fixture/fixture.dart';
import '../../commentary.dart';

class LivePage extends StatefulWidget {
  static const String path = '/live/:fixtureGuid';
  static const String name = 'LivePage';
  const LivePage({super.key});

  @override
  State<LivePage> createState() => _LivePageState();
}

class _LivePageState extends State<LivePage> {
  NativeAd? _nativeAd;
  bool _nativeAdIsLoaded = false;

  final String _adUnitId = AddMobConfig().nativeUnit;

  @override
  void initState() {
    super.initState();
    loadAd();
  }

  @override
  void dispose() {
    _nativeAd?.dispose();
    super.dispose();
  }

  /// Loads a native ad.
  void loadAd() {
    _nativeAd = NativeAd(
        adUnitId: _adUnitId,
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            print('$NativeAd loaded.');
            setState(() {
              _nativeAdIsLoaded = true;
            });
          },
          onAdFailedToLoad: (ad, error) {
            // Dispose the ad here to free resources.
            print('${ad.responseInfo} failedToLoad: $error');
            ad.dispose();
          },
          // Called when a click is recorded for a NativeAd.
          onAdClicked: (ad) {},
          // Called when an impression occurs on the ad.
          onAdImpression: (ad) {},
          // Called when an ad removes an overlay that covers the screen.
          onAdClosed: (ad) {},
          // Called when an ad opens an overlay that covers the screen.
          onAdOpened: (ad) {},
          // For iOS only. Called before dismissing a full screen view
          onAdWillDismissScreen: (ad) {},
          // Called when an ad receives revenue value.
          onPaidEvent: (ad, valueMicros, precision, currencyCode) {},
        ),
        request: const AdRequest(),
        // Styling
        nativeTemplateStyle: NativeTemplateStyle(
            // Required: Choose a template.
            templateType: TemplateType.medium,
            // Optional: Customize the ad's style.
            mainBackgroundColor: Colors.purple,
            cornerRadius: 10.0,
            callToActionTextStyle: NativeTemplateTextStyle(
                textColor: Colors.cyan,
                backgroundColor: Colors.red,
                style: NativeTemplateFontStyle.monospace,
                size: 16.0),
            primaryTextStyle: NativeTemplateTextStyle(
                textColor: Colors.red,
                backgroundColor: Colors.cyan,
                style: NativeTemplateFontStyle.italic,
                size: 16.0),
            secondaryTextStyle: NativeTemplateTextStyle(
                textColor: Colors.green,
                backgroundColor: Colors.black,
                style: NativeTemplateFontStyle.bold,
                size: 16.0),
            tertiaryTextStyle: NativeTemplateTextStyle(
                textColor: Colors.brown,
                backgroundColor: Colors.amber,
                style: NativeTemplateFontStyle.normal,
                size: 16.0)))
      ..load();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final theme = state.scheme;
        return Scaffold(
          backgroundColor: theme.backgroundPrimary,
          appBar: AppBar(
            automaticallyImplyLeading: true,
            backgroundColor: theme.backgroundSecondary,
            iconTheme: IconThemeData(color: theme.textPrimary),
          ),
          body: BlocBuilder<FindFixtureByIdBloc, FindFixtureByIdState>(
            builder: (context, state) {
              if (state is FindFixtureByIdLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is FindFixtureByIdDone) {
                final fixture = state.fixture;

                return ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const ScrollPhysics(),
                  children: [
                    SizedBox(
                      height: 538.h,
                      child: Stack(
                        clipBehavior: Clip.antiAlias,
                        children: [
                          Positioned(
                            child: Stack(
                              children: [
                                CachedNetworkImage(
                                  height: 538.h,
                                  imageUrl: fixture.logo,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: 538.h,
                                    child: const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: 538.h,
                                    child: Image.asset('images/splash.png'),
                                  ),
                                ),
                                Positioned.fill(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: theme.gradient,
                                    ),
                                  ),
                                ),
                                Positioned.directional(
                                  bottom: 0,
                                  start: 0,
                                  end: 0,
                                  textDirection: TextDirection.ltr,
                                  child: Container(
                                    width: context.width,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: context.horizontalMargin16,
                                      vertical: context.verticalMargin8,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                fixture.matchTitle,
                                                style: context
                                                    .textStyle17Medium(
                                                        color:
                                                            theme.textPrimary)
                                                    .copyWith(height: 1.2),
                                              ),
                                              SizedBox(
                                                  height:
                                                      context.verticalMargin8),
                                              Text(
                                                "T Score",
                                                style: context
                                                    .textStyle14Medium(
                                                        color:
                                                            theme.textSecondary)
                                                    .copyWith(height: 1.2),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                            width: context.horizontalMargin4),
                                        BlocConsumer<CommentaryBloc,
                                            CommentaryState>(
                                          listener: (context, state) {
                                            if (state is CommentaryDone) {
                                              final String channelId =
                                                  state.commentary.channelId;
                                              final currentlyPlayingState = context
                                                  .read<
                                                      CurrentlyPlayingCommentaryBloc>()
                                                  .state;
                                              final bool isPlaying =
                                                  currentlyPlayingState
                                                          is CurrentlyPlayingCommentaryChannel &&
                                                      currentlyPlayingState
                                                              .channelId ==
                                                          channelId;

                                              if (!isPlaying &&
                                                  fixture.isLive) {
                                                context
                                                    .read<PlayCommentaryBloc>()
                                                    .add(
                                                      PlayCommentary(
                                                        channelId: channelId,
                                                        token: state
                                                            .commentary.token,
                                                        fixtureGuid:
                                                            fixture.guid,
                                                        fixtureIcon:
                                                            fixture.logo,
                                                        matchName:
                                                            fixture.matchTitle,
                                                      ),
                                                    );
                                              }
                                            }
                                          },
                                          builder: (context, state) {
                                            if (state is CommentaryDone) {
                                              final String channelId =
                                                  state.commentary.channelId;
                                              return BlocBuilder<
                                                  CurrentlyPlayingCommentaryBloc,
                                                  CurrentlyPlayingCommentaryState>(
                                                builder: (context, state) {
                                                  final bool isPlaying = state
                                                          is CurrentlyPlayingCommentaryChannel &&
                                                      state.channelId ==
                                                          channelId;
                                                  if (isPlaying) {
                                                    return Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                        horizontal: context
                                                            .horizontalMargin12,
                                                        vertical: context
                                                            .verticalMargin5,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color: theme.live,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(context
                                                                    .radius4),
                                                      ),
                                                      child: Text(
                                                        "Live",
                                                        style: context
                                                            .textStyle12Medium(
                                                                color: theme
                                                                    .textPrimary)
                                                            .copyWith(
                                                                height: 1.2),
                                                      ),
                                                    );
                                                  }
                                                  return const SizedBox();
                                                },
                                              );
                                            }
                                            return const SizedBox();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    RadioPlayer(fixtureGuid: fixture.guid),
                    SizedBox(height: context.verticalMargin40),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: context.horizontalMargin15),
                      child: Text(
                        state.fixture.matchDescription,
                        style: context
                            .textStyle12Medium(color: theme.textSecondary)
                            .copyWith(height: 1.2),
                      ),
                    ),
                    SizedBox(height: context.verticalMargin16),
                    // Medium template
                    if (_nativeAd != null && _nativeAdIsLoaded)
                      ConstrainedBox(
                        constraints: const BoxConstraints(
                          minWidth: 320, // minimum recommended width
                          minHeight: 90, // minimum recommended height
                          maxWidth: 400,
                          maxHeight: 200,
                        ),
                        child: AdWidget(ad: _nativeAd!),
                      ),
                  ],
                );
              } else {
                return Container();
              }
            },
          ),
        );
      },
    );
  }
}

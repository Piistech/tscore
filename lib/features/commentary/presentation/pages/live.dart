import 'package:podcast/core/shared/shared.dart';
import 'package:podcast/features/fixture/fixture.dart';

class LivePage extends StatelessWidget {
  static const String path = '/live/:fixtureGuid';
  static const String name = 'LivePage';
  const LivePage({super.key});

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
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.favorite_outline),
              ),
            ],
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
                      height: context.height * .78,
                      child: Stack(
                        clipBehavior: Clip.antiAlias,
                        children: [
                          Positioned(
                            bottom: 8,
                            left: 0,
                            right: 0,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: context.horizontalMargin12),
                                  child: LinearProgressIndicator(
                                    backgroundColor: theme.backgroundSecondary,
                                    valueColor: AlwaysStoppedAnimation(theme.textPrimary),
                                    value: 0.8,
                                    color: theme.textSecondary,
                                    borderRadius: BorderRadius.circular(context.radius12),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.skip_previous_rounded, color: theme.textPrimary),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.play_circle_fill_rounded, size: 48, color: theme.textPrimary),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.skip_next_rounded, color: theme.textPrimary),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            child: ShaderMask(
                              shaderCallback: (Rect bounds) {
                                return LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    theme.backgroundPrimary.withOpacity(0.9),
                                    theme.backgroundPrimary.withOpacity(.2),
                                    theme.backgroundPrimary.withOpacity(.2),
                                    theme.backgroundPrimary.withOpacity(.2),
                                    theme.backgroundPrimary.withOpacity(.8),
                                  ],
                                ).createShader(bounds);
                              },
                              blendMode: BlendMode.srcATop,
                              child: Stack(
                                children: [
                                  CachedNetworkImage(
                                    height: context.height * .65,
                                    imageUrl: fixture.logo,
                                    fit: BoxFit.fill,
                                    errorWidget: (context, url, error) => const Icon(Icons.error),
                                    placeholder: (context, url) => const CircularProgressIndicator(),
                                  ),
                                  Positioned.directional(
                                    bottom: 0,
                                    start: 0,
                                    end: 0,
                                    textDirection: TextDirection.ltr,
                                    child: Container(
                                      width: context.width,
                                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            fixture.matchTitle,
                                            style: context.textStyle17Medium(color: theme.white),
                                          ),
                                          Text(
                                            "T Score",
                                            style: context.textStyle12Medium(color: theme.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: context.horizontalMargin16),
                      child: Text(
                        "Welcome to the highly anticipated Bangladesh vs Sri Lanka cricket match! It's a beautiful day for cricket and the stadium is packed with enthusiastic fans from both",
                        style: context.textStyle12Medium(color: theme.textSecondary),
                      ),
                    )
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

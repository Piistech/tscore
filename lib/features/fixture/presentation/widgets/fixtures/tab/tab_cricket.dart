import '../../../../../../core/config/config.dart';
import '../../../../../../core/shared/shared.dart';
import '../../../../../commentary/commentary.dart';
import '../../../../domain/entities/fixtures.dart';
import '../../../../fixture.dart';
import '../../shimmer/fixtures.dart';
import '../on_air.dart';

class TabCricket extends StatelessWidget {
  const TabCricket({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<CricketFixturesBloc>().add(const CricketFetchFixtures());
      },
      child: BlocBuilder<CricketFixturesBloc, CricketFixturesState>(
        builder: (_, state) {
          if (state is CricketFixturesLoading) {
            return const ShimmerFixture();
          } else if (state is CricketFixturesDone) {
            final bool live =
                state.fixtures.where((element) => element.isLive).isNotEmpty;
            final List<FixturesEntity> fixtures =
                state.fixtures.where((element) => !element.isOnGoing).toList();
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Visibility(
                  visible: live,
                  child: SizedBox(
                    child: SizedBox(height: context.verticalMargin16),
                  ),
                ),
                Visibility(
                  visible: live,
                  child: MultiBlocProvider(
                    providers: [
                      BlocProvider.value(
                          value: context.read<CricketFixturesBloc>()),
                    ],
                    child: const OnAirWidget(),
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    itemCount: fixtures.length,
                    padding: EdgeInsets.symmetric(
                      horizontal: context.horizontalMargin15,
                      vertical: context.verticalMargin15,
                    ),
                    separatorBuilder: (_, __) =>
                        SizedBox(height: context.verticalMargin8),
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (_, index) {
                      final fixture = fixtures[index];
                      return BlocProvider(
                        create: (context) => sl<CommentaryBloc>()
                          ..add(
                            FetchCommentary(fixtureGuid: fixture.guid),
                          ),
                        child: FixtureItemWidget(fixture: fixture),
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (state is CricketFixturesError) {
            return Center(child: Text(state.failure.message));
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

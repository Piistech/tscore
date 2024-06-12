import 'package:tscore/core/config/config.dart';
import 'package:tscore/features/commentary/presentation/bloc/commentary_bloc.dart';
import 'package:tscore/features/fixture/domain/entities/fixtures.dart';
import 'package:tscore/features/fixture/presentation/bloc/football_fixtures_bloc.dart';
import 'package:tscore/features/fixture/presentation/widgets/fixtures/item.dart';
import 'package:tscore/features/fixture/presentation/widgets/fixtures/on_air.dart';
import 'package:tscore/features/fixture/presentation/widgets/shimmer/fixtures.dart';

import '../../../../../../core/shared/shared.dart';

class TabFootball extends StatelessWidget {
  const TabFootball({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<FootballFixturesBloc>().add(const FootballFetchFixtures());
      },
      child: BlocBuilder<FootballFixturesBloc, FootballFixturesState>(
        builder: (_, state) {
          if (state is FootballFixturesLoading) {
            return const ShimmerFixture();
          } else if (state is FootballFixturesDone) {
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
                          value: context.read<FootballFixturesBloc>()),
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
          } else if (state is FootballFixturesError) {
            return Center(child: Text(state.failure.message));
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

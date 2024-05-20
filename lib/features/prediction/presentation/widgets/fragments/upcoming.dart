import '../../../../../core/shared/shared.dart';
import '../../../../fixture/fixture.dart';
import '../../../../live_audio/live_audio.dart';
import '../list.dart';

class UpcomingMatches extends StatelessWidget {
  const UpcomingMatches({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<FixturesBloc>().add(const FetchFixtures());
      },
      child: BlocBuilder<FixturesBloc, FixturesState>(
        builder: (_, state) {
          if (state is FixturesLoading) {
            return ListView.builder(
              itemCount: 4,
              itemBuilder: (_, __) => const ShimmerItem(),
            );
          } else if (state is FixturesDone) {
            return PredictionList(
              fixtures: state.fixtures.where((element) => (element.isUpcoming && !element.isTomorrow)).toList(),
            );
          } else if (state is FixturesError) {
            return Center(child: Text(state.failure.message));
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

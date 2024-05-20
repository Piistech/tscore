
import 'package:tscore/features/prediction/presentation/widgets/shimmer/item.dart';

import '../../../../../core/shared/shared.dart';
import '../../../../fixture/fixture.dart';
import '../../../prediction.dart';

class TodayMatches extends StatelessWidget {
  const TodayMatches({super.key});

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
              itemBuilder: (_, __) => const ShimmerPredictionItem(),
            );
          } else if (state is FixturesDone) {
            return PredictionList(
              fixtures: state.fixtures.where((element) => element.isToday).toList(),
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



import '../../../../../core/shared/shared.dart';

class TodayMatches extends StatelessWidget {
  const TodayMatches({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<PredictionsBloc>().add(const Fetch());
      },
      child: BlocBuilder<PredictionsBloc, PredictionsState>(
        builder: (_, state) {
          if (state is PredictionsLoading) {
            return ListView.builder(
              itemCount: 4,
              itemBuilder: (_, __) => const ShimmerPredictionItem(),
            );
          } else if (state is PredictionsDone) {
            return PredictionList(
              fixtures: state.fixtures.where((element) => element.isToday).toList(),
            );
          } else if (state is PredictionsError) {
            return Center(child: Text(state.failure.message));
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

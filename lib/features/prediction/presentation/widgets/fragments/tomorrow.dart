

import '../../../../../core/shared/shared.dart';
import '../../../../live_audio/live_audio.dart';

class TomorrowMatches extends StatelessWidget {
  const TomorrowMatches({super.key});

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
              itemBuilder: (_, __) => const ShimmerItem(),
            );
          } else if (state is PredictionsDone) {
            return PredictionList(
              fixtures: state.fixtures.where((element) => element.isTomorrow).toList(),
            );} else if (state is PredictionsError) {
            return Center(child: Text(state.failure.message));
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

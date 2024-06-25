import '../../../../core/shared/shared.dart';
import 'item.dart';

class PredictionList extends StatelessWidget {
  final List<PredictionsEntity> fixtures;
  const PredictionList({super.key, required this.fixtures});

  @override
  Widget build(BuildContext context) {
    return fixtures.isEmpty
        ? Center(
            child: Lottie.asset("images/icons/no_data.json"),
          )
        : ListView.separated(
            itemCount: fixtures.length,
            padding: EdgeInsets.only(
              left: context.horizontalMargin15,
              right: context.horizontalMargin15,
              top: context.verticalMargin15,
              bottom: 150,
            ),
            separatorBuilder: (_, __) =>
                SizedBox(height: context.verticalMargin8),
            physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: (_, index) {
              final fixture = fixtures[index];
              return PredictionItemWidget(predictionModel: fixture);
            },
          );
  }
}

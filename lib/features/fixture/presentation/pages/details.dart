import 'dart:developer';

import '../../../../core/shared/shared.dart';
import '../../../analysis/analysis.dart';
import '../../fixture.dart';
import '../widgets/details/result.dart';

class FixtureDetailsPage extends StatelessWidget {
  final String guid;
  static const String path = '/fixtures/:id';
  static const String name = 'FixtureDetailsPage';

  const FixtureDetailsPage({
    super.key,
    required this.guid,
  });
  @override
  Widget build(BuildContext context) {
    /// get full path
    log("${GoRouterState.of(context).fullPath}");
    return Scaffold(
      appBar: AppBar(
        title: MatchTitleWidget(
          fixtureGuid: guid,
        ),
        leading: BackButton(
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: context.horizontalMargin15,
          vertical: context.verticalMargin15,
        ),
        children: [
          AnalysisWidget(fixtureGuid: guid),
          SizedBox(height: context.verticalMargin16),
          PredictionWidget(fixtureGuid: guid),
          SizedBox(height: context.verticalMargin16),
          MatchResult(fixtureGuid: guid),
        ],
      ),
    );
  }
}

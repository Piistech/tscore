
import '../../../../../core/shared/shared.dart';

class MatchTitleWidget extends StatefulWidget {
  final String fixtureGuid;
  const MatchTitleWidget({super.key, required this.fixtureGuid});

  @override
  State<MatchTitleWidget> createState() => _MatchTitleWidgetState();
}

class _MatchTitleWidgetState extends State<MatchTitleWidget> {
  @override
  void initState() {
    super.initState();
    context.read<FindPredictionByIdBloc>().add(
          FindPredictionById(
            guid: widget.fixtureGuid,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (_, state) {
        final theme = state.scheme;
        return BlocBuilder<FindPredictionByIdBloc, FindPredictionByIdState>(
          builder: (context, state) {
            if (state is FindPredictionByIdDone) {
              final prediction = state.prediction;
              return Text(
                prediction.title,
                style: context.textStyle17Medium(color: theme.textPrimary),
              );
            }
            return Container();
          },
        );
      },
    );
  }
}

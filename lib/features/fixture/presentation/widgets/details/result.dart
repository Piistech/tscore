import '../../../../../core/shared/shared.dart';

class MatchResult extends StatefulWidget {
  final String fixtureGuid;
  const MatchResult({super.key, required this.fixtureGuid});

  @override
  State<MatchResult> createState() => _MatchResultState();
}

class _MatchResultState extends State<MatchResult> {
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
              return prediction.result == ""
                  ? Container()
                  : Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                        horizontal: context.horizontalMargin16,
                        vertical: context.verticalMargin16,
                      ),
                      child: Text(
                        prediction.result.toString(),
                        style: context.textStyle17Medium(color: theme.textPrimary),
                      ),
                    );
            }
            return Container();
          },
        );
      },
    );
  }
}

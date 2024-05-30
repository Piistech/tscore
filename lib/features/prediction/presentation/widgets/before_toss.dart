import '../../../../core/shared/shared.dart';
import '../../../team/team.dart';

class BeforeTossPrediction extends StatefulWidget {
  final String teamGuid;
  const BeforeTossPrediction({
    super.key,
    required this.teamGuid,
  });

  @override
  State<BeforeTossPrediction> createState() => _BeforeTossPredictionState();
}

class _BeforeTossPredictionState extends State<BeforeTossPrediction> {
  @override
  void initState() {
    super.initState();
    context.read<TeamBloc>().add(
          FetchTeam(teamGuid: widget.teamGuid),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (_, state) {
        final theme = state.scheme;
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: context.horizontalMargin30,
            vertical: context.verticalMargin10,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: const LinearGradient(
              colors: [
                Color(0xFF9C5B00),
                Color(0xFF482A00),
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
            boxShadow: const [
              BoxShadow(
                offset: Offset(0, 4),
                spreadRadius: 0,
                blurRadius: 12,
                color: Color(0xFF9B5A01),
              )
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Match Prediction',
                  style: context.textStyle14Medium(color: theme.textPrimary).copyWith(height: 1.2),
                ),
              ),
              SizedBox(height: context.verticalMargin25),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      'Match Winner',
                      style: context.textStyle14Medium(color: theme.textPrimary).copyWith(height: 1.2),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: TeamInfoWidget(
                      builder: (team) {
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              team.shortName,
                              style: context.textStyle20Medium(color: theme.textPrimary).copyWith(height: 1.2),
                            ),
                            SizedBox(width: context.horizontalMargin4),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(context.radius16),
                              child: CachedNetworkImage(
                                imageUrl: team.flag,
                                height: context.flagHeight36,
                                width: context.flagWidth48,
                                placeholder: (context, url) => SizedBox(
                                  width: context.flagHeight36,
                                  height: context.flagHeight36,
                                  child: const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                                errorWidget: (context, url, error) => SizedBox(
                                  height: context.flagHeight36,
                                  width: context.flagWidth48,
                                  child: Image.asset('images/splash.png'),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

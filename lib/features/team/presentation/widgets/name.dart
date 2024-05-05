import '../../../../core/shared/shared.dart';
import '../../team.dart';

class TeamNameWidget extends StatefulWidget {
  final String teamGuid;
  const TeamNameWidget({
    super.key,
    required this.teamGuid,
  });

  @override
  State<TeamNameWidget> createState() => _TeamNameWidgetState();
}

class _TeamNameWidgetState extends State<TeamNameWidget> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<TeamBloc>(context).add(
      FetchTeam(teamGuid: widget.teamGuid),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeamBloc, TeamState>(
      builder: (context, state) {
        if (state is TeamLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is TeamDone) {
          return Text(
            state.team.name,
            style: TextStyles.caption(
              context: context,
              color: context.textColor,
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}

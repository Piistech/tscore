

import '../../../../core/shared/shared.dart';

class PredictionsPage extends StatefulWidget {
  static const String path = '/predictions';
  static const String name = 'PredictionsPage';
  const PredictionsPage({super.key});

  @override
  State<PredictionsPage> createState() => _PredictionsPageState();
}

class _PredictionsPageState extends State<PredictionsPage> with SingleTickerProviderStateMixin {
  
  late TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final theme = state.scheme;
        return Scaffold(
          body: DefaultTabController(
            length: 4,
            initialIndex: 0,
            child: Scaffold(
              backgroundColor: theme.backgroundPrimary,
              appBar: TabBar(
                labelStyle: TextStyles.body(
                  context: context,
                  color: theme.textPrimary,
                ).copyWith(fontWeight: FontWeight.bold),
                unselectedLabelStyle: TextStyles.body(context: context, color: theme.textSecondary),
                indicatorWeight: 3,
                tabAlignment: TabAlignment.center,
                dividerColor: Colors.transparent,
                indicatorColor: theme.warning,
                physics: const ScrollPhysics(),
                isScrollable: true,
                controller: tabController,
                indicatorSize: TabBarIndicatorSize.label,
                tabs: [
                  Tab(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      child: Text(
                        "Today",
                        style: context.textStyle12Medium(color: theme.textPrimary).copyWith(height: 1.2),
                      ),
                    ),
                  ),
                  Tab(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      child: Text(
                        "Tomorrow",
                        style: context.textStyle12Medium(color: theme.textPrimary).copyWith(height: 1.2),
                      ),
                    ),
                  ),
                  Tab(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      child: Text(
                        "Upcoming",
                        style: context.textStyle12Medium(color: theme.textPrimary).copyWith(height: 1.2),
                      ),
                    ),
                  ),
                  Tab(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      child: Text(
                        "Past",
                        style: context.textStyle12Medium(color: theme.textPrimary).copyWith(height: 1.2),
                      ),
                    ),
                  ),
                ],
              ),
              body: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: tabController,
                children: const [
                  TodayMatches(),
                  TomorrowMatches(),
                  UpcomingMatches(),
                  PastMatches(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

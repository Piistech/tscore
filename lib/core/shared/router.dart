import 'package:tscore/features/fixture/presentation/bloc/football_fixtures_bloc.dart';
import 'package:tscore/features/fixture/presentation/pages/custom_ads.dart';

import '../../features/analysis/analysis.dart';
import '../../features/commentary/commentary.dart';
import '../../features/fixture/fixture.dart';
import '../../features/homepage/presentation/pages/home.dart';
import '../../features/live_audio/presentation/pages/lives_radio.dart';
import '../../features/more/presentation/pages/more.dart';
import '../config/config.dart';
import 'shared.dart';

// navigator key
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: HomePage.path,
  routes: [
    GoRoute(
      path: HomePage.path,
      name: HomePage.name,
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => sl<FootballFixturesBloc>()
                ..add(const FootballFetchFixtures())),
          BlocProvider(
              create: (context) =>
                  sl<CricketFixturesBloc>()..add(const CricketFetchFixtures())),
        ],
        child: const HomePage(),
      ),
    ),
    GoRoute(
      path: FixturesPage.path,
      name: FixturesPage.name,
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => sl<FootballFixturesBloc>()
                ..add(const FootballFetchFixtures())),
          BlocProvider(
              create: (context) =>
                  sl<CricketFixturesBloc>()..add(const CricketFetchFixtures())),
        ],
        child: const FixturesPage(),
      ),
    ),
    GoRoute(
      path: PredictionsPage.path,
      name: PredictionsPage.name,
      builder: (context, state) => const PredictionsPage(),
    ),
    GoRoute(
      path: MorePage.path,
      name: MorePage.name,
      builder: (context, state) => const MorePage(),
    ),
    GoRoute(
        path: PrivacyPolicyPage.path,
        name: PrivacyPolicyPage.name,
        builder: (context, state) {
          final Map<String, dynamic>? arguments =
              state.extra as Map<String, dynamic>?;
          final String header = arguments?['header'] as String;
          final String link = arguments?['link'] as String;
          return PrivacyPolicyPage(
            headerText: header,
            link: link,
          );
        }),
    GoRoute(
      path: LiveRadioPage.path,
      name: LiveRadioPage.name,
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => sl<FootballFixturesBloc>()
                ..add(const FootballFetchFixtures())),
          BlocProvider(
              create: (context) =>
                  sl<CricketFixturesBloc>()..add(const CricketFetchFixtures())),
        ],
        child: const LiveRadioPage(),
      ),
    ),
    GoRoute(
      path: CustomAdsScreen.path,
      name: CustomAdsScreen.name,
      builder: (context, state) {
        final String guid = state.pathParameters['id']!;
        return CustomAdsScreen(guid: guid);
      },
    ),
    GoRoute(
      path: FixtureDetailsPage.path,
      name: FixtureDetailsPage.name,
      builder: (context, state) {
        final String guid = state.pathParameters['id']!;
        return MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (context) => sl<FindPredictionByIdBloc>()
                  ..add(FindPredictionById(guid: guid))),
            BlocProvider(
                create: (context) =>
                    sl<AnalysisBloc>()..add(FetchAnalysis(fixtureGuid: guid))),
            BlocProvider(
                create: (context) => sl<PredictionBloc>()
                  ..add(FetchPrediction(fixtureGuid: guid))),
          ],
          child: FixtureDetailsPage(
            guid: guid,
          ),
        );
      },
    ),
    GoRoute(
      path: LivePage.path,
      name: LivePage.name,
      builder: (context, state) {
        final String fixtureGuid = state.pathParameters['fixtureGuid']!;
        return MultiBlocProvider(
          providers: [
            BlocProvider.value(
              value: context.read<CurrentlyPlayingCommentaryBloc>()
                ..add(
                  CheckCurrentlyPlayingCommentary(),
                ),
            ),
            BlocProvider(
              create: (context) => sl<CommentaryBloc>()
                ..add(
                  FetchCommentary(fixtureGuid: fixtureGuid),
                ),
            ),
            BlocProvider(
              create: (context) => sl<FindFixtureByIdBloc>()
                ..add(
                  FindFixtureById(guid: fixtureGuid),
                ),
            ),
            BlocProvider(
              create: (context) => sl<PlayCommentaryBloc>(),
            ),
            BlocProvider(
              create: (context) => sl<StopCommentaryBloc>(),
            ),
          ],
          child: const LivePage(),
        );
      },
    ),
  ],
);

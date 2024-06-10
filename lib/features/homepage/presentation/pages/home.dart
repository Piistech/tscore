import 'dart:developer';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:tscore/core/shared/app_review/app_review_services.dart';
import 'package:tscore/core/shared/home_navigator/home_navigator_cubit.dart';

import '../../../../core/config/config.dart';
import '../../../../core/shared/shared.dart';
import '../../../fixture/fixture.dart';
import '../../../live_audio/live_audio.dart';
import '../../../lookup/lookup.dart';
import '../../../more/presentation/pages/more.dart';
import '../../home.dart';

class HomePage extends StatefulWidget {
  static const String path = '/home';
  static const String name = 'HomePage';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final List<Widget> fragments;
  @override
  void initState() {
    super.initState();
    AppReviewServices.instance.checkAvailability();
    BackButtonInterceptor.add(myInterceptor);

    fragments = [
      const FixturesPage(),
      const LiveRadioPage(),
      MultiBlocProvider(providers: [
        BlocProvider(
            create: (context) =>
                sl<LookupBloc>()..add(const FetchLookup(key: 'adKey'))),
        BlocProvider(
            create: (context) => sl<PredictionsBloc>()..add(const Fetch())),
      ], child: const PredictionsPage()),
      const MorePage(),
    ];
    if (kReleaseMode) {
      InAppUpdate.checkForUpdate().then(
        (event) {
          if (event.updateAvailability == UpdateAvailability.updateAvailable) {
            InAppUpdate.performImmediateUpdate().then(
              (result) {
                if (result == AppUpdateResult.success) {
                  TaskNotifier.instance
                      .success(context, message: "App updated successfully");
                }
              },
            );
          }
        },
      );
    }
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    log("$stopDefaultButtonEvent, ${info.currentRoute(context)?.settings.name}");
    //  GoRouterState.of(context).fullPath ?? "";
    final int currentIndex = context.read<HomeNavigatorCubit>().currentIndex;
    final String pageName = info.currentRoute(context)?.settings.name ?? "";

    log("full path $pageName ");

    if (currentIndex != 0) {
      if (!pageName.contains("HomePage")) {
        log("if if Home Index: [${context.read<HomeNavigatorCubit>().currentIndex}], current Path $pageName");
        return false;
      } else {
        log("if  else Home Index: [${context.read<HomeNavigatorCubit>().currentIndex}], current Path $pageName");
        context.read<HomeNavigatorCubit>().setCurrentIndex(0);
        return true;
      }
    } else {
      log("else Home Index: [${context.read<HomeNavigatorCubit>().currentIndex}]");
      context.read<HomeNavigatorCubit>().setCurrentIndex(0);
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        log("didPop: $didPop");
      },
      child: BlocBuilder<HomeNavigatorCubit, int>(
        builder: (context, state) {
          int currentIndex = state;
          return BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              final theme = state.scheme;
              return Scaffold(
                appBar: AppBar(
                  leadingWidth: 30.w,
                  leading: Padding(
                    padding: EdgeInsets.only(left: context.horizontalMargin10),
                    child: Image.asset(
                      "images/splash.png",
                      fit: BoxFit.contain,
                      width: 36.w,
                      height: 36.h,
                    ),
                  ),
                  title: Container(
                    margin: EdgeInsets.only(left: context.horizontalMargin8),
                    child: Text(
                      "T-Score",
                      style: context.textStyle17MediumZenDots(
                          color: theme.textPrimary),
                    ),
                  ),
                  automaticallyImplyLeading: false,
                ),
                body: fragments.elementAt(currentIndex),
                bottomNavigationBar: PhysicalModel(
                  color: theme.backgroundTertiary,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.horizontalMargin15,
                      vertical: context.verticalMargin11,
                    ).copyWith(
                        bottom: (context.bottomInset / 2) +
                            context.verticalMargin11),
                    width: double.maxFinite,
                    height: 54.h + (context.bottomInset / 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        currentIndex == 0
                            ? SelectedNavItem(
                                icon: "images/icons/home.svg",
                                title: "Home",
                                index: 0,
                                previous: currentIndex,
                              )
                            : UnselectedNavItem(
                                icon: "images/icons/home.svg",
                                onTap: () {
                                  context
                                      .read<HomeNavigatorCubit>()
                                      .setCurrentIndex(0);
                                },
                              ),
                        currentIndex == 1
                            ? SelectedNavItem(
                                icon: "images/icons/live.svg",
                                title: "Live Radio",
                                index: 1,
                                previous: currentIndex,
                              )
                            : UnselectedNavItem(
                                icon: "images/icons/live.svg",
                                onTap: () {
                                  context
                                      .read<HomeNavigatorCubit>()
                                      .setCurrentIndex(1);
                                },
                              ),
                        currentIndex == 2
                            ? SelectedNavItem(
                                icon: "images/icons/prediction.svg",
                                title: "Prediction",
                                index: 2,
                                previous: currentIndex,
                              )
                            : UnselectedNavItem(
                                icon: "images/icons/prediction.svg",
                                onTap: () {
                                  context
                                      .read<HomeNavigatorCubit>()
                                      .setCurrentIndex(2);
                                },
                              ),
                        currentIndex == 3
                            ? SelectedNavItem(
                                icon: "images/icons/more.svg",
                                title: "More",
                                index: 3,
                                previous: currentIndex,
                              )
                            : UnselectedNavItem(
                                icon: "images/icons/more.svg",
                                onTap: () {
                                  context
                                      .read<HomeNavigatorCubit>()
                                      .setCurrentIndex(3);
                                },
                              ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class SelectedNavItem extends StatelessWidget {
  final String icon;
  final String title;
  final int index;
  final int previous;

  const SelectedNavItem({
    super.key,
    required this.icon,
    required this.title,
    required this.index,
    required this.previous,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final theme = state.scheme;
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: context.horizontalMargin6,
            vertical: context.verticalMargin6,
          ),
          decoration: BoxDecoration(
            color: theme.textPrimary,
            borderRadius: BorderRadius.circular(context.radius4),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                icon,
                colorFilter: ColorFilter.mode(
                  theme.backgroundPrimary,
                  BlendMode.srcIn,
                ),
                width: 20.w,
                height: 20.h,
              ),
              SizedBox(width: context.horizontalMargin2),
              Text(
                title,
                style: context
                    .textStyle14Medium(color: theme.backgroundPrimary)
                    .copyWith(height: 1.2),
              ),
            ],
          ),
        ).animate()
          ..fade(
            duration: const Duration(milliseconds: 300),
          );
      },
    );
  }
}

class UnselectedNavItem extends StatelessWidget {
  final String icon;
  final VoidCallback onTap;

  const UnselectedNavItem({
    super.key,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final theme = state.scheme;
        return InkWell(
          onTap: onTap,
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: context.horizontalMargin16),
            child: SvgPicture.asset(
              icon,
              colorFilter: ColorFilter.mode(
                theme.textPrimary,
                BlendMode.srcIn,
              ),
              width: 24.w,
              height: 24.h,
            ).animate()
              ..moveX(
                duration: const Duration(milliseconds: 300),
              ),
          ),
        );
      },
    );
  }
}

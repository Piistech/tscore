library config;

import 'package:tscore/core/shared/home_navigator/home_navigator_cubit.dart';
import 'package:tscore/features/fixture/presentation/bloc/football_fixtures_bloc.dart';

import '../../features/analysis/analysis.dart';
import '../../features/commentary/commentary.dart';
import '../../features/fixture/fixture.dart';
import '../../features/lookup/lookup.dart';
import '../../features/team/team.dart';
import '../shared/shared.dart';

part 'dependencies.dart';
part 'network_certificates.dart';

class AppConfig {
  static FutureOr<void> init() async {
    WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

    ///------------------------AdsMob---------------------------
    // need to initialize the Mobile Ads SDK before loading ads.
    unawaited(MobileAds.instance.initialize());

    ///---------------------------------------------------------

    // Bypass the SSL certificate verification
    HttpOverrides.global = MyHttpOverrides();

    HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getApplicationCacheDirectory(),
    );

    // Initialize the configurations
    await _setupDependencies();

    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

    final notification = sl<NotificationManager>();
    notification.initialize();

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor:
            sl<ThemeBloc>().state.scheme.backgroundPrimary,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
  }

  static ThemeData theme({
    required BuildContext context,
    required ThemeScheme theme,
  }) =>
      ThemeData(
        brightness: Brightness.dark,
        canvasColor: theme.backgroundPrimary,
        scaffoldBackgroundColor: theme.backgroundPrimary,
        splashFactory: InkRipple.splashFactory,
        primaryColor: theme.live,
        indicatorColor: theme.live,
        inputDecorationTheme: InputDecorationTheme(
          isDense: true,
          filled: true,
          fillColor: theme.backgroundSecondary,
          labelStyle:
              TextStyles.body(context: context, color: theme.textPrimary),
          contentPadding: const EdgeInsets.all(16.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.black, width: .5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.black, width: 4),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.black, width: 2),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.grey, width: 1),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: theme.negative, width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: theme.negative, width: 3),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 1,
            padding: const EdgeInsets.all(16),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            elevation: 3,
            backgroundColor: Colors.white,
            shape:
                const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
        textSelectionTheme:
            TextSelectionThemeData(cursorColor: theme.textPrimary),
        iconTheme: IconThemeData(color: theme.textPrimary, size: 20),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: theme.textPrimary),
          titleSpacing: 0,
          actionsIconTheme: IconThemeData(color: theme.textPrimary),
          backgroundColor: theme.backgroundSecondary,
          surfaceTintColor: theme.backgroundSecondary,
          foregroundColor: theme.backgroundPrimary,
          elevation: 0,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: theme.backgroundPrimary,
          primary: theme.live,
          brightness: Brightness.dark,
        ),
      );
}

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) =>
    sl<NotificationManager>().onDidReceiveNotificationResponse;

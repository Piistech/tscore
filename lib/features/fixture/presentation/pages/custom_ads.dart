// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';

import 'package:tscore/core/shared/shared.dart';
import 'package:tscore/features/fixture/presentation/pages/details.dart';
import 'package:webview_flutter/webview_flutter.dart';
// #doc region platform_imports
// Import for Android features.
import 'package:webview_flutter_android/webview_flutter_android.dart';
// Import for iOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

enum AdsLoadState {
  loading,
  loaded,
  failure,
  idle,
  reloading,
}

class CustomAdsScreen extends StatefulWidget {
  final String guid;
  const CustomAdsScreen({super.key, required this.guid});

  static const path = "/custom-ads/:id";
  static const name = "CustomAds";

  @override
  State<CustomAdsScreen> createState() => _CustomAdsScreenState();
}

class _CustomAdsScreenState extends State<CustomAdsScreen> {
  static const adsURL =
      "https://www.highcpmgate.com/h6nea1ib?key=b9e43a9f156873b72fbdd79b09abd4ba";

  late WebViewController _controller;
  final ValueNotifier<AdsLoadState> pageState =
      ValueNotifier<AdsLoadState>(AdsLoadState.idle);

  final ValueNotifier<int> loadPercent = ValueNotifier<int>(0);
  @override
  void initState() {
    super.initState();
    // #doc region platform_features
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);
    // #enddocregion platform_features
    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      // ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            log('WebView is loading (progress : $progress%)');
            loadPercent.value = progress;
          },
          onPageStarted: (String url) {
            pageState.value = AdsLoadState.loading;
          },
          onPageFinished: (String url) {
            pageState.value = AdsLoadState.loaded;
          },
          onHttpError: (HttpResponseError error) {
            pageState.value = AdsLoadState.failure;
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            // if (request.url.startsWith('https://www.youtube.com/')) {
            //   return NavigationDecision.navigate;
            // }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(adsURL));
    // #docregion platform_features
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    // #enddocregion platform_features

    _controller = controller;
  }

  @override
  void dispose() {
    _controller.clearCache();
    pageState.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final theme = state.scheme;
        return Scaffold(
          backgroundColor: !isDarkMode
              ? Colors.white.withOpacity(0.1)
              : theme.backgroundPrimary,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: ValueListenableBuilder(
                valueListenable: loadPercent,
                builder: (context, value, child) {
                  if (value != 100) {
                    return AppBar(
                      title: Text(
                        "Advertisement",
                        style: TextStyles.title(
                            context: context, color: theme.textPrimary),
                      ),
                      centerTitle: true,
                      leading: const SizedBox(),
                      leadingWidth: 0,
                    );
                  }
                  return AppBar(
                    title: Text(
                      "Advertisement",
                      style: TextStyles.title(
                          context: context, color: theme.textPrimary),
                    ),
                    centerTitle: true,
                    actions: [
                      ValueListenableBuilder(
                          valueListenable: loadPercent,
                          builder: (context, value, child) {
                            if (value != 100) {
                              return const SizedBox();
                            }
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                              ),
                              onPressed: () {
                                context.pop();
                                context.pushNamed(
                                  FixtureDetailsPage.name,
                                  pathParameters: {
                                    'id': widget.guid,
                                  },
                                );
                              },
                              child: const Text(
                                "Skip",
                              ).animate(
                                effects: [
                                  const ScaleEffect(),
                                ],
                                onInit: (controller) => controller.repeat,
                              ),
                            );
                          }),
                      const SizedBox(width: 10),
                    ],
                  );
                }),
          ),
          body: ValueListenableBuilder(
              valueListenable: pageState,
              builder: (context, value, child) {
                log("pageState $value");
                if (value == AdsLoadState.loaded) {
                  return WebViewWidget(controller: _controller);
                } else if (value == AdsLoadState.failure) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "images/icons/ads.png",
                          height: 100,
                          width: 100,
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                            onPressed: () {
                              context.pop();
                              context.pushNamed(
                                FixtureDetailsPage.name,
                                pathParameters: {
                                  'id': widget.guid,
                                },
                              );
                            },
                            child: const Text("View Predictions"))
                      ],
                    ),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),
        );
      },
    );
  }
}

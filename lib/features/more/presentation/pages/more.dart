import 'package:flutter/cupertino.dart';

import '../../../../core/shared/shared.dart';
import '../../more.dart';

class MorePage extends StatefulWidget {
  static const String path = '/more';
  static const String name = 'morePage';
  const MorePage({super.key});

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final theme = state.scheme;
        return ListView(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: context.horizontalMargin15,
            vertical: context.verticalMargin15,
          ),
          children: [
            SizedBox(height: context.verticalMargin10),
            Text(
              "Other options".toUpperCase(),
              style: TextStyles.title(context: context, color: theme.textPrimary),
            ),
            SizedBox(height: context.verticalMargin10),
            CardWidget(
              child: ListTile(
                dense: true,
                visualDensity: VisualDensity.compact,
                contentPadding: EdgeInsets.zero,
                leading: Icon(Icons.notifications_active_outlined, color: theme.white),
                horizontalTitleGap: 8.w,
                onTap: () {},
                title: Text(
                  "Notification",
                  style: TextStyles.body(context: context, color: theme.white).copyWith(height: 1.2),
                ),
                trailing: FutureBuilder<bool>(
                  future: checkPermission(Permission.notification),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return CupertinoSwitch(
                        value: snapshot.data ?? false,
                        onChanged: (granted) async {
                          if (granted) {
                            await Permission.notification.request();
                            setState(() {});
                          } else {
                            await AppSettings.openAppSettings(type: AppSettingsType.notification);
                            setState(() {});
                          }
                        },
                      );
                    } else {
                      return const CupertinoActivityIndicator();
                    }
                  },
                ),
              ),
            ),
            SizedBox(height: context.verticalMargin10),
            Text(
              "Follow us".toUpperCase(),
              style: TextStyles.title(context: context, color: theme.textPrimary),
            ),
            SizedBox(height: context.verticalMargin10),
            CardWidget(
              child: ListTile(
                dense: true,
                visualDensity: VisualDensity.compact,
                contentPadding: EdgeInsets.zero,
                leading: Icon(Icons.facebook_outlined, color: theme.white),
                horizontalTitleGap: 8.w,
                onTap: () async {
                  await launchUrl(Uri.parse(ExternalLinks().facebook), mode: LaunchMode.inAppBrowserView);
                },
                title: Text(
                  "Facebook",
                  style: TextStyles.body(context: context, color: theme.white).copyWith(height: 1.2),
                ),
              ),
            ),
            SizedBox(height: context.verticalMargin10),
            Text(
              "App".toUpperCase(),
              style: TextStyles.title(context: context, color: theme.textPrimary),
            ),
            SizedBox(height: context.verticalMargin10),
            CardWidget(
              child: Column(
                children: [
                  ListTile(
                    dense: true,
                    visualDensity: VisualDensity.compact,
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.info_outline, color: theme.white),
                    horizontalTitleGap: 8.w,
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return ListView(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            padding: EdgeInsets.symmetric(
                              horizontal: context.horizontalMargin15,
                              vertical: context.verticalMargin15,
                            ),
                            children: [
                              Text(
                                "About app",
                                style: TextStyles.title(context: context, color: theme.textPrimary).copyWith(height: 1.2),
                              ),
                              SizedBox(height: context.verticalMargin10),
                              Text(
                                "copyrights@ by - T Score (${DateFormat("yyyy").format(DateTime.now())}). All rights reserved.All trademarks are the property of their respective owners.",
                                style: TextStyles.body(context: context, color: theme.textPrimary).copyWith(height: 1.2),
                              ),
                              SizedBox(height: context.verticalMargin10),
                              FutureBuilder(
                                future: PackageInfo.fromPlatform(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    final PackageInfo packageInfo = snapshot.data as PackageInfo;
                                    return Text(
                                      "App version - ${packageInfo.version}",
                                      style:
                                          TextStyles.caption(context: context, color: theme.textPrimary).copyWith(height: 1.2),
                                    );
                                  } else {
                                    return const CupertinoActivityIndicator();
                                  }
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    title: Text(
                      "About app",
                      style: TextStyles.body(context: context, color: theme.white).copyWith(height: 1.2),
                    ),
                  ),
                  Divider(color: theme.textSecondary, height: 1.h, thickness: .5.h),
                  ListTile(
                    dense: true,
                    visualDensity: VisualDensity.compact,
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.star_rate_outlined, color: theme.white),
                    horizontalTitleGap: 8.w,
                    onTap: () async {
                      if (await checkReview()) {
                        InAppReview.instance.requestReview();
                      } else {
                        InAppReview.instance.openStoreListing(
                          appStoreId: "com.tscore.radio",
                        );
                      }
                    },
                    title: Text(
                      "Rate us",
                      style: TextStyles.body(context: context, color: theme.white).copyWith(height: 1.2),
                    ),
                  ),
                  Divider(color: theme.textSecondary, height: 1.h, thickness: .5.h),
                  ListTile(
                    dense: true,
                    visualDensity: VisualDensity.compact,
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.share_outlined, color: theme.white),
                    horizontalTitleGap: 8.w,
                    onTap: () async {
                      Share.share('https://play.google.com/store/apps/details?id=com.tscore.radio');
                    },
                    title: Text(
                      "Share App",
                      style: TextStyles.body(context: context, color: theme.white).copyWith(height: 1.2),
                    ),
                  ),
                  Divider(color: theme.textSecondary, height: 1.h, thickness: .5.h),
                  ListTile(
                    dense: true,
                    visualDensity: VisualDensity.compact,
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.lock_outline_rounded, color: theme.white),
                    horizontalTitleGap: 8.w,
                    onTap: () {
                      context.pushNamed(
                        PrivacyPolicyPage.name,
                        extra: {
                          "link": ExternalLinks.privacyPolicy,
                          "header": "Privacy Policy",
                        },
                      );
                    },
                    title: Text(
                      "Privacy Policy",
                      style: TextStyles.body(context: context, color: theme.white).copyWith(height: 1.2),
                    ),
                  ),
                  Divider(color: theme.textSecondary, height: 1.h, thickness: .5.h),
                  ListTile(
                    dense: true,
                    visualDensity: VisualDensity.compact,
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.list_alt_rounded, color: theme.white),
                    horizontalTitleGap: 8.w,
                    onTap: () {
                      context.pushNamed(
                        PrivacyPolicyPage.name,
                        extra: {
                          "link": ExternalLinks.termsAndCondition,
                          "header": "Terms & Condition",
                        },
                      );
                    },
                    title: Text(
                      "Terms & Condition",
                      style: TextStyles.body(context: context, color: theme.white).copyWith(height: 1.2),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: context.verticalMargin25),
            Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "App Version:",
                    style: TextStyles.title(context: context, color: theme.textPrimary).copyWith(height: 1.2),
                  ),
                  SizedBox(width: context.horizontalMargin8),
                  FutureBuilder(
                    future: PackageInfo.fromPlatform(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final PackageInfo packageInfo = snapshot.data as PackageInfo;
                        return Text(
                          packageInfo.version,
                          style: TextStyles.title(context: context, color: theme.textPrimary).copyWith(height: 1.2),
                        );
                      } else {
                        return const CupertinoActivityIndicator();
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class CardWidget extends StatelessWidget {
  final Widget child;
  const CardWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final theme = state.scheme;
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: context.horizontalMargin10,
            vertical: context.verticalMargin10,
          ),
          decoration: BoxDecoration(
            color: theme.backgroundSecondary,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: child,
        );
      },
    );
  }
}

// Asynchronously checks if the given permission is granted. Returns true if granted, false otherwise.
Future<bool> checkPermission(Permission permission) async {
  if (await permission.isGranted) {
    return true;
  } else {
    return false;
  }
}

Future<bool> checkReview() {
  return InAppReview.instance.isAvailable();
}

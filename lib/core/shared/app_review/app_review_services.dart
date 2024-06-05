import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:tscore/core/shared/task_notifier.dart';

enum Availability { loading, available, unavailable }

class AppReviewServices {
  static AppReviewServices? _instance;
  // Avoid self instance
  AppReviewServices._();
  static AppReviewServices get instance => _instance ??= AppReviewServices._();

  // Initialize the configurations
  final InAppReview _inAppReview = InAppReview.instance;

  // Get the app store id
  static final ValueNotifier<String> _appStoreId =
      ValueNotifier('com.tscore.radio');
  String get appStoreId => _appStoreId.value;

  //  Check if the review is available
  static final ValueNotifier<Availability> _availability =
      ValueNotifier<Availability>(Availability.loading);
  Availability get availability => _availability.value;

  // Check if the review is available
  Future<void> checkAvailability() async {
    (<T>(T? o) => o!)(WidgetsBinding.instance).addPostFrameCallback((_) async {
      try {
        final isAvailable = await _inAppReview.isAvailable();

        // This plugin cannot be tested on Android by installing your app
        // locally. See https://github.com/britannio/in_app_review#testing for
        // more information.
        _availability.value =
            isAvailable ? Availability.available : Availability.unavailable;
      } catch (e) {
        _availability.value = Availability.unavailable;
        log('Error while checking availability', error: e);
      }
    });
  }

  Future<void> openStoreListing() => instance._inAppReview.openStoreListing(
        appStoreId: _appStoreId.value,
      );

  Future<bool> isAvailable() async {
    return await _inAppReview.isAvailable();
  }

  Future<void> requestReview() async {
    await _inAppReview.requestReview();
  }

  Future<void> requestReviewFlow(BuildContext context) async {
    // if (_availability.value == Availability.unavailable) {
    log("Opening store listing");
    await openStoreListing().onError((error, stackTrace) {
      TaskNotifier.instance.error(context, message: error.toString());
    });
    return;
    // } else {
    //   log("Requesting review");
    //   await requestReview().onError((error, stackTrace) {
    //     TaskNotifier.instance.error(context, message: error.toString());
    //   });
    // }
  }
}

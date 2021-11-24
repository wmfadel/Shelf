import 'package:flutter/foundation.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import 'package:firebase_analytics/observer.dart';

class AnalyticsProvider with ChangeNotifier {
  static final FirebaseAnalytics analytics = FirebaseAnalytics();
  static final FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  Future<void> setCurrentScreen(String screenName) async {
    await analytics.setCurrentScreen(
      screenName: screenName,
      screenClassOverride: screenName,
    );
  }

  Future<void> setUserId() async {
    await analytics.setUserId('some-user');
  }
}

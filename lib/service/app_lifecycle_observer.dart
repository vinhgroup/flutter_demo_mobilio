import 'package:flutter/widgets.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class AppLifecycleObserver with WidgetsBindingObserver {
  final FirebaseAnalytics analytics;

  AppLifecycleObserver(this.analytics);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    analytics.logEvent(
      name: 'app_lifecycle',
      parameters: {'state': state.toString()},
    );
  }
}
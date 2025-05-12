import 'package:flutter/cupertino.dart';

class FlavorConfig {
  final String mflavorName;
  final String mApiBaseUrl;
  final String mUploadUrl;
  final String mSearchUrl;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static late FlavorConfig _instance;

  FlavorConfig._internal({
    required this.mflavorName,
    required this.mApiBaseUrl,
    required this.mUploadUrl,
    required this.mSearchUrl,
  });

  static void initialize({
    required String flavorName,
    required String apiBaseUrl,
    required String uploadUrl,
    required String searchUrl,
  }) {
    _instance = FlavorConfig._internal(
      mflavorName: flavorName,
      mApiBaseUrl: apiBaseUrl,
      mUploadUrl: uploadUrl,
      mSearchUrl: searchUrl,
    );
  }

  // Getter tĩnh để truy cập navigatorKey và context
  static GlobalKey<NavigatorState> get globalKey => _instance.navigatorKey;

  static BuildContext? get context => _instance.navigatorKey.currentContext;

  static NavigatorState? get navigator => _instance.navigatorKey.currentState;

  static String get flavorName => _instance.mflavorName;

  static String get apiBaseUrl => _instance.mApiBaseUrl;

  static String get uploadUrl => _instance.mUploadUrl;

  static String get searchUrl => _instance.mSearchUrl;

}

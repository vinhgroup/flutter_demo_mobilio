import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:bxanh_vendor/service/app_lifecycle_observer.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:bxanh_vendor/theme/controllers/theme_controller.dart';
import 'package:bxanh_vendor/theme/dark_theme.dart';
import 'package:bxanh_vendor/theme/light_theme.dart';
import 'package:bxanh_vendor/utill/app_constants.dart';
import 'package:bxanh_vendor/features/splash/screens/splash_screen.dart';
import 'di_container.dart' as di;
import 'features/example_mobilio/controller/mobilio_controller.dart';
import 'firebase_options.dart';
import 'flavor_config.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  final configString = await loadConfig();
  FlavorConfig.initialize(
      flavorName: "Production",
      apiBaseUrl: "${configString["base_url"]}",
      uploadUrl: "${configString["upload_url"]}",
      searchUrl: "${configString["search_url"]}");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  WidgetsBinding.instance.addObserver(AppLifecycleObserver(analytics));
  await FlutterDownloader.initialize(debug: true, ignoreSsl: true);
  await di.init();

  await Permission.notification.isDenied.then((value) {
    if (value) {
      Permission.notification.request();
    }
  });


  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => di.sl<ThemeController>()),
      ChangeNotifierProvider(create: (context) => di.sl<MobilioController>()),
    ],
    child: const MyApp(),
  ));

  setupFCMListeners();
}

Future<Map<String, dynamic>> loadConfig() async {
  final configString = await rootBundle.loadString('assets/config_prod.json');
  return jsonDecode(configString);
}

void setupFCMListeners() {
  FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
    print("New FCM Token: $newToken");
  });
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      navigatorObservers: [observer],
      debugShowCheckedModeBanner: false,
      navigatorKey: FlavorConfig.globalKey,
      theme: Provider.of<ThemeController>(context).darkTheme ? dark : light,
      home: const SplashScreen(),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

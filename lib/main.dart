import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:pagination/firebase_options.dart';
import 'package:pagination/localization/langs.dart';
import 'package:pagination/pages/explore_page.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // when using EasyLocalization
  //await EasyLocalization.ensureInitialized();
  FlutterNativeSplash.remove();
  runApp(
    // *** When using EasyLocalization
    // EasyLocalization(
    //     supportedLocales: const [Locale('en', 'US'), Locale('ar', 'AE')],
    //     path: 'assets/translations',
    //     fallbackLocale: const Locale('ar', 'AE'),
    //     child: MyApp)
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: Langs(),
      fallbackLocale: const Locale('en', 'US'),

      // when using EasyLocalization
      // localizationsDelegates: context.localizationDelegates,
      // supportedLocales: context.supportedLocales,

      locale: const Locale('ar', 'AE'),
      title: 'Pagination app',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const ExplorePage(),
    );
  }
}

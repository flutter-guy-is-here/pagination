import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class LocalizationChacker {
  static changeLang(BuildContext context) {
    // Locale? currentLocale = EasyLocalization.of(context)!.currentLocale;
    if (context.locale == const Locale('en', 'US')) {
      // EasyLocalization.of(context)!.setLocale(const Locale('ar', 'AE'));
      context.setLocale(Locale('ar', 'AE'));
    } else {
      // EasyLocalization.of(context)!.setLocale(const Locale('en', 'US'));
      context.setLocale(Locale('en', 'US'));
    }
    // print('Changeedd toooo: Current locale: ${context.locale.toString()}');
  }

  static void changeLangGetx() {
    if (Get.locale == const Locale('en', 'US')) {
      Get.updateLocale(Locale('ar', 'AE'));
    } else {
      Get.updateLocale(Locale('en', 'US'));
    }
  }
}

// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:maeeen/controller/bookmark_controller.dart';
import 'package:maeeen/controller/category_controller.dart';
import 'package:maeeen/controller/donation_controller.dart';
import 'package:maeeen/controller/hadith_controller.dart';
import 'package:maeeen/controller/dhikr_controller.dart';
import 'package:maeeen/controller/dua_controller.dart';
import 'package:maeeen/controller/localization_controller.dart';
import 'package:maeeen/controller/nearby_mosque_controller.dart';
import 'package:maeeen/controller/noti_sound_controller.dart';
import 'package:maeeen/controller/package_prayer_time_controller.dart';
import 'package:maeeen/controller/todays_prayer_time_controller.dart';
import 'package:maeeen/controller/quran_settings_controller.dart';
import 'package:maeeen/controller/quran_controller.dart';
 import 'package:maeeen/controller/splash_controller.dart';
import 'package:maeeen/controller/theme_controller.dart';
import 'package:maeeen/controller/zakat_calculator_controller.dart';
import 'package:maeeen/data/api/api_client.dart';
import 'package:maeeen/data/model/response/language_model.dart';
import 'package:maeeen/data/repository/dikir_list_repo.dart';
import 'package:maeeen/data/repository/donation_repo.dart';
import 'package:maeeen/data/repository/dua_list_repo.dart';
import 'package:maeeen/data/repository/quran_setting_repo.dart';
import 'package:maeeen/data/repository/sifatname_list_repo.dart';
import 'package:maeeen/data/repository/splash_repo.dart';
 import 'package:maeeen/util/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

Future<Map<String, Map<String, String>>> init() async {
  // Core
  final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL, sharedPreferences: Get.find()));


  // Repository
  Get.lazyPut(() => SplashRepo(sharedPreferences: Get.find(), apiClient: Get.find()));
  Get.lazyPut(() => DuaRepo(sharedPreferences: Get.find(), apiClient: Get.find()));
  Get.lazyPut(() => DhikrRepo(sharedPreferences: Get.find(), apiClient: Get.find()));
  Get.lazyPut(() => QuranRepo(sharedPreferences: Get.find(), apiClient: Get.find()));
  Get.lazyPut(() => QuranSettingsRepo(sharedPreferences: Get.find(), apiClient: Get.find()));
  Get.lazyPut(() => DonationRepo(sharedPreferences: Get.find(), apiClient: Get.find()));

  //new controller
  Get.lazyPut(() => LocalizationController(sharedPreferences: Get.find(), apiClient: Get.find()), fenix: true);
  Get.lazyPut(() => DhikrController(dhikrRepo: Get.find()));
  Get.lazyPut(() => DuaController(duaRepo: Get.find()));
  Get.lazyPut(() => DonationController(donationRepo: Get.find()));
  Get.lazyPut(() => QuranController(quranRepo: Get.find()));
  Get.lazyPut(() => PackagePrayerTimeController());
  Get.lazyPut(() => TodaysPrayerTimeController(apiClient: Get.find()));
  Get.lazyPut(() => NotiSoundController());

  // old controller
  Get.lazyPut(() => ThemeController(sharedPreferences: Get.find()));
  Get.lazyPut(() => SplashController(splashRepo: Get.find()));
  Get.lazyPut(() => HadithController());
  Get.lazyPut(() => NearbyMosqueController());
  Get.lazyPut(() => QuranSettingsController(quranSettingRepo: Get.find()));
  Get.lazyPut(() => BookMarkController());
  Get.lazyPut(() => CategoryListController());
  Get.lazyPut(() => ZakatCalculatorController());

  // Retrieving localized data
  Map<String, Map<String, String>> languages = {};
  for (LanguageModel languageModel in AppConstants.languages) {
    String jsonStringValues = await rootBundle
        .loadString('assets/language/${languageModel.languageCode}.json');
    Map<String, dynamic> mappedJson = json.decode(jsonStringValues);
    Map<String, String> _json = {};
    mappedJson.forEach((key, value) {
      _json[key] = value.toString();
    });
    languages['${languageModel.languageCode}_${languageModel.countryCode}'] =
        _json;
  }
  return languages;
}

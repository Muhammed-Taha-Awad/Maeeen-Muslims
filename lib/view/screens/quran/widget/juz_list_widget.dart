// ignore_for_file: deprecated_member_use
import 'package:zabi/controller/quran_settings_controller.dart';
import 'package:zabi/controller/quran_controller.dart';
import 'package:zabi/helper/route_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:zabi/shimmer/all_shimmer_loder.dart';
import 'package:zabi/util/dimensions.dart';
import 'package:zabi/util/images.dart';
import 'package:zabi/util/styles.dart';
import 'package:google_fonts/google_fonts.dart';

class JuzListWidget extends StatelessWidget {
  const JuzListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<QuranController>().fetchSuraListData();
    Get.find<QuranController>().fetchJuzListData();
    return SingleChildScrollView(
      child: GetBuilder<QuranController>(
        builder: (juzListController) {
          return juzListController.isJuzListLoading.value ||
                  juzListController.juzListApiData == null
              ? const Center(
                  child: QuranListShimmer(),
                )
              : Column(
                  children: [
                    for (var juz = 0;
                        juz < juzListController.juzListApiData!.data!.length;
                        juz++)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // juz name ===>
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: Dimensions.FONT_SIZE_DEFAULT),
                            child: Text(
                              " ${juzListController.juzListApiData!.data![juz].juzTranslateName}: ${juzListController.juzListApiData!.data![juz].juzNumber}",
                              style: robotoMedium.copyWith(
                                fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                          // list view ===>
                          ListView.builder(
                            primary: false,
                            shrinkWrap: true,
                            padding: const EdgeInsets.symmetric(
                                horizontal: Dimensions.PADDING_SIZE_SMALL),
                            itemCount: juzListController
                                .juzListApiData!.data![juz].chapterList!.length,
                            itemBuilder: (context, index) {
                              var apiData = juzListController.juzListApiData!
                                  .data![juz].chapterList![index];
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // card start ==>
                                  GestureDetector(
                                    onTap: () {
                                      Get.find<QuranController>()
                                          .fetchSuraDetaileData(
                                              suraId:
                                                  apiData.chapterId.toString());
                                      Get.toNamed(RouteHelper.suraDetaile);
                                    },
                                    child: Card(
                                      clipBehavior: Clip.antiAlias,
                                      color: Theme.of(context).cardColor,
                                      shadowColor: Get.isDarkMode
                                          ? Colors.grey[800]!
                                          : Colors.grey[200]!,
                                      child: ListTile(
                                        contentPadding:
                                            const EdgeInsetsDirectional.only(
                                                start: Dimensions
                                                    .PADDING_SIZE_EXTRA_SMALL,
                                                end: Dimensions
                                                    .PADDING_SIZE_SMALL),
                                        leading: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              Images.Icon_Star,
                                              height: 50,
                                              fit: BoxFit.fill,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                            Text(
                                              apiData.serialNumber.toString(),
                                              style: robotoMedium.copyWith(
                                                color: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .color,
                                              ),
                                            ),
                                          ],
                                        ),
                                        title: Obx(
                                          () => Text(
                                            apiData.translatedName.toString(),
                                            style: robotoMedium.copyWith(
                                              fontSize: Get.find<
                                                      QuranSettingsController>()
                                                  .translateFontSize
                                                  .value,
                                            ),
                                          ),
                                        ),
                                        subtitle: Obx(
                                          () => Text(
                                            "${apiData.versesTranslateName}: ${apiData.verseNumber}",
                                            style: robotoMedium.copyWith(
                                              fontSize: Get.find<
                                                          QuranSettingsController>()
                                                      .translateFontSize
                                                      .value -
                                                  3,
                                            ),
                                          ),
                                        ),
                                        trailing: Obx(
                                          () => Text(
                                            apiData.arabicName.toString(),
                                            style: GoogleFonts.getFont(
                                              Get.find<
                                                      QuranSettingsController>()
                                                  .selectedFont
                                                  .value,
                                              fontSize: Get.find<
                                                      QuranSettingsController>()
                                                  .arabicFontSize
                                                  .value,
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge!
                                                  .color,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                  ],
                );
        },
      ),
    );
  }
}

// ignore_for_file: deprecated_member_use

import 'package:zabi/controller/quran_settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:zabi/controller/quran_controller.dart';
import 'package:zabi/helper/route_helper.dart';
import 'package:zabi/shimmer/all_shimmer_loder.dart';
import 'package:zabi/util/dimensions.dart';
import 'package:zabi/util/images.dart';
import 'package:zabi/util/styles.dart';
import 'package:google_fonts/google_fonts.dart';

class SuraListWidget extends StatelessWidget {
  const SuraListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuranController>(
      builder: (suraListController) {
        return suraListController.isSuraListLoading.value ||
                suraListController.suraListApiData == null
            ? const Center(
                child: QuranListShimmer(),
              )
            : ListView.builder(
                primary: false,
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_SMALL),
                itemCount: suraListController.suraListApiData!.data!.length,
                itemBuilder: (context, index) {
                  var apiData =
                      suraListController.suraListApiData!.data![index];

                  return GestureDetector(
                    onTap: () {
                      Get.find<QuranController>()
                          .fetchSuraDetaileData(suraId: apiData.id.toString());
                      Get.toNamed(RouteHelper.suraDetaile);
                    },
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      color: Theme.of(context).cardColor,
                      shadowColor: Get.isDarkMode
                          ? Colors.grey[800]!
                          : Colors.grey[200]!,
                      child: ListTile(
                        contentPadding: const EdgeInsetsDirectional.only(
                            start: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                            end: Dimensions.PADDING_SIZE_SMALL),
                        leading: Stack(
                          alignment: Alignment.center,
                          children: [
                            SvgPicture.asset(
                              Images.Icon_Star,
                              height: 50,
                              fit: BoxFit.fill,
                              color: Theme.of(context).primaryColor,
                            ),
                            Text(
                              apiData.serialNumber.toString(),
                              style: elmessiriMedium.copyWith(
                                fontSize: Dimensions.FONT_SIZE_SMALL,
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
                            apiData.translateName.toString(),
                            style: elmessiriMedium.copyWith(
                              fontSize: Get.find<QuranSettingsController>()
                                  .translateFontSize
                                  .value,
                            ),
                          ),
                        ),
                        subtitle: Obx(
                          () => Text(
                            "${apiData.versesTranslateName}: ${apiData.versesCount}",
                            style: elmessiriMedium.copyWith(
                              fontSize: Get.find<QuranSettingsController>()
                                      .translateFontSize
                                      .value -
                                  3,
                              color:
                                  Theme.of(context).textTheme.bodyLarge!.color,
                            ),
                          ),
                        ),
                        trailing: Obx(
                          () => Text(
                            apiData.arabicName.toString(),
                            style: GoogleFonts.getFont(
                              Get.find<QuranSettingsController>()
                                  .selectedFont
                                  .value,
                              fontSize: Get.find<QuranSettingsController>()
                                  .arabicFontSize
                                  .value,
                              color:
                                  Theme.of(context).textTheme.bodyLarge!.color,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
      },
    );
  }
}

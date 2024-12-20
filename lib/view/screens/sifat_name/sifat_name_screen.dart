// ignore_for_file: deprecated_member_use

import 'package:maeeen/controller/quran_settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
 import 'package:maeeen/controller/quran_controller.dart';
import 'package:maeeen/helper/translator_helper.dart';
import 'package:maeeen/shimmer/all_shimmer_loder.dart';
import 'package:maeeen/view/base/custom_app_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../helper/route_helper.dart';
import '../../../util/dimensions.dart';
import '../../../util/images.dart';
import '../../../util/styles.dart';

class SifatNameScreen extends StatelessWidget {
  final bool appBackButton;
  const SifatNameScreen({Key? key, required this.appBackButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<QuranController>().fetchSifatNameListData();
    return GetBuilder<QuranController>(
      builder: (sifatNameListController) {
        return Scaffold(
          // Appbar start ===>
          appBar: CustomAppBar(
            title: "99_names_of_allah".tr,
            isBackButtonExist: appBackButton == true ? true : false,
          ),

          // body start ===>
          body: sifatNameListController.isSifatNameListLoading.value ||
                  sifatNameListController.sifatNameApiData == null
              ? const Center(
            child: AllahNameShimmer(),
          )
              : sifatNameListController.sifatNameApiData!.data!.isEmpty
                  ? Center(
                      child: Text(
                        "no_data_found".tr,
                        style: elmessiriMedium.copyWith(
                            fontSize: Dimensions.FONT_SIZE_LARGE),
                      ),
                    )
                  : SingleChildScrollView(
                      child: ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        itemCount: sifatNameListController
                            .sifatNameApiData!.data!.length,
                        itemBuilder: (context, index) {
                          var apiData = sifatNameListController
                              .sifatNameApiData!.data![index];
                          return GestureDetector(
                            onTap: () {
                              var sifatNameDetailsController =
                                  Get.find<QuranController>();
                              sifatNameDetailsController
                                  .fetchSifatNameDetailsData(
                                      sifatNameId: apiData.id.toString());

                              Get.toNamed(RouteHelper.sifatNameDetaile);
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
                                        start:
                                            Dimensions.PADDING_SIZE_EXTRA_SMALL,
                                        end: Dimensions.PADDING_SIZE_SMALL),
                                horizontalTitleGap: 5,
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
                                      translateText(apiData.id.toString()),
                                      style: elmessiriMedium.copyWith(
                                        fontSize: Dimensions.FONT_SIZE_DEFAULT,
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .color,
                                      ),
                                    ),
                                  ],
                                ),
                                title: Text(
                                  apiData.enName.toString(),
                                  style: elmessiriMedium.copyWith(
                                    fontSize: Dimensions.FONT_SIZE_DEFAULT,
                                  ),
                                ),
                                trailing: Text(
                                  apiData.arName.toString(),
                                  style: GoogleFonts.getFont(
                                    Get.find<QuranSettingsController>()
                                        .selectedFont
                                        .value,
                                    fontSize:
                                        Get.find<QuranSettingsController>()
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
                          );
                        },
                      ),
                    ),
        );
      },
    );
  }
}

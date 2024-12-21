import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maeeen/util/dimensions.dart';
import 'package:maeeen/util/styles.dart';

Widget tabBarButton(String label, BuildContext context) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(
      vertical: Dimensions.PADDING_SIZE_SMALL,
      horizontal: Dimensions.PADDING_SIZE_SMALL,
    ),
    decoration: BoxDecoration(
      border: Border.all(color: Theme.of(context).primaryColor),
      borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
    ),
    child: Text(
      label.tr,
      textAlign: TextAlign.center,
      style: elmessiriMedium.copyWith(
        color: Get.isDarkMode
            ? Theme.of(context).textTheme.bodyMedium!.color
            : Theme.of(context).hintColor,
      ),
    ),
  );
}

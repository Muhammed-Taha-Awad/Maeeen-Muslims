import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:maeeen/controller/noti_sound_controller.dart';
import 'package:maeeen/helper/salat_waqt_service.dart';
import 'package:maeeen/util/dimensions.dart';
import 'package:maeeen/util/styles.dart';

class NotificationSoundSelector extends StatefulWidget {
  const NotificationSoundSelector({super.key});

  @override
  State<NotificationSoundSelector> createState() =>
      _NotificationSoundSelectorState();
}

class _NotificationSoundSelectorState extends State<NotificationSoundSelector> {
  @override
  void dispose() {
    super.dispose();
    AudioPlayer().dispose();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(NotiSoundController());
    return GetBuilder<NotiSoundController>(
      builder: (notiController) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.FONT_SIZE_DEFAULT),
              child: Text(
                "choose_sound_for_notification".tr,
                style: elmessiriMedium.copyWith(
                  fontSize: Dimensions.FONT_SIZE_LARGE,
                ),
              ),
            ),
            ListView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount: notiController.sounds.length,
              itemBuilder: (context, index) {
                return Obx(
                  () => Card(
                    clipBehavior: Clip.antiAlias,
                    color: Theme.of(context).cardColor,
                    shadowColor:
                        Get.isDarkMode ? Colors.grey[800]! : Colors.grey[200]!,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
                    ),
                    child: RadioListTile(
                      title: Text(
                        notiController.sounds[index]['name']!,
                        style: elmessiriMedium.copyWith(
                          fontSize: Dimensions.FONT_SIZE_LARGE,
                        ),
                      ),
                      value: notiController.sounds[index]['path'],
                      groupValue: notiController.selectedSound.value,
                      onChanged: (value) {
                        notiController.selectSound(value);
                        SalatWaqtService.initializeSalatWaqt();
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}

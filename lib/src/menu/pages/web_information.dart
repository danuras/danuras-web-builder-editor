import 'dart:io';

import 'package:danuras_web_service_editor/src/menu/components/http/custom_future_builder.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/custom_button.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/input_square_image.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/input_type_Bar.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/input_type_icon.dart';
import 'package:danuras_web_service_editor/src/model/web_attribute.dart';
import 'package:danuras_web_service_editor/src/view_controller/controller/web_attribute_controller.dart';
import 'package:flutter/material.dart';

class WebInformation extends StatefulWidget {
  const WebInformation({super.key});
  static const routeName = '/web-information';

  @override
  State<WebInformation> createState() => _WebInformationState();
}

class _WebInformationState extends State<WebInformation> {
  TextEditingController titleController = TextEditingController(text: '');
  TextEditingController shortDescriptionController =
      TextEditingController(text: '');
  TextEditingController longTitleController = TextEditingController(text: '');
  TextEditingController mainHeadingController = TextEditingController(text: '');
  TextEditingController subHeadingController = TextEditingController(text: '');
  File? icon, backgroundImage;
  String? iconUrl, backgroundImageUrl;

  WebAttributeController wac = WebAttributeController();

  ValueNotifier<String?> titleError = ValueNotifier(null);
  ValueNotifier<String?> shortDescriptionError = ValueNotifier(null);
  ValueNotifier<String?> longTitleError = ValueNotifier(null);
  ValueNotifier<String?> mainHeadingError = ValueNotifier(null);
  ValueNotifier<String?> subHeadingError = ValueNotifier(null);
  ValueNotifier<String?> iconError = ValueNotifier(null);
  ValueNotifier<String?> backgroundImageError = ValueNotifier(null);
  ValueNotifier<bool> refresher = ValueNotifier(false);

  late WebAttribute wa;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Informasi Web'),
          backgroundColor: const Color(0xff110011),
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/images/background.jpeg',
              ),
              fit: BoxFit.cover,
            ),
            color: Colors.black,
          ),
          child: Container(
            color: const Color(0x88110011),
            child: RefreshIndicator(
              onRefresh: ()async {
                refresher.value = !refresher.value;
              },
              color: const Color(0xffffffff),
              backgroundColor: const Color(0xff110011),
              child: ValueListenableBuilder(
                valueListenable: refresher,
                builder: (context,r, child) {
                  return CustomFutureBuilder(
                    future: wac.show(),
                    widgetResult: (result) {
                      if (result['data'] != null) {
                        wa = result['data'];
                        titleController.text = wa.title;
                        shortDescriptionController.text = wa.shortDescription;
                        longTitleController.text = wa.longTitle;
                        mainHeadingController.text = wa.mainHeading;
                        subHeadingController.text = wa.subHeading;
                        backgroundImageUrl = wa.backgroundImage;
                        iconUrl = wa.icon;
                      }
                      return Padding(
                        padding: const EdgeInsets.only(
                          left: 8.0,
                          right: 8.0,
                        ),
                        child: ListView(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                InputTypeIcon(
                                  action: (ico) {
                                    icon = ico;
                                  },
                                  label: 'Ikon',
                                  tooltip: 'Ikon Perusahaan',
                                  iconError: iconError,
                                  iconUrl: iconUrl,
                                  icon: icon,
                                ),
                                const SizedBox(
                                  width: 8.0,
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      InputTypeBar(
                                        labelText: 'Nama Brand',
                                        errorText: titleError,
                                        tooltip:
                                            'Nama brand adalah identitas usaha anda. Pastikan nama ini mencerminkan nilai, visi, dan kesan yang ingin Anda sampaikan kepada pelanggan anda.',
                                        controller: titleController,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      InputTypeBar(
                                        labelText: 'Nama Panjang Brand',
                                        errorText: longTitleError,
                                        controller: longTitleController,
                                        tooltip:
                                            'Nama panjang brand atau usaha anda yang akan ditampilkan di footer',
                                        maxLines: 2,
                                      ),
                                    ],
                                  ),
                                ), 
                              ],
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            InputTypeBar(
                              labelText: 'Heading Utama',
                              tooltip:
                                  'Judul ini menjadi penanda utama bagi website Anda. Pastikan untuk membuatnya menarik dan informatif agar pengunjung tertarik untuk menjelajah lebih lanjut!',
                              errorText: mainHeadingError,
                              controller: mainHeadingController,
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            InputTypeBar(
                              labelText: 'Sub Heading',
                              tooltip:
                                  'Sub heading adalah kesempatan untuk memberikan informasi tambahan yang menarik perhatian. Gunakan dengan bijak untuk menjelaskan lebih lanjut tentang konten utama website anda.',
                              errorText: subHeadingError,
                              controller: subHeadingController,
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            InputSquareImage(
                              action: (image) {
                                backgroundImage = image;
                              },
                              imageError: backgroundImageError,
                              imageUrl: backgroundImageUrl,
                              label: 'Gambar Background Header',
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            CustomButton(
                              text: 'Simpan',
                              action: () async {
                                await wac.createOrUpdate(
                                  title: titleController.text,
                                  shortDescription: shortDescriptionController.text,
                                  longTitle: longTitleController.text,
                                  mainHeading: mainHeadingController.text,
                                  subHeading: subHeadingController.text,
                                  icon: icon,
                                  backgroundImage: backgroundImage,
                                  context: context,
                                  action: () {},
                                  action400: (errors) {
                                    resetError();
                                    checkError(errors);
                                  },
                                );
                              },
                            ),
                            const SizedBox(
                              height: 32.0,
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              ),
            ),
          ),
        ),
      ),
    );
  }

  void resetError() {
    titleError.value = null;
    shortDescriptionError.value = null;
    longTitleError.value = null;
    mainHeadingError.value = null;
    subHeadingError.value = null;
    backgroundImageError.value = null;
    iconError.value = null;
  }

  void checkError(errors) {
    if (errors.containsKey('title')) {
      titleError.value = errors['title'][0];
    }
    if (errors.containsKey('short_description')) {
      shortDescriptionError.value = errors['short_description'][0];
    }
    if (errors.containsKey('long_title')) {
      longTitleError.value = errors['long_title'][0];
    }
    if (errors.containsKey('main_heading')) {
      mainHeadingError.value = errors['main_heading'][0];
    }
    if (errors.containsKey('sub_heading')) {
      subHeadingError.value = errors['sub_heading'][0];
    }
    if (errors.containsKey('background_image')) {
      backgroundImageError.value = errors['background_image'][0];
    }
    if (errors.containsKey('icon')) {
      iconError.value = errors['icon'][0];
    }
    if (errors.containsKey('background_testimonies')) {
    }
  }
}

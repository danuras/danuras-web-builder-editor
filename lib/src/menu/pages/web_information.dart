import 'dart:io';

import 'package:danuras_web_service_editor/src/menu/components/widget/custom_button.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/input_square_image.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/input_type_Bar.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/input_type_icon.dart';
import 'package:flutter/material.dart';

class WebInformation extends StatelessWidget {
  const WebInformation({super.key});
  static const routeName = '/web-information';

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController(text: '');
    TextEditingController longTitleController = TextEditingController(text: '');
    TextEditingController headingController = TextEditingController(text: '');
    TextEditingController subHeadingController =
        TextEditingController(text: '');
    ValueNotifier<String?> titleError = ValueNotifier(null);
    ValueNotifier<String?> longTitleError = ValueNotifier(null);
    ValueNotifier<String?> headingError = ValueNotifier(null);
    ValueNotifier<String?> subHeadingError = ValueNotifier(null);
    File? icon, backgroundImage, backgroundTestimony;

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
            child: Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
                right: 8.0,
                top: 16.0,
              ),
              child: ListView(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InputTypeIcon(
                        action: (ico) {
                          icon = ico;
                        },
                        label: 'Ikon',
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
                    errorText: headingError,
                    controller: headingController,
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
                    imageError: subHeadingError,
                    label: 'Gambar Background Header',
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  InputSquareImage(
                    action: (image) {
                      backgroundTestimony = image;
                    },
                    imageError: subHeadingError,
                    label: 'Gambar Background Testimoni',
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  CustomButton(text: 'Simpan', action: (){}),
                  const SizedBox(
                    height: 32.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

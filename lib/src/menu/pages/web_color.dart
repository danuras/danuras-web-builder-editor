import 'dart:io';

import 'package:danuras_web_service_editor/src/menu/components/widget/custom_button.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/input_square_image.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/input_type_Bar.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/input_type_color.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/input_type_icon.dart';
import 'package:flutter/material.dart';

class WebColor extends StatelessWidget {
  const WebColor({super.key});
  static const routeName = '/web-color';

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
          title: const Text('Warna Web'),
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
                  InputTypeColor(
                    labelText: 'Teks navigasi dan heading',
                    errorText: titleError,
                    controller: titleController,
                    tooltip:
                        'Warna dari teks di heading, navigasi, dan judul web',
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  InputTypeColor(
                    labelText: 'Teks lainya',
                    errorText: titleError,
                    controller: titleController,
                    tooltip:
                        'Warna dari teks di selain heading, navigasi, dan judul web',
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  InputTypeColor(
                    labelText: 'Warna Background 1',
                    errorText: titleError,
                    controller: titleController,
                    tooltip:
                        'Pada website terdapat dua jenis warna background.',
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  InputTypeColor(
                    labelText: 'Warna Background 2',
                    errorText: titleError,
                    controller: titleController,
                    tooltip:
                        'Pada website terdapat dua jenis warna background.',
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  InputTypeColor(
                    labelText: 'Warna Kartu',
                    errorText: titleError,
                    controller: titleController,
                    tooltip:
                        'Warna dari kartu yang ditampilkan di web',
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  InputTypeColor(
                    labelText: 'Warna Utama',
                    errorText: titleError,
                    controller: titleController,
                    tooltip:
                        'Warna yang digunakan untuk mewarnai tombol.',
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  
                  CustomButton(text: 'Simpan', action: () {}),
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

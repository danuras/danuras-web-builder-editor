import 'dart:io';

import 'package:danuras_web_service_editor/src/menu/components/http/custom_future_builder.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/card/list_card.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/custom_button.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/input_square_image.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/input_type_bar.dart';
import 'package:danuras_web_service_editor/src/menu/pages/auth/input_email.dart';
import 'package:danuras_web_service_editor/src/model/advantage.dart';
import 'package:danuras_web_service_editor/src/model/advantage_content.dart';
import 'package:danuras_web_service_editor/src/model/card_box.dart';
import 'package:danuras_web_service_editor/src/model/card_model.dart';
import 'package:danuras_web_service_editor/src/view_controller/controller/advantage_controller.dart';
import 'package:danuras_web_service_editor/src/view_controller/controller/auth_controller.dart';
import 'package:danuras_web_service_editor/src/view_controller/controller/card_box_controller.dart';
import 'package:flutter/material.dart';

class EditSectionAdvantage extends StatefulWidget {
  const EditSectionAdvantage({
    super.key,
  });
  static const routeName = '/web-content/edit-section-advantage';

  @override
  State<EditSectionAdvantage> createState() => _EditSectionAdvantageState();
}

class _EditSectionAdvantageState extends State<EditSectionAdvantage> {
  TextEditingController titleController = TextEditingController(text: '');
  TextEditingController descriptionController = TextEditingController(text: '');
  File? image;

  ValueNotifier<String?> titleError = ValueNotifier(null);
  ValueNotifier<String?> descriptionError = ValueNotifier(null);
  ValueNotifier<String?> imageError = ValueNotifier(null);

  ValueNotifier<bool> refresher = ValueNotifier(false);

  AdvantageController ac = AdvantageController();
  late Advantage a;
  List<AdvantageContent> lac = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Edit Bagian Keunggulan'),
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
              onRefresh: () async {
                refresher.value = !refresher.value;
              },
              child: ValueListenableBuilder(
                valueListenable: refresher,
                builder: (context, r, child) {
                  return CustomFutureBuilder(
                    future: ac.show(),
                    widgetResult: (result) {
                      a = result['data']['advantage'];
                      lac = result['data']['advantage_contents'];
                      titleController.text = a.title;
                      descriptionController.text = a.description;
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
                            InputTypeBar(
                              labelText: 'Judul',
                              tooltip:
                                  'Masukan judul bagian yang menampilkan kartu',
                              errorText: titleError,
                              controller: titleController,
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            InputTypeBar(
                              labelText: 'Info',
                              tooltip:
                                  'Masukan informasi tambahan untuk bagian ini',
                              errorText: descriptionError,
                              controller: descriptionController,
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            InputSquareImage(
                              action: (out) {
                                image = out;
                              },
                              imageError: imageError,
                              imageUrl: a.imageUrl,
                              label:
                                  'Gambar yang ditampilkan di halaman keunggulan',
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            CustomButton(
                              text: 'Simpan',
                              action: () async {
                                resetError();
                                await ac.createOrUpdate(
                                  title: titleController.text,
                                  description: descriptionController.text,
                                  context: context,
                                  imageUrl: image,
                                  action: () {},
                                  action400: (errors) {
                                    checkError(errors);
                                  },
                                );
                              },
                            ),
                            ListCard(lcm: lac, cardType: '', contentType: 'advantage'),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  void resetError() {
    descriptionError.value = null;
    titleError.value = null;
    imageError.value = null;
  }

  void checkError(errors) {
    if (errors.containsKey('info')) {
      descriptionError.value = errors['info'][0];
    }
    if (errors.containsKey('title')) {
      titleError.value = errors['title'][0];
    }
    if (errors.containsKey('image_url')) {
      imageError.value = errors['image_url'][0];
    }
  }
}

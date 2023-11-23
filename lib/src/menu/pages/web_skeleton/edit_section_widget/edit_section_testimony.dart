import 'dart:io';

import 'package:danuras_web_service_editor/src/menu/components/http/custom_future_builder.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/card/list_card.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/custom_button.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/input_square_image.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/input_type_bar.dart';
import 'package:danuras_web_service_editor/src/menu/pages/auth/input_email.dart';
import 'package:danuras_web_service_editor/src/menu/pages/card/add/add_card_testimony.dart';
import 'package:danuras_web_service_editor/src/model/advantage.dart';
import 'package:danuras_web_service_editor/src/model/card_box.dart';
import 'package:danuras_web_service_editor/src/model/card_model.dart';
import 'package:danuras_web_service_editor/src/model/testimony.dart';
import 'package:danuras_web_service_editor/src/view_controller/api/testimony_api_controller.dart';
import 'package:danuras_web_service_editor/src/view_controller/controller/advantage_controller.dart';
import 'package:danuras_web_service_editor/src/view_controller/controller/auth_controller.dart';
import 'package:danuras_web_service_editor/src/view_controller/controller/card_box_controller.dart';
import 'package:danuras_web_service_editor/src/view_controller/controller/testimony_controller.dart';
import 'package:flutter/material.dart';

class EditSectionTestimony extends StatefulWidget {
  const EditSectionTestimony({
    super.key,
  });
  static const routeName = '/web-content/edit-section-testimony';

  @override
  State<EditSectionTestimony> createState() => _EditSectionTestimonyState();
}

class _EditSectionTestimonyState extends State<EditSectionTestimony> {
  File? image;

  ValueNotifier<String?> imageError = ValueNotifier(null);

  ValueNotifier<bool> refresher = ValueNotifier(false);
  ValueNotifier<bool> refresherResult = ValueNotifier(false);

  TestimonyController tc = TestimonyController();
  late String backgroundUrl;
  List<Testimony> lt = [];

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
          title: const Text('Edit Bagian Testimoni'),
          backgroundColor: const Color(0xff110011),
        ),
        floatingActionButton: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
                AddCardTestimony.routeName,
                arguments: <String, dynamic>{
                  'tc': tc,
                  'action': (t) {
                    lt.add(t);
                    refresherResult.value = !refresherResult.value;
                  },
                },
              );
          },
          child: Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: const Color(0xff110011),
              borderRadius: const BorderRadius.all(Radius.circular(35)),
              border: Border.all(width: 2, color: Colors.white),
            ),
            child: const Icon(
              Icons.add,
              color: Colors.white,
              size: 50,
            ),
          ),
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
              color: const Color(0xffffffff),
              backgroundColor: const Color(0xff110011),
              child: ValueListenableBuilder(
                valueListenable: refresher,
                builder: (context, r, child) {
                  return CustomFutureBuilder(
                    future: tc.show(),
                    widgetResult: (result) {
                      backgroundUrl = result['data']['background_testimonies'];
                      lt = result['data']['testimonies'];
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
                            InputSquareImage(
                              action: (out) {
                                image = out;
                              },
                              imageError: imageError,
                              imageUrl: backgroundUrl,
                              label: 'Gambar background tampilan testimoni',
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            CustomButton(
                              text: 'Simpan',
                              action: () async {
                                resetError();
                                await tc.updateBackground(
                                  context: context,
                                  background: image,
                                  action: (a) {},
                                  action400: (errors) {
                                    checkError(errors);
                                  },
                                );
                              },
                            ),
                            ValueListenableBuilder(
                              valueListenable: refresherResult,
                              builder: (context,rr, child) {
                                return ListCard(
                                  lcm: lt,
                                  contentType: 'testimony',
                                  controller: tc,
                                  cardType: '',
                                );
                              }
                            ),
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
    imageError.value = null;
  }

  void checkError(errors) {
    if (errors.containsKey('image_url')) {
      imageError.value = errors['image_url'][0];
    }
  }
}

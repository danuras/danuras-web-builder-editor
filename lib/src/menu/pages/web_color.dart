import 'dart:io';

import 'package:danuras_web_service_editor/src/menu/components/http/custom_future_builder.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/custom_button.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/input_square_image.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/input_type_Bar.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/input_type_color.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/input_type_icon.dart';
import 'package:danuras_web_service_editor/src/model/color_model.dart';
import 'package:danuras_web_service_editor/src/view_controller/controller/color_controller.dart';
import 'package:flutter/material.dart';

class WebColor extends StatefulWidget {
  const WebColor({super.key});
  static const routeName = '/web-color';

  @override
  State<WebColor> createState() => _WebColorState();
}

class _WebColorState extends State<WebColor> {
  ColorController cc = ColorController();

  TextEditingController textHeaderController = TextEditingController(text: '');
  TextEditingController textCommonController = TextEditingController(text: '');
  TextEditingController background1Controller = TextEditingController(text: '');
  TextEditingController background2Controller = TextEditingController(text: '');
  TextEditingController cardController = TextEditingController(text: '');
  TextEditingController highlightController = TextEditingController(text: '');

  ValueNotifier<String?> textHeaderError = ValueNotifier(null);
  ValueNotifier<String?> textCommonError = ValueNotifier(null);
  ValueNotifier<String?> background1Error = ValueNotifier(null);
  ValueNotifier<String?> background2Error = ValueNotifier(null);
  ValueNotifier<String?> cardError = ValueNotifier(null);
  ValueNotifier<String?> highlightError = ValueNotifier(null);

  ValueNotifier<bool> refresher = ValueNotifier(false);

  late ColorModel cm;

  @override
  Widget build(BuildContext context) {
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
            child: RefreshIndicator(
              onRefresh: () async {
                refresher.value = !refresher.value;
              },
              child: ValueListenableBuilder(
                  valueListenable: refresher,
                  builder: (context, r, child) {
                    return CustomFutureBuilder(
                        future: cc.show(),
                        widgetResult: (result) {
                          cm = result['data'];
                          textHeaderController.text =
                              cm.headerTextColor!.substring(1);
                          textCommonController.text =
                              cm.commonTextColor!.substring(1);
                          background1Controller.text =
                              cm.backgroundColor1!.substring(1);
                          background2Controller.text =
                              cm.backgroundColor2!.substring(1);
                          cardController.text = cm.cardColor!.substring(1);
                          highlightController.text =
                              cm.highlightColor!.substring(1);
                          return Padding(
                            padding: const EdgeInsets.only(
                              left: 8.0,
                              right: 8.0,
                              top: 16.0,
                            ),
                            child: ListView(
                              children: [
                                InputTypeColor(
                                  labelText: 'Teks navigasi dan heading',
                                  errorText: textHeaderError,
                                  controller: textHeaderController,
                                  tooltip:
                                      'Warna dari teks di heading, navigasi, dan judul web',
                                ),
                                const SizedBox(
                                  height: 8.0,
                                ),
                                InputTypeColor(
                                  labelText: 'Teks lainya',
                                  errorText: textCommonError,
                                  controller: textCommonController,
                                  tooltip:
                                      'Warna dari teks di selain heading, navigasi, dan judul web',
                                ),
                                const SizedBox(
                                  height: 8.0,
                                ),
                                InputTypeColor(
                                  labelText: 'Warna Background 1',
                                  errorText: background1Error,
                                  controller: background1Controller,
                                  tooltip:
                                      'Pada website terdapat dua jenis warna background.',
                                ),
                                const SizedBox(
                                  height: 8.0,
                                ),
                                InputTypeColor(
                                  labelText: 'Warna Background 2',
                                  errorText: background2Error,
                                  controller: background2Controller,
                                  tooltip:
                                      'Pada website terdapat dua jenis warna background.',
                                ),
                                const SizedBox(
                                  height: 8.0,
                                ),
                                InputTypeColor(
                                  labelText: 'Warna Kartu',
                                  errorText: cardError,
                                  controller: cardController,
                                  tooltip:
                                      'Warna dari kartu yang ditampilkan di web',
                                ),
                                const SizedBox(
                                  height: 8.0,
                                ),
                                InputTypeColor(
                                  labelText: 'Warna Utama',
                                  errorText: highlightError,
                                  controller: highlightController,
                                  tooltip:
                                      'Warna yang digunakan untuk mewarnai tombol.',
                                ),
                                const SizedBox(
                                  height: 8.0,
                                ),
                                CustomButton(
                                  text: 'Simpan',
                                  action: () async {
                                    resetError();
                                    await cc.createOrUpdate(
                                      colorModel: ColorModel.fromJson({
                                        'header_text_color':
                                            '#${textHeaderController.text}',
                                        'common_text_color':
                                            '#${textCommonController.text}',
                                        'background_color_1':
                                            '#${background1Controller.text}',
                                        'background_color_2':
                                            '#${background2Controller.text}',
                                        'card_color': '#${cardController.text}',
                                        'highlight_color':
                                            '#${highlightController.text}',
                                      }),
                                      context: context,
                                      action: () {},
                                      action400: (errors) {
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
                        });
                  }),
            ),
          ),
        ),
      ),
    );
  }

  void resetError() {
    textHeaderError.value = null;
    textCommonError.value = null;
    background1Error.value = null;
    background2Error.value = null;
    cardError.value = null;
    highlightError.value = null;
  }

  void checkError(errors) {
    if (errors.containsKey('header_text_color')) {
      textHeaderError.value = errors['header_text_color'][0];
    }
    if (errors.containsKey('common_text_color')) {
      textCommonError.value = errors['common_text_color'][0];
    }
    if (errors.containsKey('background_color_1')) {
      textCommonError.value = errors['background_color_1'][0];
    }
    if (errors.containsKey('background_color_2')) {
      textCommonError.value = errors['background_color_2'][0];
    }
    if (errors.containsKey('card_color')) {
      textCommonError.value = errors['card_color'][0];
    }
    if (errors.containsKey('highlight_color')) {
      textCommonError.value = errors['highlight_color'][0];
    }
  }
}

import 'dart:io';

import 'package:danuras_web_service_editor/src/menu/components/widget/custom_button.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/input_html_editor.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/input_square_image.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/input_type_Bar.dart';
import 'package:danuras_web_service_editor/src/model/card_model.dart';
import 'package:danuras_web_service_editor/src/view_controller/controller/card_controller.dart';
import 'package:flutter/material.dart';

class AddCard1 extends StatefulWidget {
  const AddCard1({
    super.key,
    required this.cardBoxId,
    required this.cc,
    required this.action,
  });
  static const routeName = '/add-card-1';
  final int cardBoxId;
  final CardController cc;
  final Function(CardModel cm) action;

  @override
  State<AddCard1> createState() => _AddCard1State();
}

class _AddCard1State extends State<AddCard1> {
  String? text;
  TextEditingController linkController = TextEditingController(text: '');
  File? image;

  ValueNotifier<String?> textError = ValueNotifier(null);
  ValueNotifier<String?> linkError = ValueNotifier(null);
  ValueNotifier<String?> imageError = ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Tambah Data'),
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
              ),
              child: ListView(
                children: [
                  const SizedBox(
                    height: 10.0,
                  ),
                  InputSquareImage(
                    action: (out) {
                      image = out;
                    },
                    imageError: imageError,
                    label: 'Gambar dari kartu',
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  InputTypeBar(
                    labelText: 'link',
                    tooltip:
                        'Masukan link yang menunjukan keterangan lebih lanjut dari kartu ini (misal link youtube).',
                    errorText: linkError,
                    controller: linkController,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  InputHtmlEditor(
                    title: 'Teks',
                    tooltip:
                        'Masukan informasi tambahan untuk kartu misal nama proyek, spesifikasi produk, dan sebagainya.',
                    error: textError,
                    changeText: ((changed) => text = changed),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  CustomButton(
                    text: 'Tambah',
                    action: () async {
                      resetError();
                      await widget.cc.create(
                        card: CardModel.fromJson({
                          'card_box_id': widget.cardBoxId,
                          'text': text,
                          'link': linkController.text,
                        }),
                        imageUrl: image,
                        context: context,
                        action: widget.action,
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
            ),
          ),
        ),
      ),
    );
  }

  void resetError() {
    textError.value = null;
    linkError.value = null;
    imageError.value = null;
  }

  void checkError(errors) {
    if (errors.containsKey('text')) {
      textError.value = errors['text'][0];
    }
    if (errors.containsKey('link')) {
      linkError.value = errors['link'][0];
    }
    if (errors.containsKey('image_url')) {
      imageError.value = errors['image_url'][0];
    }
  }
}

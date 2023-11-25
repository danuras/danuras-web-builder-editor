import 'dart:io';

import 'package:danuras_web_service_editor/src/menu/components/widget/custom_button.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/input_html_editor.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/input_square_image.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/input_type_Bar.dart';
import 'package:danuras_web_service_editor/src/model/card_model.dart';
import 'package:danuras_web_service_editor/src/view_controller/controller/card_controller.dart';
import 'package:flutter/material.dart';

class EditCard1 extends StatefulWidget {
  const EditCard1({
    super.key,
    required this.cm,
    required this.cc,
    required this.action,
  });
  static const routeName = '/edit-card-1';
  final CardModel cm;
  final CardController cc;
  final Function(CardModel cm) action;

  @override
  State<EditCard1> createState() => _EditCard1State();
}

class _EditCard1State extends State<EditCard1> {
  String? text;
  TextEditingController linkController = TextEditingController(text: '');
  File? image;
  String? imageUrl;

  ValueNotifier<String?> textError = ValueNotifier(null);
  ValueNotifier<String?> linkError = ValueNotifier(null);
  ValueNotifier<String?> imageError = ValueNotifier(null);

  @override
  void initState() {
    text = widget.cm.text;
    imageUrl = widget.cm.imageUrl;
    linkController.text = widget.cm.link??'';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Ubah Data Kartu'),
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
                    imageUrl: imageUrl,
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
                    initialString: widget.cm.text,
                    changeText: ((changed) => text = changed),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  CustomButton(
                    text: 'Simpan',
                    action: () async {
                      resetError();
                      await widget.cc.update(
                        card: CardModel.fromJson({
                          'id': widget.cm.id,
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

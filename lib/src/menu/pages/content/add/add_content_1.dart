import 'dart:io';

import 'package:danuras_web_service_editor/src/menu/components/widget/custom_button.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/input_html_editor.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/input_square_image.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/input_type_Bar.dart';
import 'package:danuras_web_service_editor/src/model/card_type.dart';
import 'package:danuras_web_service_editor/src/view_controller/controller/card_type_controller.dart';
import 'package:flutter/material.dart';

class AddContent1 extends StatefulWidget {
  const AddContent1({
    super.key,
    required this.cardId,
    required this.ctc,
    required this.action,
  });
  static const routeName = '/add-content-1';
  final int cardId;
  final CardTypeController ctc;
  final Function(String contetType) action;

  @override
  State<AddContent1> createState() => _AddContent1State();
}

class _AddContent1State extends State<AddContent1> {
  String? text;
  TextEditingController whatsappMessageController =
      TextEditingController(text: '');
  TextEditingController titleController = TextEditingController(text: '');
  TextEditingController descriptionController = TextEditingController(text: '');
  TextEditingController subContentController = TextEditingController(text: '');
  File? image;

  ValueNotifier<String?> textError = ValueNotifier(null);
  ValueNotifier<String?> descriptionError = ValueNotifier(null);
  ValueNotifier<String?> whatsappMessageError = ValueNotifier(null);
  ValueNotifier<String?> titleError = ValueNotifier(null);
  ValueNotifier<String?> imageError = ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Tambah Isian Kartu'),
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
                    label: 'Gambar dari isi kartu',
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  InputTypeBar(
                    labelText: 'Judul',
                    tooltip: 'Masukan bagian judul dari konten.',
                    errorText: titleError,
                    controller: titleController,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  InputTypeBar(
                    labelText: 'Sub Judul',
                    tooltip: 'Masukan bagian sub judul dari konten.',
                    errorText: ValueNotifier(null),
                    controller: subContentController,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  InputTypeBar(
                    labelText: 'Deskripsi',
                    tooltip: 'Deskripsikan isi dari kartu.',
                    errorText: descriptionError,
                    controller: descriptionController,
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
                  InputTypeBar(
                    labelText: 'Pesan instan',
                    tooltip:
                        'Masukan pesan instan yang dapat otomatis dimasukan ketika pengunjung ingin menghubungi anda lewat whatsapp',
                    errorText: whatsappMessageError,
                    controller: whatsappMessageController,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  CustomButton(
                    text: 'Tambah',
                    action: () async {
                      resetError();
                      await widget.ctc.create(
                        cardType: CardType.fromJson({
                          'card_id': widget.cardId,
                          'text': text,
                          'title': titleController.text,
                          'description': descriptionController.text,
                          'sub_content_title': subContentController.text,
                          'whatsapp_message': whatsappMessageController.text,
                        }),
                        contentType: 'content-1',
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
    descriptionError.value = null;
    titleError.value = null;
    whatsappMessageError.value = null;
    imageError.value = null;
  }

  void checkError(errors) {
    if (errors.containsKey('text')) {
      textError.value = errors['text'][0];
    }
    if (errors.containsKey('title')) {
      titleError.value = errors['title'][0];
    }
    if (errors.containsKey('description')) {
      descriptionError.value = errors['description'][0];
    }
    if (errors.containsKey('whatsapp_message')) {
      whatsappMessageError.value = errors['whatsapp_message'][0];
    }
    if (errors.containsKey('image_url')) {
      imageError.value = errors['image_url'][0];
    }
  }
}

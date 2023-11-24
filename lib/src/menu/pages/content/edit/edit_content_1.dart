import 'dart:io';

import 'package:danuras_web_service_editor/src/menu/components/http/custom_future_builder.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/card/list_card_content.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/custom_button.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/input_html_editor.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/input_square_image.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/input_type_Bar.dart';
import 'package:danuras_web_service_editor/src/menu/pages/card/add/add_card_content_1.dart';
import 'package:danuras_web_service_editor/src/model/card_type.dart';
import 'package:danuras_web_service_editor/src/model/content_type.dart' as ctm;

import 'package:danuras_web_service_editor/src/view_controller/controller/card_type_controller.dart';
import 'package:danuras_web_service_editor/src/view_controller/controller/content_type_controller.dart';
import 'package:flutter/material.dart';

class EditContent1 extends StatefulWidget {
  const EditContent1({
    super.key,
    required this.cardId,
    required this.ctc,
    required this.contentType,
    required this.action,
  });
  static const routeName = '/edit-content-1';
  final int cardId;
  final String contentType;
  final CardTypeController ctc;
  final Function() action;

  @override
  State<EditContent1> createState() => _EditContent1State();
}

class _EditContent1State extends State<EditContent1> {
  String? text;
  TextEditingController whatsappMessageController =
      TextEditingController(text: '');
  TextEditingController titleController = TextEditingController(text: '');
  TextEditingController subContentController = TextEditingController(text: '');
  File? image;

  ValueNotifier<String?> textError = ValueNotifier(null);
  ValueNotifier<String?> whatsappMessageError = ValueNotifier(null);
  ValueNotifier<String?> titleError = ValueNotifier(null);
  ValueNotifier<String?> imageError = ValueNotifier(null);

  ValueNotifier<bool> refresher = ValueNotifier(false);
  ValueNotifier<bool> refresherResult = ValueNotifier(false);

  ContentTypeController contentTypeController = ContentTypeController();

  late CardType ct;
  List<ctm.ContentType> lct = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              AddCardContent1.routeName,
              arguments: <String, dynamic>{
                'ctc': contentTypeController,
                'action': (b) {
                  lct.add(b);
                  refresherResult.value = !refresherResult.value;
                },
                'card_type_id': ct.id,
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
        appBar: AppBar(
          title: const Text('Ubah Isi Kartu'),
          backgroundColor: const Color(0xff110011),
          actions: [
            IconButton(
              onPressed: () {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    backgroundColor: const Color(0xff110011),
                    title: const Text(
                      'Anda yakin ingin menghapus data ini?',
                      style: TextStyle(color: Colors.white),
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Tidak'),
                        child: const Text(
                          'Tidak',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          await widget.ctc
                              .delete(ct.id!, context, widget.action);
                          if (context.mounted) {
                            Navigator.of(context).pop();
                          }
                        },
                        child: const Text(
                          'Ya',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
          ],
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
            child: CustomFutureBuilder(
                future: widget.ctc.show(widget.cardId),
                widgetResult: (result) {
                  ct = result['data']['card_type'];
                  lct = result['data']['content_types'];
                  whatsappMessageController.text = ct.whatsappMessage!;
                  titleController.text = ct.title!;
                  subContentController.text = ct.subContentTitle ?? '';
                  return ValueListenableBuilder(
                    valueListenable: refresherResult,
                    builder: (context, rr, child) {
                      return Padding(
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
                              imageUrl: ct.imageUrl,
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
                            InputHtmlEditor(
                              title: 'Teks',
                              tooltip:
                                  'Masukan informasi tambahan untuk kartu misal nama proyek, spesifikasi produk, dan sebagainya.',
                              error: textError,
                              initialString: ct.text,
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
                              text: 'Simpan',
                              action: () async {
                                resetError();
                                await widget.ctc.update(
                                  cardType: CardType.fromJson({
                                    'id': ct.id,
                                    'text': text,
                                    'title': titleController.text,
                                    'sub_content_title': subContentController.text,
                                    'whatsapp_message':
                                        whatsappMessageController.text,
                                  }),
                                  imageUrl: image,
                                  context: context,
                                  action: (b) {},
                                  action400: (errors) {
                                    checkError(errors);
                                  },
                                );
                              },
                            ),
                            ListCardContent(
                              contentType: widget.contentType,
                              lct: lct,
                              controller: contentTypeController,
                            ),
                            const SizedBox(
                              height: 32.0,
                            ),
                          ],
                        ),
                      );
                    }
                  );
                }),
          ),
        ),
      ),
    );
  }

  void resetError() {
    textError.value = null;
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
    if (errors.containsKey('whatsapp_message')) {
      whatsappMessageError.value = errors['whatsapp_message'][0];
    }
    if (errors.containsKey('image_url')) {
      imageError.value = errors['image_url'][0];
    }
  }
}

import 'dart:io';

import 'package:danuras_web_service_editor/src/menu/components/http/custom_future_builder.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/custom_button.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/input_html_editor.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/input_square_image.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/input_type_Bar.dart';
import 'package:danuras_web_service_editor/src/model/content_type.dart' as ctm;
import 'package:danuras_web_service_editor/src/view_controller/controller/content_type_controller.dart';
import 'package:flutter/material.dart';

class EditCardContent1 extends StatefulWidget {
  const EditCardContent1({
    super.key,
    required this.ctc,
    required this.contentTypeId,
    required this.action,
  });
  static const routeName = '/edit-card-content-1';
  final ContentTypeController ctc;
  final int contentTypeId;
  final Function(ctm.ContentType ct) action;

  @override
  State<EditCardContent1> createState() => _EditCardContent1State();
}

class _EditCardContent1State extends State<EditCardContent1> {
  TextEditingController titleController = TextEditingController(text: '');
  String? text;

  File? image;

  ValueNotifier<String?> titleError = ValueNotifier(null);
  ValueNotifier<String?> textError = ValueNotifier(null);
  ValueNotifier<String?> imageError = ValueNotifier(null);
  ValueNotifier<bool> refresher = ValueNotifier(false);

  late ctm.ContentType ct;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Ubah Konten'),
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
            child: ValueListenableBuilder(
                valueListenable: refresher,
                builder: (context, r, child) {
                  return CustomFutureBuilder(
                      future: widget.ctc.show(widget.contentTypeId),
                      widgetResult: (result) {
                        ct = result['data'];
                        text = ct.text;
                        titleController.text = ct.title!;
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
                                label: 'Gambar Konten',
                                imageError: imageError,
                                imageUrl: ct.imageUrl,
                              ),
                              ValueListenableBuilder(
                                valueListenable: imageError,
                                builder: (context, ie, child) {
                                  if (ie != null) {
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        ie,
                                        style:
                                            const TextStyle(color: Colors.red),
                                      ),
                                    );
                                  } else {
                                    return const SizedBox.shrink();
                                  }
                                },
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              InputTypeBar(
                                labelText: 'Judul',
                                tooltip: 'Masukan judul dari kartu.',
                                errorText: titleError,
                                controller: titleController,
                              ),
                              const SizedBox(
                                height: 8,
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
                              CustomButton(
                                text: 'Simpan',
                                action: () async {
                                  resetError();
                                  await widget.ctc.update(
                                    contentType: ctm.ContentType.fromJson({
                                      'title': titleController.text,
                                      'text': text,
                                      'id': widget.contentTypeId,
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
                        );
                      });
                }),
          ),
        ),
      ),
    );
  }

  void resetError() {
    titleError.value = null;
    textError.value = null;
    imageError.value = null;
  }

  void checkError(errors) {
    if (errors.containsKey('title')) {
      titleError.value = errors['title'][0];
    }
    if (errors.containsKey('text')) {
      textError.value = errors['text'][0];
    }
    if (errors.containsKey('icon')) {
      imageError.value = errors['icon'][0];
    }
  }
}

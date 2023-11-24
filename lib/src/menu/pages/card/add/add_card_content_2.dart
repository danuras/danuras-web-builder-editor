
import 'package:danuras_web_service_editor/src/menu/components/widget/custom_button.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/input_html_editor.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/input_type_Bar.dart';
import 'package:danuras_web_service_editor/src/model/content_type.dart' as ctm;
import 'package:danuras_web_service_editor/src/view_controller/controller/content_type_controller.dart';
import 'package:flutter/material.dart';

class AddCardContent2 extends StatefulWidget {
  const AddCardContent2({
    super.key,
    required this.ctc,
    required this.cardTypeId,
    required this.action,
  });
  static const routeName = '/add-card-content-2';
  final ContentTypeController ctc;
  final int cardTypeId;
  final Function(ctm.ContentType ct) action;

  @override
  State<AddCardContent2> createState() => _AddCardContent2State();
}

class _AddCardContent2State extends State<AddCardContent2> {
  TextEditingController titleController = TextEditingController(text: '');
  String? text;

  ValueNotifier<String?> titleError = ValueNotifier(null);
  ValueNotifier<String?> textError = ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Tambah Konten'),
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
                    changeText: ((changed) => text = changed),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  CustomButton(
                    text: 'Tambah',
                    action: () async {
                      resetError();
                      await widget.ctc.create(
                        contentType: ctm.ContentType.fromJson({
                          'title': titleController.text,
                          'text': text,
                          'card_type_id': widget.cardTypeId,
                        }),
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
    titleError.value = null;
    textError.value = null;
  }

  void checkError(errors) {
    if (errors.containsKey('title')) {
      titleError.value = errors['title'][0];
    }
    if (errors.containsKey('text')) {
      textError.value = errors['text'][0];
    }
  }
}

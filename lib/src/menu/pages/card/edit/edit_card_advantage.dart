import 'dart:io';

import 'package:danuras_web_service_editor/src/menu/components/widget/custom_button.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/input_cirle_image.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/input_type_Bar.dart';
import 'package:danuras_web_service_editor/src/model/advantage_content.dart';
import 'package:danuras_web_service_editor/src/view_controller/controller/advantage_content_controller.dart';
import 'package:flutter/material.dart';

class EditCardAdvantage extends StatefulWidget {
  const EditCardAdvantage({
    super.key,
    required this.acc,
    required this.ac,
    required this.action,
  });
  static const routeName = '/edit-card-advantage';
  final AdvantageContent ac;
  final AdvantageContentController acc;
  final Function(AdvantageContent ac) action;

  @override
  State<EditCardAdvantage> createState() => _EditCardAdvantageState();
}

class _EditCardAdvantageState extends State<EditCardAdvantage> {
  TextEditingController titleController = TextEditingController(text: '');
  TextEditingController textController = TextEditingController(text: '');
  File? image;

  ValueNotifier<String?> titleError = ValueNotifier(null);
  ValueNotifier<String?> textError = ValueNotifier(null);
  ValueNotifier<String?> imageError = ValueNotifier(null);
  
  @override
  void initState() {
    titleController.text = widget.ac.title;
    textController.text = widget.ac.text;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Ubah Data'),
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
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                    color: const Color(0xff110011),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 10.0,
                      ),
                      InputCircleImage(
                        action: (out) {
                          image = out;
                        },
                        iconUrl: widget.ac.icon,
                      ),
                      ValueListenableBuilder(
                        valueListenable: imageError,
                        builder: (context, ie, child) {
                          if (ie != null) {
                            return Padding(
                              padding: const EdgeInsets.only(top:8.0),
                              child: Text(
                                ie,
                                style: const TextStyle(color: Colors.red),
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
                      InputTypeBar(
                        labelText: 'Teks',
                        tooltip: 'Masukan keterangan dari kartu.',
                        errorText: textError,
                        maxLines: 4,
                        controller: textController,
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      CustomButton(
                        text: 'Simpan',
                        action: () async {
                          resetError();
                          await widget.acc.update(
                            advantageId: widget.ac.id,
                            icon: image,
                            title: titleController.text,
                            text: textController.text,
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

import 'dart:developer';

import 'package:danuras_web_service_editor/src/menu/components/widget/custom_button.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/input_type_bar.dart';
import 'package:danuras_web_service_editor/src/model/web_content.dart';
import 'package:danuras_web_service_editor/src/view_controller/controller/web_content_controller.dart';
import 'package:flutter/material.dart';

class AddSectionCard extends StatefulWidget {
  const AddSectionCard({
    super.key,
    required this.rank,
    required this.cardType,
    required this.wcc,
    required this.action,
  });
  static const routeName = '/web-content/add-section-card';
  final int rank;
  final String cardType;
  final WebContentController wcc;
  final Function(WebContent webContent) action;

  @override
  State<AddSectionCard> createState() => _AddSectionCardState();
}

class _AddSectionCardState extends State<AddSectionCard> {
  TextEditingController titleController = TextEditingController(text: '');
  TextEditingController infoController = TextEditingController(text: '');

  ValueNotifier<String?> titleError = ValueNotifier(null);
  ValueNotifier<String?> infoError = ValueNotifier(null);

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
          title: const Text('Tambah Bagian Kartu'),
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
                    height: 10,
                  ),
                  InputTypeBar(
                    labelText: 'Judul',
                    tooltip: 'Masukan judul bagian yang menampilkan kartu',
                    errorText: titleError,
                    controller: titleController,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  InputTypeBar(
                    labelText: 'Info',
                    tooltip: 'Masukan informasi tambahan untuk bagian ini',
                    errorText: infoError,
                    controller: infoController,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  CustomButton(
                    text: 'Simpan',
                    action: () async {
                      resetError();
                      await widget.wcc.createCard(
                        title: titleController.text,
                        info: infoController.text,
                        context: context,
                        action: widget.action,
                        rank: widget.rank,
                        action400: (errors) {
                          log(errors.toString());
                          checkError(errors);
                        },
                        cardType: widget.cardType,
                      );
                    },
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
    infoError.value = null;
    titleError.value = null;
  }

  void checkError(errors) {
    if (errors.containsKey('info')) {
      infoError.value = errors['info'][0];
    }
    if (errors.containsKey('title')) {
      titleError.value = errors['title'][0];
    }
  }
}

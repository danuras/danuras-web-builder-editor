import 'dart:io';

import 'package:danuras_web_service_editor/src/menu/components/widget/custom_button.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/input_square_image.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/input_type_Bar.dart';
import 'package:danuras_web_service_editor/src/model/card_model.dart';
import 'package:danuras_web_service_editor/src/view_controller/controller/card_controller.dart';
import 'package:flutter/material.dart';

class EditCard3 extends StatefulWidget {
  const EditCard3({
    super.key,
    required this.cm,
    required this.cc,
    required this.action,
  });
  static const routeName = '/edit-card-3';
  final CardModel cm;
  final CardController cc;
  final Function(CardModel cm) action;

  @override
  State<EditCard3> createState() => _EditCard3State();
}

class _EditCard3State extends State<EditCard3> {
  TextEditingController titleController = TextEditingController(text: '');
  File? image;
  String? imageUrl;

  ValueNotifier<String?> titleError = ValueNotifier(null);
  ValueNotifier<String?> imageError = ValueNotifier(null);

  @override
  void initState() {
    imageUrl = widget.cm.imageUrl;
    titleController.text = widget.cm.title??'';
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
                    labelText: 'Judul',
                    tooltip:
                        'Masukan judul dari kartu.',
                    errorText: titleError,
                    controller: titleController,
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
                          'title': titleController.text,
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
    titleError.value = null;
    imageError.value = null;
  }

  void checkError(errors) {
    if (errors.containsKey('title')) {
      titleError.value = errors['title'][0];
    }
    if (errors.containsKey('image_url')) {
      imageError.value = errors['image_url'][0];
    }
  }
}

import 'dart:developer';
import 'dart:io';

import 'package:danuras_web_service_editor/src/menu/components/widget/custom_button.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/input_square_image.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/input_type_bar.dart';
import 'package:danuras_web_service_editor/src/model/web_content.dart';
import 'package:danuras_web_service_editor/src/view_controller/controller/web_content_controller.dart';
import 'package:flutter/material.dart';

class AddSectionBlog extends StatefulWidget {
  const AddSectionBlog({
    super.key,
    required this.rank,
    required this.wcc,
    required this.action,
  });
  static const routeName = '/web-content/add-section-blog';
  final WebContentController wcc;
  final int rank;
  final Function(WebContent webContent) action;

  @override
  State<AddSectionBlog> createState() => AddSectionBlogState();
}

class AddSectionBlogState extends State<AddSectionBlog> {
  TextEditingController datePublishedController =
      TextEditingController(text: '');
  TextEditingController titleController = TextEditingController(text: '');
  TextEditingController authorController = TextEditingController(text: '');
  TextEditingController textController = TextEditingController(text: '');
  TextEditingController linkController = TextEditingController(text: '');
  File? image;

  ValueNotifier<String?> datePublishedError = ValueNotifier(null);
  ValueNotifier<String?> titleError = ValueNotifier(null);
  ValueNotifier<String?> authorError = ValueNotifier(null);
  ValueNotifier<String?> textError = ValueNotifier(null);
  ValueNotifier<String?> linkError = ValueNotifier(null);
  ValueNotifier<String?> imageError = ValueNotifier(null);

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
          title: const Text('Tambah Bagian Blog'),
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
                    tooltip: 'Masukan judul blog.',
                    errorText: titleError,
                    controller: titleController,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  InputTypeBar(
                    labelText: 'Penulis',
                    tooltip: 'Masukan nama penulis pada blog',
                    errorText: authorError,
                    controller: authorController,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  InputTypeBar(
                    labelText: 'Tanggal publikasi',
                    tooltip: 'Masukan tanggal publikasi artikel',
                    errorText: datePublishedError,
                    controller: datePublishedController,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  InputTypeBar(
                    labelText: 'Teks',
                    tooltip: 'Masukan penggalan teks dari blog.',
                    errorText: textError,
                    maxLines: 4,
                    controller: textController,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  InputTypeBar(
                    labelText: 'Link blog',
                    tooltip: 'Masukan link blog',
                    errorText: linkError,
                    controller: linkController,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  InputSquareImage(
                    action: (out) {
                      image = out;
                    },
                    label: 'Gambar Blog',
                    imageError: imageError,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  CustomButton(
                    text: 'Simpan',
                    action: () async {
                      resetError();
                      await widget.wcc.createBlog(
                        datePublished: datePublishedController.text,
                        title: titleController.text,
                        author: authorController.text,
                        text: textController.text,
                        link: linkController.text,
                        imageUrl: image,
                        context: context,
                        action: widget.action,
                        action400: (errors) {
                          // log(errors.toString());
                          checkError(errors);
                        },
                        rank: widget.rank,
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
    datePublishedError.value = null;
    titleError.value = null;
    authorError.value = null;
    textError.value = null;
    linkError.value = null;
    imageError.value = null;
  }

  void checkError(errors) {
    if (errors.containsKey('date_published')) {
      datePublishedError.value = errors['date_published'][0];
    }
    if (errors.containsKey('title')) {
      titleError.value = errors['title'][0];
    }
    if (errors.containsKey('author')) {
      authorError.value = errors['author'][0];
    }
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

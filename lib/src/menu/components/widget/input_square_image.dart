import 'dart:io';

import 'package:danuras_web_service_editor/src/model/endpoint.dart';
import 'package:danuras_web_service_editor/src/view_controller/upload_file/pick_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:hive_flutter/hive_flutter.dart';

class InputSquareImage extends StatefulWidget {
  const InputSquareImage({
    super.key,
    required this.action,
    required this.label,
    required this.imageError,
    this.height = 200,
    this.image,
    this.imageUrl,
  });
  final String? imageUrl;
  final File? image;
  final double height;
  final ValueNotifier<String?> imageError;
  final Function(File imaghe) action;
  final String label;

  @override
  State<InputSquareImage> createState() => _InputSquareImageState();
}

class _InputSquareImageState extends State<InputSquareImage> {
  String imagePath = '';
  File? image;
  ValueNotifier<bool> refreshInput = ValueNotifier(false);

  @override
  void initState() {
    image = widget.image;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xff110011),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ValueListenableBuilder(
              valueListenable: refreshInput,
              builder: (context, ri, child) {
                return GestureDetector(
                  onTap: () async {
                    FilePickerResult? result = await PickImage.pickImage();

                    if (result != null) {
                      imagePath = result.files.single.path!;

                      image = File(imagePath);
                      widget.action(image!);
                      refreshInput.value = !refreshInput.value;
                    }
                  },
                  child: Builder(
                    builder: (context) {
                      if (widget.imageUrl == null && image == null) {
                        return DottedBorder(
                          color: Colors.white,
                          strokeWidth: 3,
                          dashPattern: const [7, 7, 7],
                          child: SizedBox(
                            height: widget.height,
                            width: double.infinity,
                            child: const Center(
                      child: Icon(
                        Icons.add_photo_alternate_outlined,
                        color: Colors.white,
                        size: 60,
                      ),
                    ),
                          ),
                        );
                      } else {
                        return Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: Colors.transparent,
                          ),
                          child: Builder(
                            builder: (context) {
                              if (image == null) {
                                return Image.network(
                                  EndPoint.simple + widget.imageUrl!,
                                  fit: BoxFit.fill,
                                );
                              } else {
                                return Image.file(
                                  image!,
                                  fit: BoxFit.fill,
                                );
                              }
                            },
                          ),
                        );
                      }
                    },
                  ),
                );
              },
            ),
            ValueListenableBuilder(
              valueListenable: widget.imageError,
              builder: (context, ie, child) {
                if (ie != null) {
                  return Text(
                    ie,
                    style: const TextStyle(color: Colors.red),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
            const Divider(
              color: Colors.white,
            ),
            Text(
              widget.label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

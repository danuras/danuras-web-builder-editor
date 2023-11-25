import 'dart:io';

import 'package:danuras_web_service_editor/src/model/endpoint.dart';
import 'package:danuras_web_service_editor/src/view_controller/upload_file/pick_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class InputCircleImage extends StatefulWidget {
  const InputCircleImage({
    super.key,
    required this.action,
    this.icon,
    this.iconUrl,
  });
  final String? iconUrl;
  final File? icon;
  final Function(File icon) action;
  @override
  State<InputCircleImage> createState() => _InputCircleImageState();
}

class _InputCircleImageState extends State<InputCircleImage> {
  String iconPath = '';
  File? icon;
  ValueNotifier<bool> refreshInput = ValueNotifier(false);
  @override
  void initState() {
    icon = widget.icon;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: 100,
          height: 100,
          child: ValueListenableBuilder(
            valueListenable: refreshInput,
            builder: (context, ri, child) {
              if (widget.iconUrl == null && icon == null) {
                return const Center(
                  child: Icon(
                    Icons.add_photo_alternate_outlined,
                    color: Colors.white,
                    size: 60,
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ),
        ValueListenableBuilder(
          valueListenable: refreshInput,
          builder: (context, ri, child) {
            return GestureDetector(
              onTap: () async {
                FilePickerResult? result = await PickImage.pickImage();

                if (result != null) {
                  iconPath = result.files.single.path!;

                  icon = File(iconPath);
                  widget.action(icon!);
                  refreshInput.value = !refreshInput.value;
                }
              },
              child: Builder(
                builder: (context) {
                  if (widget.iconUrl == null && icon == null) {
                    return DottedBorder(
                      borderType: BorderType.Circle,
                      color: Colors.white,
                      strokeWidth: 3,
                      dashPattern: const [7, 7, 7],
                      child: const SizedBox(
                        height: 100,
                        width: 100,
                      ),
                    );
                  } else {
                    return Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50)),
                        image: (icon == null)
                            ? DecorationImage(
                                image: NetworkImage(
                                  EndPoint.simple!+widget.iconUrl!,
                                ),
                                fit: BoxFit.cover,
                              )
                            : DecorationImage(
                                image: FileImage(
                                  icon!,
                                ),
                                fit: BoxFit.cover,
                              ),
                        color: Colors.transparent,
                      ),
                    );
                  }
                },
              ),
            );
          },
        ),
      ],
    );
  }
}

import 'dart:io';

import 'package:danuras_web_service_editor/src/view_controller/upload_file/pick_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:hive_flutter/hive_flutter.dart';

class InputTypeIcon extends StatefulWidget {
  const InputTypeIcon({
    super.key,
    required this.action,
    required this.label,
    this.icon,
    this.iconUrl,
  });
  final String? iconUrl;
  final File? icon;
  final Function(File icon) action;
  final String label;

  @override
  State<InputTypeIcon> createState() => _InputTypeIconState();
}

class _InputTypeIconState extends State<InputTypeIcon> {
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
    return Container(
      width: 116,
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
            Stack(
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
                                          widget.iconUrl!,
                                        ),
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

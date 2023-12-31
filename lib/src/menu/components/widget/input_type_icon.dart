import 'dart:io';

import 'package:danuras_web_service_editor/src/model/endpoint.dart';
import 'package:danuras_web_service_editor/src/view_controller/upload_file/pick_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class InputTypeIcon extends StatefulWidget {
  const InputTypeIcon({
    super.key,
    required this.action,
    required this.label,
    this.tooltip,
    required this.iconError,
    this.icon,
    this.iconUrl,
  });
  final ValueNotifier<String?> iconError;
  final String? iconUrl;
  final File? icon;
  final Function(File icon) action;
  final String label;
  final String? tooltip;

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
                Column(
                  children: [
                    ValueListenableBuilder(
                      valueListenable: refreshInput,
                      builder: (context, ri, child) {
                        return GestureDetector(
                          onTap: () async {
                            FilePickerResult? result =
                                await PickImage.pickImage();

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
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50)),
                                    color: Colors.transparent,
                                  ),
                                  child: Builder(
                                    builder: (context) {
                                      if (icon == null) {
                                        return Image.network(
                                          EndPoint.simple! + widget.iconUrl!,
                                        );
                                      } else {
                                        return Image.file(icon!);
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
                      valueListenable: widget.iconError,
                      builder: (context, ie, child) {
                        if(ie != null){
                          return Text(ie, style: const TextStyle(color: Colors.red),);
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
            const Divider(
              color: Colors.white,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(width: 10,),
                Tooltip(
                  message: widget.tooltip,
                  textStyle: const TextStyle(color: Colors.white),
                  decoration: BoxDecoration(
                    color: const Color(0xff330033),
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  triggerMode: TooltipTriggerMode.tap,
                  child: const Icon(
                    Icons.help_outline,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

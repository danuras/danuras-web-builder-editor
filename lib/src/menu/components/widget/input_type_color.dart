import 'package:flutter/material.dart';

class InputTypeColor extends StatelessWidget {
  const InputTypeColor({
    super.key,
    required this.labelText,
    required this.errorText,
    required this.controller,
    required this.tooltip,
  });
  final ValueNotifier errorText;
  final TextEditingController controller;
  final String labelText;
  final String tooltip;

  Color hexToColor(String code) {
    return Color(int.parse(code, radix: 16) + 0xFF000000);
  }

  @override
  Widget build(BuildContext context) {
    ValueNotifier<bool> isError = ValueNotifier(controller.text.length != 6);
    return ValueListenableBuilder(
      valueListenable: errorText,
      builder: (context, error, child) {
        return Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                textAlignVertical: TextAlignVertical.top,
                style: const TextStyle(color: Colors.white),
                onChanged: (value) {
                  if (value.length != 6) {
                    isError.value = true;
                  } else {
                    isError.value = false;
                  }
                },
                decoration: InputDecoration(
                  labelText: labelText,
                  prefixIcon: const Icon(
                    Icons.tag,
                    color: Colors.white,
                  ),
                  labelStyle: const TextStyle(
                    color: Colors.white,
                  ),
                  errorText: error,
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(4),
                      bottomLeft: Radius.circular(4),
                    ),
                    borderSide: BorderSide(color: Colors.white, width: 2),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(4),
                      bottomLeft: Radius.circular(4),
                    ),
                    borderSide: BorderSide(color: Colors.white, width: 2),
                  ),
                  fillColor: const Color(0xff110011),
                  filled: true,
                  alignLabelWithHint: true,
                ),
              ),
            ),
            Container(
              width: 59,
              height: 59,
              decoration: BoxDecoration(
                color: const Color(0xff110011),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(4),
                  bottomRight: Radius.circular(3),
                ),
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ValueListenableBuilder(
                  valueListenable: isError,
                  builder: (context, ie, child) {
                    return Container(
                      width: 30,
                      height: 30,
                      color: (ie)
                          ? Colors.transparent
                          : hexToColor(controller.text),
                    );
                  }
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

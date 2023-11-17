import 'package:flutter/material.dart';

class InputTypeBar extends StatelessWidget {
  const InputTypeBar({
    super.key,
    required this.labelText,
    this.maxLines = 1,
    required this.errorText,
    required this.controller,
    required this.tooltip,
  });
  final ValueNotifier errorText;
  final TextEditingController controller;
  final int maxLines;
  final String labelText;
  final String tooltip;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: errorText,
      builder: (context, error, child) {
        return TextField(
          controller: controller,
          maxLines: maxLines,
          textAlignVertical: TextAlignVertical.top,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelText: labelText,
            suffixIcon: Padding(
              padding: const EdgeInsets.only(top:10.0, right: 10.0,),
              child: Align(
                alignment: Alignment.topRight,
                widthFactor: 1.0,
                heightFactor: maxLines * 1.0,
                child: Tooltip(
                  message: tooltip,
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
              ),
            ),
            labelStyle: const TextStyle(
              color: Colors.white,
            ),
            errorText: error,
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 2)),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 2)),
            fillColor: const Color(0xff110011),
            filled: true,
            alignLabelWithHint: true,
          ),
        );
      },
    );
  }
}

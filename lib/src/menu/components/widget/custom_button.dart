import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.action,
    this.width,
    this.height,
    this.fontSize = 20,
  });
  final String text;
  final Function() action;
  final double? width, height, fontSize;


  @override
  Widget build(BuildContext context) {
    ValueNotifier<bool> isHover = ValueNotifier(false);
    return ValueListenableBuilder(
      valueListenable: isHover,
      builder: (context, ih, child) {
        return Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: (ih) ? const Color(0xbb220022) : const Color(0xee440044),
            border: Border.all(
              color: Colors.white,
              width: 2,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(32),
            ),
          ),
          child: InkWell(
            onTap: action,
            onTapDown: (value) {
              isHover.value = true;
            },
            onTapCancel: () {
              isHover.value = false;
            },
            onTapUp: (v) {
              isHover.value = false;
            },
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  text,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: fontSize
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

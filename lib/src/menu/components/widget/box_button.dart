import 'package:flutter/material.dart';

class BoxButton extends StatefulWidget {
  const BoxButton({
    super.key,
    required this.label,
    required this.iconData,
    required this.onTap,
  });
  final String label;
  final IconData iconData;
  final Function() onTap;

  @override
  State<BoxButton> createState() => _BoxButtonState();
}

class _BoxButtonState extends State<BoxButton> {
  ValueNotifier<bool> onTapColor = ValueNotifier(false);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: onTapColor,
      builder: (context, otc, dhild) {
        return GestureDetector(
          onTap: widget.onTap,
          onTapDown: (a) {
            onTapColor.value = true;
          },
          onTapCancel: () {
            onTapColor.value = false;
          },
          onTapUp: (v) {
            onTapColor.value = false;
          },
          child: Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              color: (otc)?const Color(0xffbbbbbb):const Color(0xaa110011),
              border: Border.all(color: Colors.grey),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    widget.label,
                    style: TextStyle(
                      color: (otc)?Colors.black:Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    widget.iconData,
                    color: (otc)?Colors.black:Colors.white,
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}

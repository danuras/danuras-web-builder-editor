// ignore_for_file: avoid_print

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:file_picker/file_picker.dart';

class InputHtmlEditor extends StatefulWidget {
  const InputHtmlEditor({
    Key? key,
    required this.title,
    required this.tooltip,
    this.initialString,
    required this.changeText,
  }) : super(key: key);

  final String title;
  final String tooltip;
  final Function(String? changed) changeText;
  final String? initialString;

  @override
  State<InputHtmlEditor> createState() => _InputHtmlEditorState();
}

class _InputHtmlEditorState extends State<InputHtmlEditor> {
  String result = '';
  final HtmlEditorController controller = HtmlEditorController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color(0xff110011),
          border: Border.all(
            color: Colors.white,
            width: 2,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(4))),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(color: Colors.white),
                ),
                const Spacer(),
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
          ),
          const Divider(
            color: Colors.white,
            height: 2,
            thickness: 2,
          ),
          HtmlEditor(
            controller: controller,
            htmlEditorOptions: HtmlEditorOptions(
              hint: 'Masukan Teks',
              shouldEnsureVisible: true,
              initialText: widget.initialString,
            ),
            htmlToolbarOptions: HtmlToolbarOptions(
              defaultToolbarButtons: [
                const StyleButtons(),
                const FontSettingButtons(fontSizeUnit: false),
                const FontButtons(),
                const ColorButtons(),
                const ListButtons(listStyles: false),
                const ParagraphButtons(
                  caseConverter: false,
                  textDirection: false,
                ),
              ],

              toolbarPosition: ToolbarPosition.aboveEditor, //by default
              toolbarType: ToolbarType.nativeScrollable, //by default
              onButtonPressed:
                  (ButtonType type, bool? status, Function? updateStatus) {
                print(
                    "button '${describeEnum(type)}' pressed, the current selected status is $status");
                return true;
              },
              onDropdownChanged: (DropdownType type, dynamic changed,
                  Function(dynamic)? updateSelectedItem) {
                print("dropdown '${describeEnum(type)}' changed to $changed");
                return true;
              },
            ),
            otherOptions: OtherOptions(
              height: 400,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  width: 2,
                  color: Colors.black,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(5)),
              ),
            ),
            callbacks: Callbacks(
              onChangeCodeview: (String? changed) {
                widget.changeText(changed);
              },
            ),
          ),
        ],
      ),
    );
  }
}


import 'dart:developer';

import 'package:danuras_web_service_editor/src/menu/pages/card/edit/edit_card_content_1.dart';
import 'package:danuras_web_service_editor/src/model/content_type.dart';
import 'package:danuras_web_service_editor/src/model/endpoint.dart';
import 'package:danuras_web_service_editor/src/view_controller/controller/content_type_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class Content1Card extends StatelessWidget {
  const Content1Card({
    super.key,
    required this.ct,
    required this.ctc,
    required this.delete,
    required this.updateComplete,
  });
  final ContentType ct;
  final ContentTypeController ctc;
  final Function() delete;
  final Function(ContentType ct) updateComplete;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xff110011),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(
          width: 2,
          color: Colors.white,
        ),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                Image.network(EndPoint.simple! + ct.imageUrl!, cacheHeight: 512, cacheWidth: 512,),
                const Divider(
                  color: Colors.white,
                ),
                Text(
                  ct.title!,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                const Divider(
                  color: Colors.white,
                ),
                HtmlWidget(
                  //to show HTML as widget.
                  ct.text!,
                  customStylesBuilder: (element) {
                    return {'color': 'white'};
                  },
                ),
              ],
            ),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  log(ct.id.toString());
                  Navigator.of(context).pushNamed(
                    EditCardContent1.routeName,
                    arguments: <String, dynamic>{
                      'ctc': ctc,
                      'action': updateComplete,
                      'content_type_id': ct.id,
                    },
                  );
                },
                child: Container(
                  width: 35,
                  height: 35,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  child: const Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () async {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      backgroundColor: const Color(0xff110011),
                      title: const Text(
                        'Anda yakin ingin menghapus data ini?',
                        style: TextStyle(color: Colors.white),
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Tidak'),
                          child: const Text(
                            'Tidak',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            await ctc.delete(
                              ct.id!,
                              context,
                              delete,
                            );
                            if (context.mounted) {
                              Navigator.of(context).pop();
                            }
                          },
                          child: const Text(
                            'Ya',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                child: Container(
                  width: 35,
                  height: 35,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                  ),
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

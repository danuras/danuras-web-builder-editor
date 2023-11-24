import 'package:danuras_web_service_editor/src/menu/pages/card/edit/edit_card_testimony.dart';
import 'package:danuras_web_service_editor/src/model/endpoint.dart';
import 'package:danuras_web_service_editor/src/model/testimony.dart';
import 'package:danuras_web_service_editor/src/view_controller/controller/testimony_controller.dart';
import 'package:flutter/material.dart';

class TestimonyCard extends StatelessWidget {
  const TestimonyCard({
    super.key,
    required this.t,
    required this.tc,
    required this.delete,
    required this.updateComplete,
  });
  final Testimony t;
  final TestimonyController tc;
  final Function() delete;
  final Function(Testimony t) updateComplete;

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
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage:
                          NetworkImage(EndPoint.simple + t.photoProfile),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          t.name,
                          style: const TextStyle(color: Colors.white),
                        ),
                        Text(
                          t.job,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
                const Divider(
                  color: Colors.white,
                ),
                Text(
                  t.value,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    EditCardTestimony.routeName,
                    arguments: <String, dynamic>{
                      't': t,
                      'tc': tc,
                      'action': updateComplete,
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
                            await tc.delete(
                              id: t.id,
                              context: context,
                              action: delete,
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

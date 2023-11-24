import 'package:danuras_web_service_editor/src/menu/pages/card/edit/edit_card_blog.dart';
import 'package:danuras_web_service_editor/src/model/blog.dart';
import 'package:danuras_web_service_editor/src/model/endpoint.dart';
import 'package:danuras_web_service_editor/src/view_controller/controller/blog_controller.dart';
import 'package:flutter/material.dart';

class BlogCard extends StatelessWidget {
  const BlogCard({
    super.key,
    required this.b,
    required this.bc,
    required this.delete,
    required this.updateComplete,
  });
  final Blog b;
  final BlogController bc;
  final Function() delete;
  final Function(Blog b) updateComplete;

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
                CircleAvatar(
                  backgroundImage: NetworkImage(EndPoint.simple + b.imageUrl),
                  radius: MediaQuery.of(context).size.width/8,
                ),
                const Divider(
                  color: Colors.white,
                ),
                Text(
                  b.title,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                const Divider(
                  color: Colors.white,
                ),
                Text(
                  b.text.length < 100
                      ? b.text
                      : '${b.text.substring(0, 100)}...',
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    EditCardBlog.routeName,
                    arguments: <String, dynamic>{
                      'b': b,
                      'action': updateComplete,
                      'bc': bc,
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
                            await bc.delete(
                                id: b.id,
                                context: context,
                                action: delete);
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

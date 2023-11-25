import 'package:danuras_web_service_editor/src/menu/pages/content/add/add_content_1.dart';
import 'package:danuras_web_service_editor/src/menu/pages/content/add/add_content_2.dart';
import 'package:danuras_web_service_editor/src/view_controller/controller/card_type_controller.dart';
import 'package:flutter/material.dart';

class AddContent extends StatefulWidget {
  const AddContent({
    super.key,
    required this.ctc,
    required this.cardId,
    required this.action,
  });
  final CardTypeController ctc;
  final Function(String contentType) action;
  final int cardId;
  static const routeName = '/add-content';

  @override
  State<AddContent> createState() => _AddContentState();
}

class _AddContentState extends State<AddContent> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Pilih Jenis Isian Kartu'),
          backgroundColor: const Color(0xff110011),
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/images/background.jpeg',
              ),
              fit: BoxFit.cover,
            ),
            color: Colors.black,
          ),
          child: Container(
            color: const Color(0x88110011),
            child: Builder(builder: (context) {
              return Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  right: 8.0,
                ),
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: WebContentCard(
                        imagePath:
                            'assets/images/kerangka/card/content/content-1.png',
                        title: 'Konten-1',
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AddContent1.routeName,
                            arguments: {
                              'action': widget.action,
                              'ctc': widget.ctc,
                              'card_id': widget.cardId,
                            },
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: WebContentCard(
                        imagePath:
                            'assets/images/kerangka/card/content/content-2.png',
                        title: 'Konten-2',
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AddContent2.routeName,
                            arguments: {
                              'action': widget.action,
                              'ctc': widget.ctc,
                              'card_id': widget.cardId,
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class WebContentCard extends StatelessWidget {
  const WebContentCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.onTap,
  });
  final String imagePath, title;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Color(0xff110011),
              border: Border(
                left: BorderSide(
                  width: 2,
                  color: Colors.white,
                ),
                top: BorderSide(
                  width: 2,
                  color: Colors.white,
                ),
                right: BorderSide(
                  width: 2,
                  color: Colors.white,
                ),
              ),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xff110011),
              border: Border.all(
                width: 2,
                color: Colors.white,
              ),
            ),
            child: Image.asset(imagePath),
          ),
        ],
      ),
    );
  }
}

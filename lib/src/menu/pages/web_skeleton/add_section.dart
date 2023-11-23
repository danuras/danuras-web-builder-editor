import 'dart:io';

import 'package:danuras_web_service_editor/src/menu/components/widget/custom_button.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/input_html_editor.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/input_square_image.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/input_type_Bar.dart';
import 'package:danuras_web_service_editor/src/menu/pages/web_skeleton/add_section_widget/add_section_advantage.dart';
import 'package:danuras_web_service_editor/src/menu/pages/web_skeleton/add_section_widget/add_section_blog.dart';
import 'package:danuras_web_service_editor/src/menu/pages/web_skeleton/add_section_widget/add_section_card.dart';
import 'package:danuras_web_service_editor/src/menu/pages/web_skeleton/add_section_widget/add_section_location.dart';
import 'package:danuras_web_service_editor/src/menu/pages/web_skeleton/add_section_widget/add_section_testimony.dart';
import 'package:danuras_web_service_editor/src/view_controller/controller/web_content_controller.dart';
import 'package:flutter/material.dart';
import 'package:danuras_web_service_editor/src/model/web_content.dart';

class AddSection extends StatefulWidget {
  const AddSection({
    super.key,
    required this.rank,
    required this.lwc,
    required this.wcc,
    required this.action,
  });
  final int rank;
  final List<String> lwc;
  final WebContentController wcc;
  final Function(WebContent webContent) action;
  static const routeName = '/web-skeleton/add-section';

  @override
  State<AddSection> createState() => _AddSectionState();
}

class _AddSectionState extends State<AddSection> {
  TextEditingController senderController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');
  TextEditingController receiverController = TextEditingController(text: '');
  ValueNotifier<String?> senderError = ValueNotifier(null);
  ValueNotifier<String?> passwordError = ValueNotifier(null);
  ValueNotifier<String?> receiverError = ValueNotifier(null);
  String? infoContact;

  File? backgroundImageContact;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Tambah Bagian'),
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
              bool isAdvantage = widget.lwc
                  .where((element) => element == 'advantage')
                  .toList()
                  .isEmpty;
              bool isTestimony = widget.lwc
                  .where((element) => element == 'testimony')
                  .toList()
                  .isEmpty;
              bool isBlog = widget.lwc
                  .where((element) => element == 'blog')
                  .toList()
                  .isEmpty;
              bool isMap = widget.lwc
                  .where((element) => element == 'maps')
                  .toList()
                  .isEmpty;
              return Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  right: 8.0,
                  top: 16.0,
                ),
                child: ListView(
                  children: [
                    (isAdvantage)
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: WebContentCard(
                              imagePath:
                                  'assets/images/kerangka/advantage/advantage-1.png',
                              title: 'Keunggulan',
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  AddSectionAdvantage.routeName,
                                  arguments: {
                                    'rank': widget.rank,
                                    'wcc': widget.wcc,
                                    'action': widget.action,
                                  },
                                );
                              },
                            ),
                          )
                        : const SizedBox.shrink(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: WebContentCard(
                        imagePath: 'assets/images/kerangka/card/card-1.png',
                        title: 'Card-1',
                        onTap: () {
                          Navigator.pushNamed(context, AddSectionCard.routeName,
                              arguments: {
                                'rank': widget.rank,
                                'card_type': 'card-1',
                                'wcc': widget.wcc,
                                'action': widget.action,
                              });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: WebContentCard(
                        imagePath: 'assets/images/kerangka/card/card-2.png',
                        title: 'Card-2',
                        onTap: () {
                          Navigator.pushNamed(context, AddSectionCard.routeName,
                              arguments: {
                                'rank': widget.rank,
                                'card_type': 'card-2',
                                'wcc': widget.wcc,
                                'action': widget.action,
                              });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: WebContentCard(
                        imagePath: 'assets/images/kerangka/card/card-3.png',
                        title: 'Card-3',
                        onTap: () {
                          Navigator.pushNamed(context, AddSectionCard.routeName,
                              arguments: {
                                'rank': widget.rank,
                                'card_type': 'card-3',
                                'wcc': widget.wcc,
                                'action': widget.action,
                              });
                        },
                      ),
                    ),
                    (isTestimony)
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: WebContentCard(
                              imagePath:
                                  'assets/images/kerangka/testimony/testimony-1.png',
                              title: 'Testimoni',
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  AddSectionTestimony.routeName,
                                  arguments: {
                                    'rank': widget.rank,
                                    'wcc': widget.wcc,
                                    'action': widget.action,
                                  },
                                );
                              },
                            ),
                          )
                        : const SizedBox.shrink(),
                    (isBlog)
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: WebContentCard(
                              imagePath:
                                  'assets/images/kerangka/blog/blog-1.png',
                              title: 'Blog',
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  AddSectionBlog.routeName,
                                  arguments: {
                                    'rank': widget.rank,
                                    'wcc': widget.wcc,
                                    'action': widget.action,
                                  },
                                );},
                            ),
                          )
                        : const SizedBox.shrink(),
                    (isMap)
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: WebContentCard(
                              imagePath:
                                  'assets/images/kerangka/location/location-1.png',
                              title: 'Lokasi',
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  AddSectionLocation.routeName,
                                  arguments: {
                                    'rank': widget.rank,
                                    'wcc': widget.wcc,
                                    'action': widget.action,
                                  },
                                );
                              },
                            ),
                          )
                        : const SizedBox.shrink(),
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

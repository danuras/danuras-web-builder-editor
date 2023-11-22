import 'dart:io';

import 'package:danuras_web_service_editor/src/menu/components/http/custom_future_builder.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/custom_button.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/input_html_editor.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/input_square_image.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/input_type_Bar.dart';
import 'package:danuras_web_service_editor/src/menu/pages/web_skeleton/add_section.dart';
import 'package:danuras_web_service_editor/src/menu/pages/web_skeleton/edit_section_widget/edit_section_advantage.dart';
import 'package:danuras_web_service_editor/src/menu/pages/web_skeleton/edit_section_widget/edit_section_blog.dart';
import 'package:danuras_web_service_editor/src/menu/pages/web_skeleton/edit_section_widget/edit_section_card.dart';
import 'package:danuras_web_service_editor/src/menu/pages/web_skeleton/edit_section_widget/edit_section_location.dart';
import 'package:danuras_web_service_editor/src/menu/pages/web_skeleton/edit_section_widget/edit_section_testimony.dart';
import 'package:danuras_web_service_editor/src/model/web_content.dart';
import 'package:danuras_web_service_editor/src/view_controller/controller/web_content_controller.dart';
import 'package:flutter/material.dart';

class WebSkeleton extends StatefulWidget {
  const WebSkeleton({super.key});
  static const routeName = '/web-skeleton';

  @override
  State<WebSkeleton> createState() => _WebSkeletonState();
}

class _WebSkeletonState extends State<WebSkeleton> {
  WebContentController wcc = WebContentController();
  List<WebContent> lwc = [];
  ValueNotifier<bool> refresher = ValueNotifier(false);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Kerangka Web'),
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
            child: RefreshIndicator(
              onRefresh: () async {
                refresher.value = !refresher.value;
              },
              color: const Color(0xffffffff),
              backgroundColor: const Color(0xff110011),
              child: ValueListenableBuilder(
                  valueListenable: refresher,
                  builder: (context, r, child) {
                    return CustomFutureBuilder(
                        future: wcc.show(),
                        widgetResult: (result) {
                          lwc = result['data'];
                          return Padding(
                            padding: const EdgeInsets.only(
                              left: 8.0,
                              right: 8.0,
                              top: 16.0,
                            ),
                            child: ListView(
                              children: [
                                WebContentCard(
                                  imagePath:
                                      'assets/images/kerangka/header/header-1.png',
                                  title: 'Header',
                                  onTap: () {},
                                ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: lwc.length * 2 + 1,
                                  itemBuilder: (context, index) {
                                    if (index % 2 == 0) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                          top: 8.0,
                                          bottom: 8.0,
                                        ),
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(
                                              context,
                                              AddSection.routeName,
                                              arguments: {
                                                'rank': (index / 2 + 1).round(),
                                                'lwc': lwc
                                                    .map((element) =>
                                                        element.contentType)
                                                    .toList(),
                                              },
                                            );
                                          },
                                          child: Container(
                                            color: Colors.white,
                                            child: const Icon(
                                              Icons.add,
                                            ),
                                          ),
                                        ),
                                      );
                                    } else {
                                      if (lwc[((index - 1) / 2).round()]
                                              .contentType ==
                                          'advantage') {
                                        return WebContentCard(
                                          imagePath:
                                              'assets/images/kerangka/advantage/advantage-1.png',
                                          title: 'Keunggulan',
                                          onTap: () {
                                            Navigator.of(context).pushNamed(
                                              EditSectionAdvantage.routeName,
                                            );
                                          },
                                        );
                                      } else if (lwc[((index - 1) / 2).round()]
                                              .contentType ==
                                          'card') {
                                        return WebContentCard(
                                          imagePath:
                                              'assets/images/kerangka/card/${lwc[((index - 1) / 2).round()].cardType}.png',
                                          title: lwc[((index - 1) / 2).round()]
                                              .title!,
                                          onTap: () {
                                            Navigator.of(context).pushNamed(
                                              EditSectionCard.routeName,
                                              arguments: {
                                                'card_box_id': lwc[
                                                        ((index - 1) / 2)
                                                            .round()]
                                                    .cardBoxId,
                                                'card_type': lwc[
                                                        ((index - 1) / 2)
                                                            .round()]
                                                    .cardType,
                                                'action': (cardBox) {
                                                  lwc[((index - 1) / 2)
                                                      .round()] = cardBox;
                                                }
                                              },
                                            );
                                          },
                                        );
                                      } else if (lwc[((index - 1) / 2).round()]
                                              .contentType ==
                                          'testimony') {
                                        return WebContentCard(
                                          imagePath:
                                              'assets/images/kerangka/testimony/testimony-1.png',
                                          title: 'Testimoni',
                                          onTap: () {
                                            Navigator.of(context).pushNamed(
                                              EditSectionTestimony.routeName,
                                            );
                                          },
                                        );
                                      } else if (lwc[((index - 1) / 2).round()]
                                              .contentType ==
                                          'blog') {
                                        return WebContentCard(
                                          imagePath:
                                              'assets/images/kerangka/blog/blog-1.png',
                                          title: 'Blog',
                                          onTap: () {
                                            Navigator.of(context).pushNamed(
                                              EditSectionBlog.routeName,
                                            );
                                          },
                                        );
                                      } else if (lwc[((index - 1) / 2).round()]
                                              .contentType ==
                                          'maps') {
                                        return WebContentCard(
                                          imagePath:
                                              'assets/images/kerangka/location/location-1.png',
                                          title: 'Lokasi',
                                          onTap: () {
                                            Navigator.of(context).pushNamed(
                                              EditSectionLocation.routeName,
                                            );
                                          },
                                        );
                                      }

                                      return const SizedBox.shrink();
                                    }
                                  },
                                ),
                                WebContentCard(
                                  imagePath:
                                      'assets/images/kerangka/footer/footer-1.png',
                                  title: 'Footer',
                                  onTap: () {},
                                ),
                                const SizedBox(
                                  height: 8.0,
                                ),
                              ],
                            ),
                          );
                        });
                  }),
            ),
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
                padding: EdgeInsets.all(8.0),
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

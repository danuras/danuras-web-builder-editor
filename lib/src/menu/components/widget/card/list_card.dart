import 'dart:io';

import 'package:danuras_web_service_editor/src/menu/components/widget/card/advantage_card.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/card/blog_card.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/card/card_1.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/card/card_2.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/card/card_3.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/card/testimony_card.dart';
import 'package:danuras_web_service_editor/src/model/card_model.dart';
import 'package:flutter/material.dart';

class ListCard extends StatelessWidget {
  const ListCard({
    super.key,
    required this.lcm,
    required this.cardType,
    required this.contentType,
  });
  final List<dynamic> lcm;
  final String cardType, contentType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: const Color(0xff110011),
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              border: Border.all(
                width: 2,
                color: Colors.white,
              ),
            ),
            child: const Center(
              child: Text(
                'Daftar Item',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Builder(
            builder: (context) {
              if (contentType == 'card') {
                if (cardType == 'card-1') {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: lcm.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          top: 4.0,
                          bottom: 4.0,
                        ),
                        child: Card1(
                          cm: lcm[index],
                        ),
                      );
                    },
                  );
                } else if (cardType == 'card-2') {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: (lcm.length / 2).ceil(),
                    itemBuilder: (context, index) {
                      return SizedBox(
                        width: double.infinity,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  right: 4.0,
                                  bottom: 4.0,
                                  top: 4.0,
                                ),
                                child: Card2(
                                  cm: lcm[index * 2],
                                ),
                              ),
                            ),
                            (lcm.length > index * 2 + 1)
                                ? Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        right: 2.0,
                                        bottom: 2.0,
                                        top: 2.0,
                                      ),
                                      child: Card2(
                                        cm: lcm[index * 2 + 1],
                                      ),
                                    ),
                                  )
                                : const Expanded(
                                    flex: 1,
                                    child: SizedBox(),
                                  ),
                          ],
                        ),
                      );
                    },
                  );
                } else if (cardType == 'card-3') {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: (lcm.length / 2).ceil(),
                    itemBuilder: (context, index) {
                      return SizedBox(
                        width: double.infinity,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  right: 4.0,
                                  bottom: 4.0,
                                  top: 4.0,
                                ),
                                child: Card3(
                                  cm: lcm[index * 2],
                                ),
                              ),
                            ),
                            (lcm.length > index * 2 + 1)
                                ? Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        right: 2.0,
                                        bottom: 2.0,
                                        top: 2.0,
                                      ),
                                      child: Card3(
                                        cm: lcm[index * 2 + 1],
                                      ),
                                    ),
                                  )
                                : const Expanded(
                                    flex: 1,
                                    child: SizedBox(),
                                  ),
                          ],
                        ),
                      );
                    },
                  );
                }
              } else if (contentType == 'advantage') {
                return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: (lcm.length / 2).ceil(),
                    itemBuilder: (context, index) {
                      return SizedBox(
                        width: double.infinity,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  right: 4.0,
                                  bottom: 4.0,
                                  top: 4.0,
                                ),
                                child: AdvantageCard(
                                  ac: lcm[index * 2],
                                ),
                              ),
                            ),
                            (lcm.length > index * 2 + 1)
                                ? Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        right: 2.0,
                                        bottom: 2.0,
                                        top: 2.0,
                                      ),
                                      child: AdvantageCard(
                                        ac: lcm[index * 2 + 1],
                                      ),
                                    ),
                                  )
                                : const Expanded(
                                    flex: 1,
                                    child: SizedBox(),
                                  ),
                          ],
                        ),
                      );
                    },
                  );
              } else if (contentType == 'testimony') {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: lcm.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        top: 4.0,
                        bottom: 4.0,
                      ),
                      child: TestimonyCard(
                        t: lcm[index],
                      ),
                    );
                  },
                );
              } else if (contentType == 'blog') {
                return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: (lcm.length / 2).ceil(),
                    itemBuilder: (context, index) {
                      return SizedBox(
                        width: double.infinity,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  right: 4.0,
                                  bottom: 4.0,
                                  top: 4.0,
                                ),
                                child: BlogCard(
                                  b: lcm[index * 2],
                                ),
                              ),
                            ),
                            (lcm.length > index * 2 + 1)
                                ? Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        right: 2.0,
                                        bottom: 2.0,
                                        top: 2.0,
                                      ),
                                      child: BlogCard(
                                        b: lcm[index * 2 + 1],
                                      ),
                                    ),
                                  )
                                : const Expanded(
                                    flex: 1,
                                    child: SizedBox(),
                                  ),
                          ],
                        ),
                      );
                    },
                  );
              } 

              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}

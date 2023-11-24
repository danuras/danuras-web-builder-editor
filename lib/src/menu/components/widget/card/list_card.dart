
import 'package:danuras_web_service_editor/src/menu/components/widget/card/advantage_card.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/card/blog_card.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/card/card_1.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/card/card_2.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/card/card_3.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/card/testimony_card.dart';
import 'package:flutter/material.dart';

class ListCard extends StatefulWidget {
  const ListCard({
    super.key,
    required this.lcm,
    required this.cardType,
    required this.contentType,
    this.controller,
  });
  final List<dynamic> lcm;
  final dynamic controller;
  final String cardType, contentType;

  @override
  State<ListCard> createState() => _ListCardState();
}

class _ListCardState extends State<ListCard> {
  ValueNotifier<bool> refresherResult = ValueNotifier(false);
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
          ValueListenableBuilder(
            valueListenable: refresherResult,
            builder: (context, rr, child) {
              if (widget.contentType == 'card') {
                if (widget.cardType == 'card-1') {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.lcm.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          top: 4.0,
                          bottom: 4.0,
                        ),
                        child: Card1(
                          cm: widget.lcm[index],
                          cc: widget.controller,
                          delete: () {
                            widget.lcm.removeAt(index);
                            refresherResult.value = !refresherResult.value;
                          },
                          updateComplete: (cm) {
                            widget.lcm[index] = cm;
                            refresherResult.value = !refresherResult.value;
                          },
                        ),
                      );
                    },
                  );
                } else if (widget.cardType == 'card-2') {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: (widget.lcm.length / 2).ceil(),
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
                                  cm: widget.lcm[index * 2],
                                  cc: widget.controller,
                                  delete: () {
                                    widget.lcm.removeAt(index);
                                    refresherResult.value =
                                        !refresherResult.value;
                                  },
                                  updateComplete: (cm) {
                                    widget.lcm[index] = cm;
                                    refresherResult.value =
                                        !refresherResult.value;
                                  },
                                ),
                              ),
                            ),
                            (widget.lcm.length > index * 2 + 1)
                                ? Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        right: 2.0,
                                        bottom: 2.0,
                                        top: 2.0,
                                      ),
                                      child: Card2(
                                        cm: widget.lcm[index * 2 + 1],
                                        cc: widget.controller,
                                        delete: () {
                                          widget.lcm.removeAt(index * 2 + 1);
                                          refresherResult.value =
                                              !refresherResult.value;
                                        },
                                        updateComplete: (cm) {
                                          widget.lcm[index * 2 + 1] = cm;
                                          refresherResult.value =
                                              !refresherResult.value;
                                        },
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
                } else if (widget.cardType == 'card-3') {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: (widget.lcm.length / 2).ceil(),
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
                                  cm: widget.lcm[index * 2],
                                  cc: widget.controller,
                                  delete: () {
                                    widget.lcm.removeAt(index * 2);
                                    refresherResult.value =
                                        !refresherResult.value;
                                  },
                                  updateComplete: (cm) {
                                    widget.lcm[index * 2] = cm;
                                    refresherResult.value =
                                        !refresherResult.value;
                                  },
                                ),
                              ),
                            ),
                            (widget.lcm.length > index * 2 + 1)
                                ? Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        right: 2.0,
                                        bottom: 2.0,
                                        top: 2.0,
                                      ),
                                      child: Card3(
                                        cm: widget.lcm[index * 2 + 1],
                                        cc: widget.controller,
                                        delete: () {
                                          widget.lcm.removeAt(index * 2 + 1);
                                          refresherResult.value =
                                              !refresherResult.value;
                                        },
                                        updateComplete: (cm) {
                                          widget.lcm[index * 2 + 1] = cm;
                                          refresherResult.value =
                                              !refresherResult.value;
                                        },
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
              } else if (widget.contentType == 'advantage') {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: (widget.lcm.length / 2).ceil(),
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
                                ac: widget.lcm[index * 2],
                                acc: widget.controller,
                                delete: () {
                                  widget.lcm.removeAt(index * 2);
                                  refresherResult.value =
                                      !refresherResult.value;
                                },
                                updateComplete: (out) {
                                  widget.lcm[index * 2] = out;
                                  refresherResult.value =
                                      !refresherResult.value;
                                },
                              ),
                            ),
                          ),
                          (widget.lcm.length > index * 2 + 1)
                              ? Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      right: 2.0,
                                      bottom: 2.0,
                                      top: 2.0,
                                    ),
                                    child: AdvantageCard(
                                      ac: widget.lcm[index * 2 + 1],
                                      acc: widget.controller,
                                      delete: () {
                                        widget.lcm.removeAt(index * 2 + 1);
                                        refresherResult.value =
                                            !refresherResult.value;
                                      },
                                      updateComplete: (out) {
                                        widget.lcm[index * 2 + 1] = out;
                                        refresherResult.value =
                                            !refresherResult.value;
                                      },
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
              } else if (widget.contentType == 'testimony') {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.lcm.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        top: 4.0,
                        bottom: 4.0,
                      ),
                      child: TestimonyCard(
                        t: widget.lcm[index],
                        tc: widget.controller,
                        delete: () {
                          widget.lcm.removeAt(index);
                          refresherResult.value = !refresherResult.value;
                        },
                        updateComplete: (out) {
                          widget.lcm[index] = out;
                          refresherResult.value = !refresherResult.value;
                        },
                      ),
                    );
                  },
                );
              } else if (widget.contentType == 'blog') {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: (widget.lcm.length / 2).ceil(),
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
                                b: widget.lcm[index * 2],
                                bc: widget.controller,
                                delete: () {
                                  widget.lcm.removeAt(index * 2);
                                  refresherResult.value =
                                      !refresherResult.value;
                                },
                                updateComplete: (out) {
                                  widget.lcm[index * 2] = out;
                                  refresherResult.value =
                                      !refresherResult.value;
                                },
                              ),
                            ),
                          ),
                          (widget.lcm.length > index * 2 + 1)
                              ? Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      right: 2.0,
                                      bottom: 2.0,
                                      top: 2.0,
                                    ),
                                    child: BlogCard(
                                      b: widget.lcm[index * 2 + 1],
                                      bc: widget.controller,
                                      delete: () {
                                        widget.lcm.removeAt(index * 2 + 1);
                                        refresherResult.value =
                                            !refresherResult.value;
                                      },
                                      updateComplete: (out) {
                                        widget.lcm[index * 2 + 1] = out;
                                        refresherResult.value =
                                            !refresherResult.value;
                                      },
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

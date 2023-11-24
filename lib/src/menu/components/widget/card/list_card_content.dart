
import 'package:danuras_web_service_editor/src/menu/components/widget/card/content_1_card.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/card/content_2_card.dart';
import 'package:flutter/material.dart';

class ListCardContent extends StatefulWidget {
  const ListCardContent({
    super.key,
    required this.lct,
    required this.contentType,
    this.controller,
  });
  final List<dynamic> lct;
  final dynamic controller;
  final String contentType;

  @override
  State<ListCardContent> createState() => _ListCardContentState();
}

class _ListCardContentState extends State<ListCardContent> {
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
              if (widget.contentType == 'content-1') {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: (widget.lct.length / 2).ceil(),
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
                              child: Content1Card(
                                ct: widget.lct[index * 2],
                                ctc: widget.controller,
                                delete: () {
                                  widget.lct.removeAt(index * 2);
                                  refresherResult.value =
                                      !refresherResult.value;
                                },
                                updateComplete: (out) {
                                  widget.lct[index * 2] = out;
                                  refresherResult.value =
                                      !refresherResult.value;
                                },
                              ),
                            ),
                          ),
                          (widget.lct.length > index * 2 + 1)
                              ? Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      right: 2.0,
                                      bottom: 2.0,
                                      top: 2.0,
                                    ),
                                    child: Content1Card(
                                      ct: widget.lct[index * 2 + 1],
                                      ctc: widget.controller,
                                      delete: () {
                                        widget.lct.removeAt(index * 2 + 1);
                                        refresherResult.value =
                                            !refresherResult.value;
                                      },
                                      updateComplete: (out) {
                                        widget.lct[index * 2 + 1] = out;
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
              
              } else if (widget.contentType == 'content-2') {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: (widget.lct.length / 2).ceil(),
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
                              child: Content2Card(
                                ct: widget.lct[index * 2],
                                ctc: widget.controller,
                                delete: () {
                                  widget.lct.removeAt(index * 2);
                                  refresherResult.value =
                                      !refresherResult.value;
                                },
                                updateComplete: (out) {
                                  widget.lct[index * 2] = out;
                                  refresherResult.value =
                                      !refresherResult.value;
                                },
                              ),
                            ),
                          ),
                          (widget.lct.length > index * 2 + 1)
                              ? Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      right: 2.0,
                                      bottom: 2.0,
                                      top: 2.0,
                                    ),
                                    child: Content2Card(
                                      ct: widget.lct[index * 2 + 1],
                                      ctc: widget.controller,
                                      delete: () {
                                        widget.lct.removeAt(index * 2 + 1);
                                        refresherResult.value =
                                            !refresherResult.value;
                                      },
                                      updateComplete: (out) {
                                        widget.lct[index * 2 + 1] = out;
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

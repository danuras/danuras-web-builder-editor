
import 'package:danuras_web_service_editor/src/menu/components/http/custom_future_builder.dart';
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
  ValueNotifier<bool> refresherResult = ValueNotifier(false);
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
                            const WebContentCard(
                              imagePath:
                                  'assets/images/kerangka/header/header-1.png',
                              title: 'Header',
                            ),
                            ValueListenableBuilder(
                                valueListenable: refresherResult,
                                builder: (context, rr, child) {
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
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
                                                  'rank':
                                                      (index / 2 + 1).round(),
                                                  'lwc': lwc
                                                      .map((element) =>
                                                          element.contentType)
                                                      .toList(),
                                                  'wcc': wcc,
                                                  'action': (webContent) {
                                                    lwc.add(webContent);
                                                    incrementRank(
                                                        webContent.rank);
                                                    refresherResult.value =
                                                        !refresherResult.value;
                                                  }
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
                                            isFirst: index == 1,
                                            isLast: index == lwc.length * 2-1,
                                            imagePath:
                                                'assets/images/kerangka/advantage/advantage-1.png',
                                            title: 'Keunggulan',
                                            onTapUpward: () async {
                                              await wcc.update(
                                                action400: (errors) {},
                                                action:
                                                    (WebContent webContent) {
                                                  changePositionDec(
                                                    lwc[((index - 1) / 2)
                                                            .round()]
                                                        .rank,
                                                    ((index - 1) / 2).round(),
                                                  );
                                                  refresherResult.value =
                                                      !refresherResult.value;
                                                },
                                                context: context,
                                                rank: lwc[((index - 1) / 2)
                                                            .round()]
                                                        .rank -
                                                    1,
                                                webContentId: lwc[
                                                        ((index - 1) / 2)
                                                            .round()]
                                                    .id,
                                              );
                                            },
                                            onTapDownward: () async {
                                              await wcc.update(
                                                action400: (errors) {},
                                                action:
                                                    (WebContent webContent) {
                                                  changePositionInc(
                                                    lwc[((index - 1) / 2)
                                                            .round()]
                                                        .rank,
                                                    ((index - 1) / 2).round(),
                                                  );
                                                  refresherResult.value =
                                                      !refresherResult.value;
                                                },
                                                context: context,
                                                rank: lwc[((index - 1) / 2)
                                                            .round()]
                                                        .rank +
                                                    1,
                                                webContentId: lwc[
                                                        ((index - 1) / 2)
                                                            .round()]
                                                    .id,
                                              );
                                            },
                                            onTapEdit: () {
                                              Navigator.of(context).pushNamed(
                                                EditSectionAdvantage.routeName,
                                              );
                                            },
                                            onTapDelete: () async {
                                              popupDelete(
                                                () async {
                                                  await wcc.deleteAdvantage(
                                                    id: lwc[((index - 1) / 2)
                                                            .round()]
                                                        .id,
                                                    context: context,
                                                    action: () {
                                                      decrementRank(
                                                        lwc[((index - 1) / 2)
                                                                .round()]
                                                            .rank,
                                                      );
                                                      lwc.removeAt(
                                                          ((index - 1) / 2)
                                                              .round());
                                                      refresherResult.value =
                                                          !refresherResult
                                                              .value;
                                                    },
                                                  );
                                                  if (context.mounted) {
                                                    Navigator.of(context).pop();
                                                  }
                                                },
                                              );
                                            },
                                          );
                                        } else if (lwc[
                                                    ((index - 1) / 2).round()]
                                                .contentType ==
                                            'card') {
                                          return WebContentCard(
                                            imagePath:
                                                'assets/images/kerangka/card/${lwc[((index - 1) / 2).round()].cardType}.png',
                                            isFirst: index == 1,
                                            isLast: index == lwc.length * 2-1,
                                            title:
                                                lwc[((index - 1) / 2).round()]
                                                    .title!,
                                            onTapEdit: () {
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
                                                    lwc[((index - 1) / 2).round()].title = cardBox.title;
                                                    refresherResult.value = !refresherResult.value;
                                                    Navigator.of(context).pop();
                                                  }
                                                },
                                              );
                                            },
                                            onTapDelete: () {
                                              popupDelete(
                                                () async {
                                                  await wcc.deleteCard(
                                                    id: lwc[((index - 1) / 2)
                                                            .round()]
                                                        .id,
                                                    context: context,
                                                    action: () {
                                                      decrementRank(
                                                        lwc[((index - 1) / 2)
                                                                .round()]
                                                            .rank,
                                                      );
                                                      lwc.removeAt(
                                                          ((index - 1) / 2)
                                                              .round());
                                                      refresherResult.value =
                                                          !refresherResult
                                                              .value;
                                                    },
                                                  );
                                                  if (context.mounted) {
                                                    Navigator.of(context).pop();
                                                  }
                                                },
                                              );
                                            },
                                            onTapUpward: () async {
                                              await wcc.update(
                                                action400: (errors) {},
                                                action:
                                                    (WebContent webContent) {
                                                  changePositionDec(
                                                    lwc[((index - 1) / 2)
                                                            .round()]
                                                        .rank,
                                                    ((index - 1) / 2).round(),
                                                  );
                                                  refresherResult.value =
                                                      !refresherResult.value;
                                                },
                                                context: context,
                                                rank: lwc[((index - 1) / 2)
                                                            .round()]
                                                        .rank -
                                                    1,
                                                webContentId: lwc[
                                                        ((index - 1) / 2)
                                                            .round()]
                                                    .id,
                                              );
                                            },
                                            onTapDownward: () async {
                                              await wcc.update(
                                                action400: (errors) {},
                                                action:
                                                    (WebContent webContent) {
                                                  changePositionInc(
                                                    lwc[((index - 1) / 2)
                                                            .round()]
                                                        .rank,
                                                    ((index - 1) / 2).round(),
                                                  );
                                                  refresherResult.value =
                                                      !refresherResult.value;
                                                },
                                                context: context,
                                                rank: lwc[((index - 1) / 2)
                                                            .round()]
                                                        .rank +
                                                    1,
                                                webContentId: lwc[
                                                        ((index - 1) / 2)
                                                            .round()]
                                                    .id,
                                              );
                                            },
                                          );
                                        } else if (lwc[
                                                    ((index - 1) / 2).round()]
                                                .contentType ==
                                            'testimony') {
                                          return WebContentCard(
                                            isFirst: index == 1,
                                            isLast: index == lwc.length * 2-1,
                                            imagePath:
                                                'assets/images/kerangka/testimony/testimony-1.png',
                                            title: 'Testimoni',
                                            onTapEdit: () {
                                              Navigator.of(context).pushNamed(
                                                EditSectionTestimony.routeName,
                                              );
                                            },
                                            onTapDelete: () async {
                                              popupDelete(
                                                () async {
                                                  await wcc.deleteTestimony(
                                                    id: lwc[((index - 1) / 2)
                                                            .round()]
                                                        .id,
                                                    context: context,
                                                    action: () {
                                                      decrementRank(
                                                        lwc[((index - 1) / 2)
                                                                .round()]
                                                            .rank,
                                                      );
                                                      lwc.removeAt(
                                                          ((index - 1) / 2)
                                                              .round());
                                                      refresherResult.value =
                                                          !refresherResult
                                                              .value;
                                                    },
                                                  );
                                                  if (context.mounted) {
                                                    Navigator.of(context).pop();
                                                  }
                                                },
                                              );
                                            },
                                            onTapUpward: () async {
                                              await wcc.update(
                                                action400: (errors) {},
                                                action:
                                                    (WebContent webContent) {
                                                  changePositionDec(
                                                    lwc[((index - 1) / 2)
                                                            .round()]
                                                        .rank,
                                                    ((index - 1) / 2).round(),
                                                  );
                                                  refresherResult.value =
                                                      !refresherResult.value;
                                                },
                                                context: context,
                                                rank: lwc[((index - 1) / 2)
                                                            .round()]
                                                        .rank -
                                                    1,
                                                webContentId: lwc[
                                                        ((index - 1) / 2)
                                                            .round()]
                                                    .id,
                                              );
                                            },
                                            onTapDownward: () async {
                                              await wcc.update(
                                                action400: (errors) {},
                                                action:
                                                    (WebContent webContent) {
                                                  changePositionInc(
                                                    lwc[((index - 1) / 2)
                                                            .round()]
                                                        .rank,
                                                    ((index - 1) / 2).round(),
                                                  );
                                                  refresherResult.value =
                                                      !refresherResult.value;
                                                },
                                                context: context,
                                                rank: lwc[((index - 1) / 2)
                                                            .round()]
                                                        .rank +
                                                    1,
                                                webContentId: lwc[
                                                        ((index - 1) / 2)
                                                            .round()]
                                                    .id,
                                              );
                                            },
                                          );
                                        } else if (lwc[
                                                    ((index - 1) / 2).round()]
                                                .contentType ==
                                            'blog') {
                                          return WebContentCard(
                                            isFirst: index == 1,
                                            isLast: index == lwc.length * 2-1,
                                            imagePath:
                                                'assets/images/kerangka/blog/blog-1.png',
                                            title: 'Blog',
                                            onTapEdit: () {
                                              Navigator.of(context).pushNamed(
                                                EditSectionBlog.routeName,
                                              );
                                            },
                                            onTapDelete: () async {
                                              popupDelete(
                                                () async {
                                                  await wcc.deleteBlog(
                                                    id: lwc[((index - 1) / 2)
                                                            .round()]
                                                        .id,
                                                    context: context,
                                                    action: () {
                                                      decrementRank(
                                                        lwc[((index - 1) / 2)
                                                                .round()]
                                                            .rank,
                                                      );
                                                      lwc.removeAt(
                                                          ((index - 1) / 2)
                                                              .round());
                                                      refresherResult.value =
                                                          !refresherResult
                                                              .value;
                                                    },
                                                  );
                                                  if (context.mounted) {
                                                    Navigator.of(context).pop();
                                                  }
                                                },
                                              );
                                            },
                                            onTapUpward: () async {
                                              await wcc.update(
                                                action400: (errors) {},
                                                action:
                                                    (WebContent webContent) {
                                                  changePositionDec(
                                                    lwc[((index - 1) / 2)
                                                            .round()]
                                                        .rank,
                                                    ((index - 1) / 2).round(),
                                                  );
                                                  refresherResult.value =
                                                      !refresherResult.value;
                                                },
                                                context: context,
                                                rank: lwc[((index - 1) / 2)
                                                            .round()]
                                                        .rank -
                                                    1,
                                                webContentId: lwc[
                                                        ((index - 1) / 2)
                                                            .round()]
                                                    .id,
                                              );
                                            },
                                            onTapDownward: () async {
                                              await wcc.update(
                                                action400: (errors) {},
                                                action:
                                                    (WebContent webContent) {
                                                  changePositionInc(
                                                    lwc[((index - 1) / 2)
                                                            .round()]
                                                        .rank,
                                                    ((index - 1) / 2).round(),
                                                  );
                                                  refresherResult.value =
                                                      !refresherResult.value;
                                                },
                                                context: context,
                                                rank: lwc[((index - 1) / 2)
                                                            .round()]
                                                        .rank +
                                                    1,
                                                webContentId: lwc[
                                                        ((index - 1) / 2)
                                                            .round()]
                                                    .id,
                                              );
                                            },
                                          );
                                        } else if (lwc[
                                                    ((index - 1) / 2).round()]
                                                .contentType ==
                                            'maps') {
                                          return WebContentCard(
                                            imagePath:
                                                'assets/images/kerangka/location/location-1.png',
                                            title: 'Lokasi',
                                            isFirst: index == 1,
                                            isLast: index == lwc.length * 2-1,
                                            onTapEdit: () {
                                              Navigator.of(context).pushNamed(
                                                EditSectionLocation.routeName,
                                              );
                                            },
                                            onTapDelete: () async {
                                              popupDelete(
                                                () async {
                                                  await wcc.deleteMaps(
                                                    id: lwc[((index - 1) / 2)
                                                            .round()]
                                                        .id,
                                                    context: context,
                                                    action: () {
                                                      decrementRank(
                                                        lwc[((index - 1) / 2)
                                                                .round()]
                                                            .rank,
                                                      );
                                                      lwc.removeAt(
                                                          ((index - 1) / 2)
                                                              .round());
                                                      refresherResult.value =
                                                          !refresherResult
                                                              .value;
                                                    },
                                                  );
                                                  if (context.mounted) {
                                                    Navigator.of(context).pop();
                                                  }
                                                },
                                              );
                                            },
                                            onTapUpward: () async {
                                              await wcc.update(
                                                action400: (errors) {},
                                                action:
                                                    (WebContent webContent) {
                                                  changePositionDec(
                                                    lwc[((index - 1) / 2)
                                                            .round()]
                                                        .rank,
                                                    ((index - 1) / 2).round(),
                                                  );
                                                  refresherResult.value =
                                                      !refresherResult.value;
                                                },
                                                context: context,
                                                rank: lwc[((index - 1) / 2)
                                                            .round()]
                                                        .rank -
                                                    1,
                                                webContentId: lwc[
                                                        ((index - 1) / 2)
                                                            .round()]
                                                    .id,
                                              );
                                            },
                                            onTapDownward: () async {
                                              await wcc.update(
                                                action400: (errors) {},
                                                action:
                                                    (WebContent webContent) {
                                                  changePositionInc(
                                                    lwc[((index - 1) / 2)
                                                            .round()]
                                                        .rank,
                                                    ((index - 1) / 2).round(),
                                                  );
                                                  refresherResult.value =
                                                      !refresherResult.value;
                                                },
                                                context: context,
                                                rank: lwc[((index - 1) / 2)
                                                            .round()]
                                                        .rank +
                                                    1,
                                                webContentId: lwc[
                                                        ((index - 1) / 2)
                                                            .round()]
                                                    .id,
                                              );
                                            },
                                          );
                                        }

                                        return const SizedBox.shrink();
                                      }
                                    },
                                  );
                                }),
                            const WebContentCard(
                              imagePath:
                                  'assets/images/kerangka/footer/footer-1.png',
                              title: 'Footer',
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  void popupDelete(Function() action) {
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
            onPressed: action,
            child: const Text(
              'Ya',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void changePositionInc(int rank, int index) {
    lwc.firstWhere((element) => element.rank == rank + 1).rank = rank;
    lwc[index].rank = rank + 1;
    lwc.sort((a, b) => a.rank.compareTo(b.rank));
  }

  void changePositionDec(int rank, int index) {
    lwc.firstWhere((element) => element.rank == rank - 1).rank = rank;
    lwc[index].rank = rank - 1;
    lwc.sort((a, b) => a.rank.compareTo(b.rank));
  }

  void incrementRank(int rank) {
    lwc.map(
      (element) {
        if (element.rank >= rank) {
          element.rank++;
        }
      },
    );
    lwc.sort((a, b) => a.rank.compareTo(b.rank));
  }

  void decrementRank(int rank) {
    lwc.map(
      (element) {
        if (element.rank < rank) {
          element.rank--;
        }
      },
    );
  }
}

class WebContentCard extends StatelessWidget {
  const WebContentCard({
    super.key,
    required this.imagePath,
    required this.title,
    this.isFirst,
    this.isLast,
    this.onTapEdit,
    this.onTapDelete,
    this.onTapUpward,
    this.onTapDownward,
  });
  final String imagePath, title;
  final bool? isFirst, isLast;
  final Function()? onTapEdit, onTapDelete, onTapUpward, onTapDownward;

  @override
  Widget build(BuildContext context) {
    return Column(
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
          child: Row(
            children: [
              (onTapUpward != null)
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: (isFirst!) ? null : onTapUpward,
                        child: Container(
                          decoration: BoxDecoration(
                            color: (isFirst!) ? Colors.grey : Colors.green,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(4)),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.arrow_drop_up,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
              (onTapDownward != null)
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: (isLast!) ? null : onTapDownward,
                        child: Container(
                          decoration: BoxDecoration(
                            color: (isLast!) ? Colors.grey : Colors.green,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(4)),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              const Spacer(),
              (onTapEdit != null)
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: onTapEdit,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            borderRadius:
                                BorderRadius.all(Radius.circular(4)),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
              (onTapDelete != null)
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: onTapDelete,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            borderRadius:
                                BorderRadius.all(Radius.circular(4)),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
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
    );
  }
}

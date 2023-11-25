import 'package:danuras_web_service_editor/src/menu/components/http/custom_future_builder.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/card/list_card.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/custom_button.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/input_type_bar.dart';
import 'package:danuras_web_service_editor/src/menu/pages/card/add/add_card_1.dart';
import 'package:danuras_web_service_editor/src/menu/pages/card/add/add_card_2.dart';
import 'package:danuras_web_service_editor/src/menu/pages/card/add/add_card_3.dart';
import 'package:danuras_web_service_editor/src/model/card_box.dart';
import 'package:danuras_web_service_editor/src/model/card_model.dart';
import 'package:danuras_web_service_editor/src/view_controller/controller/card_box_controller.dart';
import 'package:danuras_web_service_editor/src/view_controller/controller/card_controller.dart';
import 'package:flutter/material.dart';

class EditSectionCard extends StatefulWidget {
  const EditSectionCard({
    super.key,
    required this.cardBoxId,
    required this.cardType,
    required this.action,
  });
  static const routeName = '/web-content/edit-section-card';
  final int cardBoxId;
  final String cardType;
  final Function(CardBox cardBOx) action;

  @override
  State<EditSectionCard> createState() => _EditSectionCardState();
}

class _EditSectionCardState extends State<EditSectionCard> {
  TextEditingController titleController = TextEditingController(text: '');
  TextEditingController infoController = TextEditingController(text: '');

  ValueNotifier<String?> titleError = ValueNotifier(null);
  ValueNotifier<String?> infoError = ValueNotifier(null);

  ValueNotifier<bool> refresher = ValueNotifier(false),
      refresherResult = ValueNotifier(false);

  CardBoxController cbc = CardBoxController();
  CardController cc = CardController();
  late CardBox cb;
  List<CardModel> lc = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: GestureDetector(
          onTap: () {
            if (widget.cardType == 'card-1') {
              Navigator.of(context).pushNamed(
                AddCard1.routeName,
                arguments: <String, dynamic>{
                  'cc': cc,
                  'action': (card) {
                    lc.add(card);
                    refresherResult.value = !refresherResult.value;
                  },
                  'card_box_id': widget.cardBoxId,
                },
              );
            } else if (widget.cardType == 'card-2'){
              Navigator.of(context).pushNamed(
                AddCard2.routeName,
                arguments: <String, dynamic>{
                  'cc': cc,
                  'action': (card) {
                    lc.add(card);
                    refresherResult.value = !refresherResult.value;
                  },
                  'card_box_id': widget.cardBoxId,
                },
              );
            } else if (widget.cardType == 'card-3'){
              Navigator.of(context).pushNamed(
                AddCard3.routeName,
                arguments: <String, dynamic>{
                  'cc': cc,
                  'action': (card) {
                    lc.add(card);
                    refresherResult.value = !refresherResult.value;
                  },
                  'card_box_id': widget.cardBoxId,
                },
              );
            } 
          },
          child: Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: const Color(0xff110011),
              borderRadius: const BorderRadius.all(Radius.circular(35)),
              border: Border.all(width: 2, color: Colors.white),
            ),
            child: const Icon(
              Icons.add,
              color: Colors.white,
              size: 50,
            ),
          ),
        ),
        appBar: AppBar(
          title: const Text('Ubah Bagian Kartu'),
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
              child: ValueListenableBuilder(
                valueListenable: refresher,
                builder: (context, r, child) {
                  return CustomFutureBuilder(
                    future: cbc.show(widget.cardBoxId),
                    widgetResult: (result) {
                      cb = result['data']['card_box'];
                      titleController.text = cb.title;
                      infoController.text = cb.info;
                      lc = result['data']['cards'];
                      return Padding(
                        padding: const EdgeInsets.only(
                          left: 8.0,
                          right: 8.0,
                        ),
                        child: ListView(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            InputTypeBar(
                              labelText: 'Judul',
                              tooltip:
                                  'Masukan judul bagian yang menampilkan kartu',
                              errorText: titleError,
                              controller: titleController,
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            InputTypeBar(
                              labelText: 'Info',
                              tooltip:
                                  'Masukan informasi tambahan untuk bagian ini',
                              errorText: infoError,
                              controller: infoController,
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            CustomButton(
                              text: 'Simpan',
                              action: () async {
                                resetError();
                                await cbc.update(
                                  title: titleController.text,
                                  info: infoController.text,
                                  cardBoxId: widget.cardBoxId,
                                  context: context,
                                  action: widget.action,
                                  action400: (errors) {
                                    checkError(errors);
                                  },
                                );
                              },
                            ),
                            ValueListenableBuilder(
                              valueListenable: refresherResult,
                              builder: (context, rr, child) {
                                return ListCard(
                                  lcm: lc,
                                  controller: cc,
                                  contentType: 'card',
                                  cardType: widget.cardType,
                                );
                              },
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

  void resetError() {
    infoError.value = null;
    titleError.value = null;
  }

  void checkError(errors) {
    if (errors.containsKey('info')) {
      infoError.value = errors['info'][0];
    }
    if (errors.containsKey('title')) {
      titleError.value = errors['title'][0];
    }
  }
}

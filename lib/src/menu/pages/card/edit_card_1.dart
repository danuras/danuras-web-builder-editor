import 'package:danuras_web_service_editor/src/menu/components/http/custom_future_builder.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/custom_button.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/input_type_bar.dart';
import 'package:danuras_web_service_editor/src/menu/pages/auth/input_email.dart';
import 'package:danuras_web_service_editor/src/model/card_box.dart';
import 'package:danuras_web_service_editor/src/model/card_model.dart';
import 'package:danuras_web_service_editor/src/view_controller/controller/auth_controller.dart';
import 'package:danuras_web_service_editor/src/view_controller/controller/card_box_controller.dart';
import 'package:flutter/material.dart';

class EditCard1 extends StatefulWidget {
  const EditCard1({
    super.key,
    required this.cardBoxId,
    required this.cardType,
    required this.action,
  });
  static const routeName = '/edit-card-1';
  final int cardBoxId;
  final String cardType;
  final Function(CardBox cardBOx) action;

  @override
  State<EditCard1> createState() => _EditCard1State();
}

class _EditCard1State extends State<EditCard1> {
  TextEditingController titleController = TextEditingController(text: '');
  TextEditingController infoController = TextEditingController(text: '');

  ValueNotifier<String?> titleError = ValueNotifier(null);
  ValueNotifier<String?> infoError = ValueNotifier(null);

  ValueNotifier<bool> refresher = ValueNotifier(false);

  CardBoxController cbc = CardBoxController();
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
        appBar: AppBar(
          title: const Text('Edit Bagian'),
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
                            const SizedBox(height: 10,),
                            InputTypeBar(
                              labelText: 'Judul',
                              tooltip: 'Masukan judul bagian yang menampilkan kartu',
                              errorText: titleError,
                              controller: titleController,
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            InputTypeBar(
                              labelText: 'Info',
                              tooltip: 'Masukan informasi tambahan untuk bagian ini',
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
                            
                          ],
                        ),
                      );
                    }
                  );
                }
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

import 'dart:developer';
import 'dart:io';

import 'package:danuras_web_service_editor/src/menu/components/widget/custom_button.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/input_cirle_image.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/input_type_Bar.dart';
import 'package:danuras_web_service_editor/src/model/order_flow.dart';
import 'package:danuras_web_service_editor/src/view_controller/controller/order_flow_controller.dart';
import 'package:flutter/material.dart';

class AddOrderFlow extends StatefulWidget {
  const AddOrderFlow({super.key, required this.ofc, required this.action});
  static const routeName = '/order-flow/add';
  final OrderFlowController ofc;
  final Function(OrderFlow orderFlow) action;

  @override
  State<AddOrderFlow> createState() => _AddOrderFlowState();
}

class _AddOrderFlowState extends State<AddOrderFlow> {
  TextEditingController stepController = TextEditingController(text: '');
  ValueNotifier<String?> stepError = ValueNotifier(null);
  ValueNotifier<String?> imageError = ValueNotifier(null);

  File? image;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Tambah Langkah Pemesanan'),
          backgroundColor: const Color(0xff110011),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
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
            child: Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
                right: 8.0,
                top: 16.0,
              ),
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                    color: const Color(0xff110011),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InputCircleImage(
                        action: (result) {
                          image = result;
                        },
                      ),
                      SizedBox(
                        height: 20,
                        child: ValueListenableBuilder(
                          valueListenable: imageError,
                          builder: (context, ie, child) {
                            if (ie != null) {
                              return Text(
                                ie,
                                style: const TextStyle(
                                  color: Colors.red,
                                ),
                              );
                            } else {
                              return const SizedBox.shrink();
                            }
                          },
                        ),
                      ),
                      const Divider(
                        color: Colors.white,
                      ),
                      InputTypeBar(
                        labelText: 'Langkah',
                        tooltip:
                            'Masukan teks yang menunjukan langkah pemesanan',
                        errorText: stepError,
                        controller: stepController,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomButton(
                          text: 'Tambah',
                          action: () async {
                            resetError();

                            await widget.ofc.create(
                              value: stepController.text,
                              icon: image,
                              context: context,
                              action: (a) {
                                widget.action(a);
                                Navigator.of(context).pop();
                              },
                              action400: (errors) {
                                log(errors.toString());
                                resetError();
                                checkError(errors);
                              },
                            );
                          }),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void resetError() {
    stepError.value = null;
    imageError.value = null;
  }

  void checkError(errors) {
    if (errors.containsKey('value')) {
      stepError.value = errors['value'][0];
    }
    if (errors.containsKey('icon')) {
      imageError.value = errors['icon'][0];
    }
  }
}

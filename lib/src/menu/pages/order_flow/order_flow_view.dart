import 'dart:io';

import 'package:danuras_web_service_editor/src/menu/components/http/custom_future_builder.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/custom_button.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/input_square_image.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/input_type_Bar.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/input_type_icon.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/order_flow_widget.dart';
import 'package:danuras_web_service_editor/src/menu/pages/order_flow/add_order_flow.dart';
import 'package:danuras_web_service_editor/src/model/order_flow.dart';
import 'package:danuras_web_service_editor/src/view_controller/controller/order_flow_controller.dart';
import 'package:flutter/material.dart';

class OrderFlowView extends StatefulWidget {
  const OrderFlowView({super.key});
  static const routeName = '/order-flow';

  @override
  State<OrderFlowView> createState() => _OrderFlowViewState();
}

class _OrderFlowViewState extends State<OrderFlowView> {
  List<OrderFlow> lof = [];
  OrderFlowController ofc = OrderFlowController();
  ValueNotifier<bool> refresher = ValueNotifier(false);
  ValueNotifier<bool> refresherResult = ValueNotifier(false);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Langkah-langkah pemesanan'),
          backgroundColor: const Color(0xff110011),
        ),
        floatingActionButton: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              AddOrderFlow.routeName,
              arguments: <String, dynamic>{
                'ofc': ofc,
                'action': (orderFlow) {
                  lof.add(orderFlow);
                  refresherResult.value = !refresherResult.value;
                }
              },
            );
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
            child: RefreshIndicator(
              onRefresh: () async {
                refresher.value = !refresher.value;
              },
              child: ValueListenableBuilder(
                valueListenable: refresher,
                builder: (context, r, child) {
                  return CustomFutureBuilder(
                    future: ofc.show(),
                    widgetResult: (Map<String, dynamic> result) {
                      lof = result['data'];
                      return ValueListenableBuilder(
                        valueListenable: refresherResult,
                        builder: (context, rr, child) {
                          return Padding(
                            padding: const EdgeInsets.only(
                              left: 8.0,
                              right: 8.0,
                              top: 16.0,
                            ),
                            child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                              ),
                              itemCount: lof.length,
                              itemBuilder: (context, index) {
                                return OrderFlowWidget(
                                  orderFlow: lof[index],
                                  index: index,
                                  ofc: ofc,
                                  updateComplete: (OrderFlow orderFlow) {
                                    lof[index] = orderFlow;
                                    refresherResult.value = !refresherResult.value;
                                  },
                                  deleteComplete: () {
                                    lof.removeAt(index);
                                    refresherResult.value = !refresherResult.value;
                                  },
                                );
                              },
                            ),
                          );
                        },
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
}

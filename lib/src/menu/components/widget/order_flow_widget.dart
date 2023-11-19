import 'package:danuras_web_service_editor/src/model/endpoint.dart';
import 'package:danuras_web_service_editor/src/model/order_flow.dart';
import 'package:flutter/material.dart';

class OrderFlowWidget extends StatelessWidget {
  const OrderFlowWidget({
    super.key,
    required this.orderFlow,
    required this.index,
  });
  final OrderFlow orderFlow;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
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
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(width: 2, color: Colors.white),
              borderRadius: const BorderRadius.all(Radius.circular(50)),
              image: DecorationImage(
                image: NetworkImage(EndPoint.simple + orderFlow.icon),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Divider(
            color: Colors.white,
          ),
          Text('${index+1}. ${orderFlow.value}', style: const TextStyle(color: Colors.white),),
        ],
      ),
    );
  }
}

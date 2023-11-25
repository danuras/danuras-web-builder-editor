import 'package:danuras_web_service_editor/src/menu/pages/order_flow/edit_order_flow.dart';
import 'package:danuras_web_service_editor/src/model/endpoint.dart';
import 'package:danuras_web_service_editor/src/model/order_flow.dart';
import 'package:danuras_web_service_editor/src/view_controller/controller/order_flow_controller.dart';
import 'package:flutter/material.dart';

class OrderFlowWidget extends StatelessWidget {
  const OrderFlowWidget({
    super.key,
    required this.orderFlow,
    required this.ofc,
    required this.index,
    required this.updateComplete,
    required this.deleteComplete,
  });
  final OrderFlow orderFlow;
  final OrderFlowController ofc;
  final Function(OrderFlow orderFlow) updateComplete;
  final Function() deleteComplete;
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
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
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
                      image: NetworkImage(EndPoint.simple! + orderFlow.icon),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const Divider(
                  color: Colors.white,
                ),
                Text(
                  '${index + 1}. ${orderFlow.value}',
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    EditOrderFlow.routeName,
                    arguments: <String, dynamic>{
                      'ofc': ofc,
                      'action': updateComplete,
                      'order_flow': orderFlow,
                    },
                  );
                },
                child: Container(
                  width: 35,
                  height: 35,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  child: const Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () async {
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
                          onPressed: () async {
                            await ofc.delete(
                                id: orderFlow.id,
                                context: context,
                                action: deleteComplete);
                            if (context.mounted) {
                              Navigator.of(context).pop();
                            }
                          },
                          child: const Text(
                            'Ya',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                child: Container(
                  width: 35,
                  height: 35,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                  ),
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

import 'package:danuras_web_service_editor/src/menu/list_menu.dart';
import 'package:danuras_web_service_editor/src/model/endpoint.dart';
import 'package:danuras_web_service_editor/src/view_controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class EndPointController extends BaseController {
  Future<void> save(String endpoint, BuildContext context) async {
    var box = await Hive.openBox('endpoint');
    box.put('value', endpoint);
    EndPoint.value = '$endpoint/api/';
    EndPoint.simple = endpoint;
    if (context.mounted) {
      revoke(context);
    }
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:danuras_web_service_editor/src/view_controller/controller.dart';
import 'package:danuras_web_service_editor/src/model/auth.dart';
import 'package:danuras_web_service_editor/src/model/endpoint.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class CardBoxApiController extends BaseController {
  Future<http.Response> create(
    String cardType,
    String title,
    String info,
  ) async {
    var uri = Uri.parse('${EndPoint.value}card-box/create');
    final response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset-UTF-8',
        'Authorization': 'Bearer ${Auth.accessToken}',
      },
      body: jsonEncode(<String, dynamic> {
        'card_type': cardType,
        'title': title,
        'info': info,
      })
    );
    return response;
  }

  Future<http.Response> update(
    int cardBoxId,
    String title,
    String info,
  ) async {
    var uri = Uri.parse('${EndPoint.value}card-box/update');
    final response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset-UTF-8',
        'Authorization': 'Bearer ${Auth.accessToken}',
      },
      body: jsonEncode(<String, dynamic> {
        'card_box_id': cardBoxId,
        'title': title,
        'info': info,
      })
    );
    return response;
  }

  Future<http.Response> show(int id) async {
    var uri = Uri.parse('${EndPoint.value}card-box/show/$id');
    final response = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset-UTF-8',
        'Authorization': 'Bearer ${Auth.accessToken}',
      },
    );
    return response;
  }
}

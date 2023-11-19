import 'dart:io';

import 'package:danuras_web_service_editor/src/view_controller/controller.dart';
import 'package:danuras_web_service_editor/src/model/auth.dart';
import 'package:danuras_web_service_editor/src/model/endpoint.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class WebContentApiController extends BaseController {
  Future<http.Response> create(
    String contentType,
    int? cardBoxId,
    int rank,
  ) async {
    var uri = Uri.parse('${EndPoint.value}web-content/create');
    final response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset-UTF-8',
        'Authorization': 'Bearer ${Auth.accessToken}',
      },
      body: <String, dynamic> {
        'content_type': contentType,
        'card_box_id': cardBoxId,
        'rank': rank,
      }
    );
    return response;
  }

  Future<http.Response> update(
    int rank,
    int webContentId,
  ) async {
    var uri = Uri.parse('${EndPoint.value}web-content/update');
    final response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset-UTF-8',
        'Authorization': 'Bearer ${Auth.accessToken}',
      },
      body: <String, dynamic> {
        'web_content_id': webContentId,
        'rank': rank,
      }
    );
    return response;
  }

  Future<http.Response> delete(int id) async {
    var uri = Uri.parse('${EndPoint.value}web-content/delete/$id');
    final response = await http.delete(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset-UTF-8',
        'Authorization': 'Bearer ${Auth.accessToken}',
      },
    );
    return response;
  }

  Future<http.Response> show() async {
    var uri = Uri.parse('${EndPoint.value}web-content/show');
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

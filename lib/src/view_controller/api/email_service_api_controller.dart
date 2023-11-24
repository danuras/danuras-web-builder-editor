import 'dart:convert';

import 'package:danuras_web_service_editor/src/model/email_service.dart';
import 'package:danuras_web_service_editor/src/view_controller/controller.dart';
import 'package:danuras_web_service_editor/src/model/auth.dart';
import 'package:danuras_web_service_editor/src/model/endpoint.dart';
import 'package:http/http.dart' as http;

class EmailServiceApiController extends BaseController {
  Future<http.Response> createOrUpdate(EmailService emailService) async {
    var uri = Uri.parse('${EndPoint.value}email-service/create-or-update');
    final response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${Auth.accessToken}',
      },
      body: jsonEncode(emailService.toJson()),
    );
    return response;
  }

  Future<http.Response> show() async {
    var uri = Uri.parse('${EndPoint.value}email-service/show');
    final response = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${Auth.accessToken}',
      },
    );
    return response;
  }
}

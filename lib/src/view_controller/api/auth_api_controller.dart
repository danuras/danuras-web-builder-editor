import 'dart:convert';

import 'package:danuras_web_service_editor/src/view_controller/controller.dart';
import 'package:danuras_web_service_editor/src/model/auth.dart';
import 'package:danuras_web_service_editor/src/model/endpoint.dart';
import 'package:http/http.dart' as http;

class AuthApiController extends BaseController {
  Future<http.Response> login(
    String email,
    String password,
  ) async {
    var uri = Uri.parse('${EndPoint.value}auth/login');
    final response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'email': email,
        'password': password,
      }),
    );
    return response;
  }

  Future<http.Response> logout() async {
    var uri = Uri.parse('${EndPoint.value}auth/logout');
    final response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${Auth.accessToken}',
      },
    );
    return response;
  }

  Future<http.Response> logoutAllDevice() async {
    var uri = Uri.parse('${EndPoint.value}auth/logout-all-device');
    final response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${Auth.accessToken}',
      },
    );
    return response;
  }

  Future<http.Response> requestForgetPassword(
    String email,
  ) async {
    var uri = Uri.parse('${EndPoint.value}auth/request-forget-password');
    final response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'email': email,
      }),
    );
    return response;
  }

  Future<http.Response> sendTokenVerification(
    String email,
  ) async {
    var uri = Uri.parse('${EndPoint.value}auth/send-token-verification');
    final response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'email': email,
      }),
    );
    return response;
  }

  Future<http.Response> verifyUpdatePassword(String email, String token,
      String password, String passwordConfirmation) async {
    var uri = Uri.parse('${EndPoint.value}auth/verify-update-password');
    final response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'email': email,
        'token': token,
        'password': password,
        'password_confirmation': passwordConfirmation,
      }),
    );
    return response;
  }
}

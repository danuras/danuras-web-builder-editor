import 'dart:convert';
import 'dart:io';

import 'package:danuras_web_service_editor/src/view_controller/controller.dart';
import 'package:danuras_web_service_editor/src/model/auth.dart';
import 'package:danuras_web_service_editor/src/model/endpoint.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class UserApiController extends BaseController {
  Future<http.Response> registerUser(
    String email,
    String password,
    String passwordConfirmation
  ) async {
    var uri = Uri.parse('${EndPoint.value}user/register-user');
    final response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${Auth.accessToken}',
      },
      body: jsonEncode(<String,dynamic>{
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
      })
    );
    return response;
  }

  Future<http.Response> delete(
    String email,
  ) async {
    var uri = Uri.parse('${EndPoint.value}user/delete');
    final response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${Auth.accessToken}',
      },
      body: jsonEncode(<String,dynamic>{
        'email': email,
      })
    );
    return response;
  }

  Future<http.Response> changePrimary(
    String email,
  ) async {
    var uri = Uri.parse('${EndPoint.value}user/change-primary');
    final response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${Auth.accessToken}',
      },
      body: jsonEncode(<String,dynamic>{
        'email': email,
      })
    );
    return response;
  }

  Future<http.Response> show() async {
    var uri = Uri.parse('${EndPoint.value}user/show');
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

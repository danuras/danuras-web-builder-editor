import 'dart:convert';
import 'dart:developer';

import 'package:danuras_web_service_editor/src/menu/list_menu.dart';
import 'package:danuras_web_service_editor/src/model/auth.dart';
import 'package:danuras_web_service_editor/src/model/endpoint.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class BaseController {
  success(BuildContext context, String? message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message ?? "Permintaan berhasil"),
      ),
    );
  }

  failed(BuildContext context, String? message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message ?? "Permintaan gagal"),
      ),
    );
  }

  timeout(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Connection Timeout'),
      ),
    );
  }

  error(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  Future<void> revoke(BuildContext context) async {
    var box = await Hive.openBox('auth');
    box.put('access_token', null);
    box.put('is_primary', null);
    Auth.accessToken = null;
    Auth.isPrimary = false;
    if (context.mounted) {
          Navigator.of(context).popUntil(ModalRoute.withName('/'));
          Navigator.of(context).pushReplacementNamed(ListMenu.routeName);
    }
  }

  Map<String, dynamic> successOutput(dynamic data) {
    return <String, dynamic>{
      'success': true,
      'status_code': 200,
      'data': data,
    };
  }

  Map<String, dynamic> customFailOutput(dynamic data, Widget customFailWidget) {
    return <String, dynamic>{
      'success': true,
      'status_code': 503,
      'custom_fail_widget': customFailWidget,
      'data': data,
    };
  }

  Map<String, dynamic> failOutput() {
    return <String, dynamic>{
      'success': false,
      'status_code': 400,
      'data': null,
    };
  }

  Map<String, dynamic> notFound() {
    return <String, dynamic>{
      'success': false,
      'status_code': 404,
      'data': null,
    };
  }

  Map<String, dynamic> lostConnection() {
    return <String, dynamic>{
      'success': false,
      'status_code': 502,
      'data': null,
    };
  }

  Map<String, dynamic> dynamicError() {
    return <String, dynamic>{
      'success': false,
      'status_code': 500,
      'data': null,
    };
  }

  Map<String, dynamic> needAuthentication() {
    return <String, dynamic>{
      'success': false,
      'status_code': 401,
      'data': null,
    };
  }

  Map<String, dynamic> needVerification() {
    return <String, dynamic>{
      'success': false,
      'status_code': 403,
      'data': null,
    };
  }

  Map<String, dynamic> checkError(Object e) {
    if (e.toString() == 'Connection closed before full header was received') {
      return lostConnection();
    }
    if (e is ClientException) {
      if (e.message.startsWith('Connection Closed') ||
          e.message.startsWith('Connection Terminated')) {
        return lostConnection();
      }
    } else if (e is FormatException) {
      return lostConnection();
    }

    return dynamicError();
  }
}

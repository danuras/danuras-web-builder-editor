import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:danuras_web_service_editor/src/model/email_service.dart';
import 'package:danuras_web_service_editor/src/view_controller/api/email_service_api_controller.dart';
import 'package:danuras_web_service_editor/src/view_controller/controller.dart';
import 'package:flutter/material.dart';

class EmailServiceController extends BaseController {
  final _esac = EmailServiceApiController();
  Future<void> createOrUpdate({
    required EmailService emailService,
    required BuildContext context,
    required Function() action,
    required Function(dynamic errors) action400,
  }) async {
    try {
      var response = await _esac.createOrUpdate(
        emailService,
      );

      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        action();
        if (context.mounted) {
          success(context, null);
        }
      } else if (response.statusCode == 400) {
        action400(result['errors']);
      } else if (response.statusCode == 401) {
        if (context.mounted) {
          revoke(context);
        }
      } else {
        if (context.mounted) {
          failed(context, null);
        }
      }
    } catch (e) {
      if (e is TimeoutException) {
        // menangani koneksi timeout
        timeout(context);
      } else {
        error(context, 'Error: $e');
      }
    }
  }

  Future<Map<String, dynamic>?> show() async {
    try {
      var response = await _esac.show();
      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (result['data'] != null) {
          return successOutput(EmailService.fromJson(result['data']));
        } else {
          return successOutput(null);
        }
      } else if (response.statusCode == 401) {
        return needAuthentication();
      } else {
        return failOutput();
      }
    } catch (e) {
      log(e.toString());
      return checkError(e);
    }
  }
}

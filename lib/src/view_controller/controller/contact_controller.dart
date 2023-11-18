import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:danuras_web_service_editor/src/model/contact.dart';
import 'package:danuras_web_service_editor/src/view_controller/api/contact_api_controller.dart';
import 'package:danuras_web_service_editor/src/view_controller/controller.dart';
import 'package:flutter/material.dart';

class ContactController extends BaseController {
  final _esac = ContactApiController();
  Future<void> createOrUpdate({
    required String whatsapp,
    required String whatsappMessage,
    required String callNumber,
    required String address,
    required String email,
    required String infoContact,
    required String embededMapUrl,
    required String infoLocation,
    required File? backgroundContact,
    required BuildContext context,
    required Function() action,
    required Function(dynamic errors) action400,
  }) async {
    try {
      var response = await _esac.createOrUpdate(
        whatsapp,
        whatsappMessage,
        callNumber,
        address,
        email,
        infoContact,
        embededMapUrl,
        infoLocation,
        backgroundContact,
      );

      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (context.mounted) {
          success(context, null);
        }
      } else if (response.statusCode == 400) {
        action400(result);
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
        return successOutput(Contact.fromJson(result['data']));
      } else if (response.statusCode == 401) {
        return needAuthentication();
      } else {
        return failOutput();
      }
    } catch (e) {
      return checkError(e);
    }
  }
}

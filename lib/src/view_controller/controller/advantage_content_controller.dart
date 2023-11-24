import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:danuras_web_service_editor/src/model/advantage_content.dart';
import 'package:danuras_web_service_editor/src/view_controller/api/advantage_content_api_controller.dart';
import 'package:danuras_web_service_editor/src/view_controller/controller.dart';
import 'package:flutter/material.dart';

class AdvantageContentController extends BaseController {
  final _acac = AdvantageContentApiController();
  Future<void> create({
    required String title,
    required String text,
    required File? icon,
    required BuildContext context,
    required Function(AdvantageContent advantageContent) action,
    required Function(dynamic errors) action400,
  }) async {
    try {
      var response = await _acac.create(
        title,
        text,
        icon,
      );

      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        action(AdvantageContent.fromJson(result['data']));
        if(context.mounted){
          Navigator.of(context).pop();
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

  Future<void> update({
    required int advantageId,
    required String title,
    required String text,
    required File? icon,
    required BuildContext context,
    required Function(AdvantageContent advantageContent) action,
    required Function(dynamic errors) action400,
  }) async {
    try {
      var response = await _acac.update(
        advantageId,
        title,
        text,
        icon,
      );

      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        action(AdvantageContent.fromJson(result['data']));
        if(context.mounted){
          Navigator.of(context).pop();
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

  Future<void> delete({
    required int id,
    required BuildContext context,
    required Function() action,
  }) async {
    try {
      var response = await _acac.delete(
        id,
      );

      if (response.statusCode == 200) {
        action();
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
      var response = await _acac.show();
      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return successOutput(AdvantageContent.fromJson(result['data']));
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

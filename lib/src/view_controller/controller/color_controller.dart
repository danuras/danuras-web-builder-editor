import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:danuras_web_service_editor/src/model/color_model.dart';
import 'package:danuras_web_service_editor/src/view_controller/api/color_api_controller.dart';
import 'package:danuras_web_service_editor/src/view_controller/controller.dart';
import 'package:flutter/material.dart';

class ColorController extends BaseController {
  final _cac = ColorApiController();
  Future<void> createOrUpdate({
    required ColorModel colorModel,
    required BuildContext context,
    required Function() action,
    required Function(dynamic errors) action400,
  }) async {
    try {
      var response = await _cac.createOrUpdate(colorModel);
      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {
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
      var response = await _cac.show();
      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return successOutput(ColorModel.fromJson(result['data']));
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

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:danuras_web_service_editor/src/model/web_attribute.dart';
import 'package:danuras_web_service_editor/src/view_controller/api/web_attribute_api_controller.dart';
import 'package:danuras_web_service_editor/src/view_controller/controller.dart';
import 'package:flutter/material.dart';

class WebAttributeController extends BaseController {
  final _esac = WebAttributeApiController();
  Future<void> createOrUpdate({
    required String title,
    required String shortDescription,
    required String longTitle,
    required String mainHeading,
    required String subHeading,
    required File? icon,
    required File? backgroundImage,
    required BuildContext context,
    required Function() action,
    required Function(dynamic errors) action400,
  }) async {
    try {
      var response = await _esac.createOrUpdate(
        title,
        shortDescription,
        longTitle,
        mainHeading,
        subHeading,
        icon,
        backgroundImage,
      );

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
      var response = await _esac.show();
      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (result['data'] != null) {
          return successOutput(WebAttribute.fromJson(result['data']));
        } else {
          return successOutput(null);
        }
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

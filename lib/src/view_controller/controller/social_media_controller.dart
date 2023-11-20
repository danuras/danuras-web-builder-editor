import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:danuras_web_service_editor/src/model/contact_model.dart';
import 'package:danuras_web_service_editor/src/model/social_media_model.dart';
import 'package:danuras_web_service_editor/src/view_controller/api/social_media_api_controller.dart';
import 'package:danuras_web_service_editor/src/view_controller/controller.dart';
import 'package:flutter/material.dart';

class SocialMediaController extends BaseController {
  final _smac = SocialMediaApiController();
  Future<void> createOrUpdate({
    required SocialMediaModel socialMedia,
    required BuildContext context,
    required Function() action,
    required Function(dynamic errors) action400,
  }) async {
    try {
      var response = await _smac.createOrUpdate(socialMedia);

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
      var response = await _smac.show();
      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (result['data'] != null) {
          return successOutput(SocialMediaModel.fromJson(result['data']));
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

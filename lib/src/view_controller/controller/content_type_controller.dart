import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:danuras_web_service_editor/src/model/content_type.dart';
import 'package:danuras_web_service_editor/src/view_controller/api/content_type_api_controller.dart';
import 'package:danuras_web_service_editor/src/view_controller/controller.dart';
import 'package:flutter/material.dart';

class ContentTypeController extends BaseController {
  final _ctac = ContentTypeApiController();
  Future<void> create({
    required ContentType contentType,
    File? imageUrl,
    required BuildContext context,
    required Function(ContentType contentType) action,
    required Function(dynamic errors) action400,
  }) async {
    try {
      var response = await _ctac.create(
        contentType,
        imageUrl,
      );

      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        action(ContentType.fromJson(result['data']));
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

  Future<void> update({
    required ContentType contentType,
    File? imageUrl,
    required BuildContext context,
    required Function(ContentType contentType) action,
    required Function(dynamic errors) action400,
  }) async {
    try {
      var response = await _ctac.update(
        contentType,
        imageUrl,
      );

      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        action(ContentType.fromJson(result['data']));
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

  Future<void> delete(
    int id,
    BuildContext context,
    Function() action,
  ) async {
    try {
      var response = await _ctac.delete(id);

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
}

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:danuras_web_service_editor/src/model/testimony.dart';
import 'package:danuras_web_service_editor/src/view_controller/api/testimony_api_controller.dart';
import 'package:danuras_web_service_editor/src/view_controller/controller.dart';
import 'package:flutter/material.dart';

class TestimonyController extends BaseController {
  final _tac = TestimonyApiController();
  Future<void> create({
    required String value,
    required String name,
    required String job,
    required File? photoProfile,
    required BuildContext context,
    required Function(Testimony testimony) action,
    required Function(dynamic errors) action400,
  }) async {
    try {
      var response = await _tac.create(
        value,
        name,
        job,
        photoProfile,
      );

      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        action(Testimony.fromJson(result['data']));
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
    required int testimonyid,
    required String value,
    required String name,
    required String job,
    required File? photoProfile,
    required BuildContext context,
    required Function(Testimony testimony) action,
    required Function(dynamic errors) action400,
  }) async {
    try {
      var response = await _tac.update(
        testimonyid,
        value,
        name,
        job,
        photoProfile,
      );

      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        action(Testimony.fromJson(result['data']));
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

  Future<void> updateBackground({
    required File? background,
    required BuildContext context,
    required Function(Testimony testimony) action,
    required Function(dynamic errors) action400,
  }) async {
    try {
      var response = await _tac.updateBackground(
        background,
      );

      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        action(Testimony.fromJson(result['data']));
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
      var response = await _tac.delete(
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
      var response = await _tac.show();
      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return successOutput({
          'testimonies': List.generate(
            result['data']['testimonies'].length,
            (index) => Testimony.fromJson(result['data']['testimonies'][index]),
          ),
          'background_testimonies': result['data']['background_testimonies'],
        });
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

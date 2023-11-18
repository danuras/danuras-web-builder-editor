import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:danuras_web_service_editor/src/model/company_profile.dart';
import 'package:danuras_web_service_editor/src/model/contact.dart';
import 'package:danuras_web_service_editor/src/model/order_flow.dart';
import 'package:danuras_web_service_editor/src/view_controller/api/company_profile_api_controller.dart';
import 'package:danuras_web_service_editor/src/view_controller/api/contact_api_controller.dart';
import 'package:danuras_web_service_editor/src/view_controller/api/order_flow_api_controller.dart';
import 'package:danuras_web_service_editor/src/view_controller/controller.dart';
import 'package:flutter/material.dart';

class OrderFlowController extends BaseController {
  final _ofac = OrderFlowApiController();
  Future<void> create({
    required String value,
    required File? icon,
    required BuildContext context,
    required Function(OrderFlow orderFlow) action,
    required Function(dynamic errors) action400,
  }) async {
    try {
      var response = await _ofac.create(
        value,
        icon,
      );

      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        action(OrderFlow.fromJson(result['data']));
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
    required String value,
    required File? icon,
    required BuildContext context,
    required Function(OrderFlow orderFlow) action,
    required Function(dynamic errors) action400,
  }) async {
    try {
      var response = await _ofac.update(
        value,
        icon,
      );

      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        action(OrderFlow.fromJson(result['data']));
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

  Future<void> delete({
    required int id,
    required BuildContext context,
    required Function() action,
  }) async {
    try {
      var response = await _ofac.delete(
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
      var response = await _ofac.show();
      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return successOutput(OrderFlow.fromJson(result['data']));
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
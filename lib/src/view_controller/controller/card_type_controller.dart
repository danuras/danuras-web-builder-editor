import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:danuras_web_service_editor/src/model/card_type.dart';
import 'package:danuras_web_service_editor/src/model/content_type.dart';
import 'package:danuras_web_service_editor/src/view_controller/api/card_type_api_controller.dart';
import 'package:danuras_web_service_editor/src/view_controller/controller.dart';
import 'package:flutter/material.dart';

class CardTypeController extends BaseController {
  final _ctac = CardTypeApiController();
  Future<void> create({
    required CardType cardType,
    required String contentType,
    File? imageUrl,
    required BuildContext context,
    required Function(CardType cardType) action,
    required Function(dynamic errors) action400,
  }) async {
    try {
      var response = await _ctac.create(
        cardType,
        contentType,
        imageUrl,
      );

      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        action(CardType.fromJson(result['data']));
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
    required CardType cardType,
    File? imageUrl,
    required BuildContext context,
    required Function(CardType cardType) action,
    required Function(dynamic errors) action400,
  }) async {
    try {
      var response = await _ctac.update(
        cardType,
        imageUrl,
      );

      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        action(CardType.fromJson(result['data']));
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

  Future<Map<String, dynamic>?> show(int id) async {
    try {
      var response = await _ctac.show(id);
      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return successOutput(
          {
            'card_type': CardType.fromJson(result['data']['card_type']),
            'content_types': List.generate(
              result['data']['content_types'].length,
              (index) => ContentType.fromJson(
                result['data']['content_types'][index],
              ),
            ),
          },
        );
      } else if (response.statusCode == 401) {
        return needAuthentication();
      } else {
        return failOutput();
      }
    } catch (e) {
      return checkError(e);
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

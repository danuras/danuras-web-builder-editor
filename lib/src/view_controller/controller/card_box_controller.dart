import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:danuras_web_service_editor/src/model/card.dart' as c;
import 'package:danuras_web_service_editor/src/model/card_box.dart';
import 'package:danuras_web_service_editor/src/view_controller/api/blog_api_controller.dart';
import 'package:danuras_web_service_editor/src/view_controller/api/card_box_api_controller.dart';
import 'package:danuras_web_service_editor/src/view_controller/controller.dart';
import 'package:flutter/material.dart';

class CardBoxController extends BaseController {
  final _cbac = CardBoxApiController();
  Future<void> create({
    required String cardType,
    required String title,
    required String info,
    required BuildContext context,
    required Function(CardBox cardBox) action,
    required Function(dynamic errors) action400,
  }) async {
    try {
      var response = await _cbac.create(
        cardType,
        title,
        info,
      );

      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        action(CardBox.fromJson(result['data']));
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
    required int cardBoxId,
    required String title,
    required String info,
    required BuildContext context,
    required Function(CardBox cardBox) action,
    required Function(dynamic errors) action400,
  }) async {
    try {
      var response = await _cbac.update(
        cardBoxId,
        title,
        info,
      );

      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        action(CardBox.fromJson(result['data']));
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
      var response = await _cbac.show(id);
      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return successOutput(
          {
            'card_box': CardBox.fromJson(result['data']['card_box']),
            'cards': List.generate(
              result['data']['cards'].length,
              (index) => c.Card.fromJson(
                result['data']['cards'][index],
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
}

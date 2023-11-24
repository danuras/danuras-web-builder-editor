import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:danuras_web_service_editor/src/menu/pages/web_skeleton/edit_section_widget/edit_section_card.dart';
import 'package:danuras_web_service_editor/src/model/card_model.dart' as c;
import 'package:danuras_web_service_editor/src/view_controller/api/card_api_controller.dart';
import 'package:danuras_web_service_editor/src/view_controller/controller.dart';
import 'package:flutter/material.dart';

class CardController extends BaseController {
  final _cac = CardApiController();
  Future<void> create({
    required c.CardModel card,
    required File? imageUrl,
    required BuildContext context,
    required Function(c.CardModel card) action,
    required Function(dynamic errors) action400,
  }) async {
    try {
      var response = await _cac.create(
        card,
        imageUrl,
      );

      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        action(c.CardModel.fromJson(result['data']));
        if(context.mounted){
          Navigator.of(context).popUntil(ModalRoute.withName(EditSectionCard.routeName));
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
    required c.CardModel card,
    required File? imageUrl,
    required BuildContext context,
    required Function(c.CardModel card) action,
    required Function(dynamic errors) action400,
  }) async {
    try {
      var response = await _cac.update(
        card,
        imageUrl,
      );

      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        action(c.CardModel.fromJson(result['data']));
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

  Future<void> delete(
    int id,
    BuildContext context,
    Function() action,
  ) async {
    try {
      var response = await _cac.delete(id);

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

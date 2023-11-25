import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:danuras_web_service_editor/src/menu/pages/web_skeleton/web_skeleton.dart';
import 'package:danuras_web_service_editor/src/model/endpoint.dart';
import 'package:danuras_web_service_editor/src/model/web_content.dart';
import 'package:danuras_web_service_editor/src/view_controller/api/web_content_api_controller.dart';
import 'package:danuras_web_service_editor/src/view_controller/controller.dart';
import 'package:flutter/material.dart';

class WebContentController extends BaseController {
  final _wcac = WebContentApiController();
  Future<void> createCard({
    required int rank,
    required String cardType,
    required String title,
    required String info,
    required BuildContext context,
    required Function(WebContent webContent) action,
    required Function(dynamic errors) action400,
  }) async {
    try {
      var response = await _wcac.createCard(
        rank,
        cardType,
        title,
        info,
      );


      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        action(WebContent.fromJson(result['data']));
        if(context.mounted){
          Navigator.of(context).popUntil(ModalRoute.withName(WebSkeleton.routeName));
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

  Future<void> createAdvantage({
    required int rank,
    required String description,
    required String title,
    required File? imageUrl,
    required BuildContext context,
    required Function(WebContent webContent) action,
    required Function(dynamic errors) action400,
  }) async {
    try {
      var response = await _wcac.createAdvantage(
        rank,
        description,
        title,
        imageUrl,
      );

      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        action(WebContent.fromJson(result['data']));
        if(context.mounted){
          Navigator.of(context).popUntil(ModalRoute.withName(WebSkeleton.routeName));
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

  Future<void> createMaps({
    required int rank,
    required String infoLocation,
    required String embededMapUrl,
    required BuildContext context,
    required Function(WebContent webContent) action,
    required Function(dynamic errors) action400,
  }) async {
    try {
      var response = await _wcac.createMaps(
        rank,
        infoLocation,
        embededMapUrl,
      );

      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        action(WebContent.fromJson(result['data']));
        if(context.mounted){
          Navigator.of(context).popUntil(ModalRoute.withName(WebSkeleton.routeName));
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

  Future<void> createTestimony({
    required int rank,
    required String value,
    required String name,
    required String job,
    required File? photoProfile,
    required File? backgroundTestimonies,
    required BuildContext context,
    required Function(WebContent webContent) action,
    required Function(dynamic errors) action400,
  }) async {
    try {
      var response = await _wcac.createTestimony(
        rank,
        value,
        name,
        job,
        photoProfile,
        backgroundTestimonies,
      );


      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        action(WebContent.fromJson(result['data']));
        if(context.mounted){
          Navigator.of(context).popUntil(ModalRoute.withName(WebSkeleton.routeName));
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

  Future<void> createBlog({
    required int rank,
    required String datePublished,
    required String title,
    required String author,
    required String text,
    required String link,
    required File? imageUrl,
    required BuildContext context,
    required Function(WebContent webContent) action,
    required Function(dynamic errors) action400,
  }) async {
    try {
      var response = await _wcac.createBlog(
        rank,
        datePublished,
        title,
        author,
        text,
        link,
        imageUrl,
      );

      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        action(WebContent.fromJson(result['data']));
        if(context.mounted){
          Navigator.of(context).popUntil(ModalRoute.withName(WebSkeleton.routeName));
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
    required int rank,
    required int webContentId,
    required BuildContext context,
    required Function(WebContent webContent) action,
    required Function(dynamic errors) action400,
  }) async {
    try {
      var response = await _wcac.update(
        rank,
        webContentId,
      );

      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        action(WebContent.fromJson(result['data']));
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

  Future<void> deleteCard({
    required int id,
    required BuildContext context,
    required Function() action,
  }) async {
    try {
      var response = await _wcac.deleteCard(
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

  Future<void> deleteAdvantage({
    required int id,
    required BuildContext context,
    required Function() action,
  }) async {
    try {
      var response = await _wcac.deleteAdvantage(
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

  Future<void> deleteMaps({
    required int id,
    required BuildContext context,
    required Function() action,
  }) async {
    try {
      var response = await _wcac.deleteMaps(
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

  Future<void> deleteTestimony({
    required int id,
    required BuildContext context,
    required Function() action,
  }) async {
    try {
      var response = await _wcac.deleteTestimony(
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

  Future<void> deleteBlog({
    required int id,
    required BuildContext context,
    required Function() action,
  }) async {
    try {
      var response = await _wcac.deleteBlog(
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
        log(EndPoint.value!);

    try {
      var response = await _wcac.show();
      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return successOutput(
          List.generate(
            result['data'].length,
            (index) => WebContent.fromJson(result['data'][index]),
          ),
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

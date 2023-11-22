import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:danuras_web_service_editor/src/model/blog.dart';
import 'package:danuras_web_service_editor/src/view_controller/api/blog_api_controller.dart';
import 'package:danuras_web_service_editor/src/view_controller/controller.dart';
import 'package:flutter/material.dart';

class BlogController extends BaseController {
  final _bac = BlogApiController();
  Future<void> create({
    required String title,
    required String datePublished,
    required String author,
    required String text,
    required String link,
    required File? imageUrl,
    required BuildContext context,
    required Function(Blog blog) action,
    required Function(dynamic errors) action400,
  }) async {
    try {
      var response = await _bac.create(
        title,
        datePublished,
        author,
        text,
        link,
        imageUrl,
      );

      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        action(Blog.fromJson(result['data']));
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
    required int blogId,
    required String title,
    required String datePublished,
    required String author,
    required String text,
    required String link,
    required File? imageUrl,
    required BuildContext context,
    required Function(Blog blog) action,
    required Function(dynamic errors) action400,
  }) async {
    try {
      var response = await _bac.update(
        blogId,
        title,
        datePublished,
        author,
        text,
        link,
        imageUrl,
      );

      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        action(Blog.fromJson(result['data']));
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
      var response = await _bac.delete(
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
      var response = await _bac.show();
      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return successOutput(
          List.generate(
            result['data'].length,
            (index) => Blog.fromJson(result['data'][index]),
          ),
        );
      } else if (response.statusCode == 401) {
        return needAuthentication();
      } else {
        return failOutput();
      }
    } catch (e) {
      log(e.toString());
      return checkError(e);
    }
  }
}

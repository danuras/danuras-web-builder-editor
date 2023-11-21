import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:danuras_web_service_editor/src/menu/list_menu.dart';
import 'package:danuras_web_service_editor/src/menu/pages/auth/login.dart';
import 'package:danuras_web_service_editor/src/model/auth.dart';
import 'package:danuras_web_service_editor/src/model/user.dart';
import 'package:danuras_web_service_editor/src/view_controller/api/user_api_controller.dart';
import 'package:danuras_web_service_editor/src/view_controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class UserController extends BaseController {
  final _uac = UserApiController();
  Future<void> registerUser({
    required String email,
    required String password,
    required String passwordConfirmation,
    required BuildContext context,
    required Function(User result) action,
    required Function(dynamic errors) action400,
  }) async {
    try {
      var response = await _uac.registerUser(
        email,
        password,
        passwordConfirmation,
      );

      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        action(User.fromJson(result['data']));
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
    required int idx,
    required String email,
    required BuildContext context,
    required Function(int idx) action,
  }) async {
    try {
      var response = await _uac.delete(
        email,
      );

      if (response.statusCode == 200) {
        action(idx);
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

  Future<void> changePrimary({
    required int idx,
    required String email,
    required BuildContext context,
  }) async {
    try {
      var response = await _uac.changePrimary(
        email,
      );

      if (response.statusCode == 200) {
        var box = await Hive.openBox('auth');
        box.put('access_token', null);
        box.put('is_primary', null);
        Auth.accessToken = null;
        Auth.isPrimary = false;
        if (context.mounted) {
          Navigator.of(context).popUntil(ModalRoute.withName('/'));
          Navigator.of(context).pushReplacementNamed(ListMenu.routeName);          
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
      var response = await _uac.show();
      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return successOutput(List.generate(result['data'].length,
            (index) => User.fromJson(result['data'][index])));
      } else if (response.statusCode == 401) {
        return needAuthentication();
      } else {
        return failOutput();
      }
    } catch (e) {
      return checkError(e);
    }
  }

  /* Future<Map<String, dynamic>?> show({required BuildContext context}) async {
    User? user;
    try {
      var response = await _uac.show(context);
      var result = jsonDecode(response.body);
      if (response.statusCode == 200) {
        //success(context, result['message']);
        user = User.fromJson(result['data']['user']);
        var box = await Hive.openBox('auth');

        Auth.id = int.parse(result['data']['user']['id'].toString());
        box.put(
          'id',
          Auth.id,
        );
        return successOutput({
          'user': user,
          'following': result['data']['following'],
          'follower': result['data']['follower'],
        });
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

  Future<Map<String, dynamic>?> showDetail({
    required BuildContext context,
    required User user,
  }) async {
    try {
      var response = await _uac.showDetail(context, user.id);
      var result = jsonDecode(response.body);
      if (response.statusCode == 200) {
        user.landingImage = result['data']['user']['landing_image'] ?? '';
        user.dateOfBirth = result['data']['user']['date_of_birth'] ?? '';
        user.gender = result['data']['user']['gender'] == 1;
        user.email = result['data']['user']['email'];
        user.phoneNumber = result['data']['user']['phone_number'] ?? '';
        user.bio = result['data']['user']['bio'] ?? '';
        user.info = result['data']['user']['info'] ?? '';
        user.username = result['data']['user']['username'];
        return successOutput({
          'user': user,
          'following': result['data']['following'],
          'follower': result['data']['follower'],
        });
      } else if (response.statusCode == 401) {
        return needAuthentication();
      } else {
        return failOutput();
      }
    } catch (e) {
      return checkError(e);
    }
  } */
}

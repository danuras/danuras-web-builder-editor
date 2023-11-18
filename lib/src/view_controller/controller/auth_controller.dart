import 'dart:async';
import 'dart:convert';

import 'package:danuras_web_service_editor/src/model/auth.dart';
import 'package:danuras_web_service_editor/src/view_controller/api/auth_api_controller.dart';
import 'package:danuras_web_service_editor/src/view_controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class UserController extends BaseController {
  final _aac = AuthApiController();
  Future<void> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      var response = await _aac.login(
        email,
        password,
      );

      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        var box = await Hive.openBox('auth');
        box.put('access_token', result['data']['api_token']);
        box.put('is_primary', result['data']['user']['is_primary']);
        Auth.accessToken = result['data']['api_token'];
        Auth.isPrimary = result['data']['user']['is_primary'];
        if (context.mounted) {
          Navigator.of(context).pushReplacementNamed('/');
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

  Future<void> logout({
    required BuildContext context,
  }) async {
    try {
      var response = await _aac.logout();

      if (response.statusCode == 200 || response.statusCode == 401) {
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

  Future<void> logoutAllDevice({
    required BuildContext context,
  }) async {
    try {
      var response = await _aac.logoutAllDevice();
      if (response.statusCode == 200 || response.statusCode == 401) {
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

  Future<void> requestForgetPassword({
    required String email,
    required BuildContext context,
    required Function() action,
    required Function(dynamic errors) action400,
  }) async {
    try {
      var response = await _aac.requestForgetPassword(
        email,
      );
      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        action();
      } else if (response.statusCode == 400) {
        action400(result);
      } else if (response.statusCode == 402) {
        if (context.mounted) {
          failed(context, result['message']);
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

  Future<void> sendTokenVerification({
    required String email,
    required BuildContext context,
    required Function() action,
  }) async {
    try {
      var response = await _aac.sendTokenVerification(
        email,
      );
      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        action();
      } else if (response.statusCode == 402) {
        if (context.mounted) {
          failed(context, result['message']);
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

  Future<void> verifyUpdatePassword({
    required String email,
    required String token,
    required String password,
    required String passwordConfirmation,
    required BuildContext context,
    required Function() action,
    required Function(dynamic errors) action400,
  }) async {
    try {
      var response = await _aac.verifyUpdatePassword(
        email,
        token,
        password,
        passwordConfirmation,
      );
      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        action();
      } else if (response.statusCode == 400) {
        action400(result);
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

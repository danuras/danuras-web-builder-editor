import 'dart:convert';
import 'dart:io';

import 'package:danuras_web_service_editor/src/model/email_service.dart';
import 'package:danuras_web_service_editor/src/view_controller/controller.dart';
import 'package:danuras_web_service_editor/src/model/auth.dart';
import 'package:danuras_web_service_editor/src/model/endpoint.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class AdvantageApiController extends BaseController {
  Future<http.Response> createOrUpdate(
    String title,
    String description,
    File? imageUrl,
  ) async {
    var uri = Uri.parse('${EndPoint.value}advantage/create-or-update');
    var request = http.MultipartRequest('POST', uri);
    request.headers['Authorization'] = 'Bearer ${Auth.accessToken}';
    request.fields['title'] = title;
    request.fields['description'] = description;
    if (imageUrl != null) {
      var streamLi = http.ByteStream.fromBytes(
        await imageUrl.readAsBytes(),
      );
      // get file length
      var lengthLi = await imageUrl.length();
      var multipartFile = http.MultipartFile(
        'image_url',
        streamLi,
        lengthLi,
        filename: basename(imageUrl.path),
      );

      // add file to multipart
      request.files.add(multipartFile);
    }

    var hasil = await request.send();

    http.Response response = await http.Response.fromStream(hasil);

    return response;
  }

  Future<http.Response> show() async {
    var uri = Uri.parse('${EndPoint.value}advantage/show');
    final response = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset-UTF-8',
        'Authorization': 'Bearer ${Auth.accessToken}',
      },
    );
    return response;
  }
}

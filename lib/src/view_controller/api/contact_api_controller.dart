import 'dart:convert';
import 'dart:io';

import 'package:danuras_web_service_editor/src/model/email_service.dart';
import 'package:danuras_web_service_editor/src/view_controller/controller.dart';
import 'package:danuras_web_service_editor/src/model/auth.dart';
import 'package:danuras_web_service_editor/src/model/endpoint.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class ContactApiController extends BaseController {
  Future<http.Response> createOrUpdate(
    String whatsapp,
    String whatsappMessage,
    String callNumber,
    String address,
    String email,
    String infoContact,
    String embededMapUrl,
    String infoLocation,
    File? backgroundContact,
  ) async {
    var uri = Uri.parse('${EndPoint.value}contact/create-or-delete');
    var request = http.MultipartRequest('POST', uri);
    request.headers['Authorization'] = 'Bearer ${Auth.accessToken}';
    request.fields['whatsapp'] = whatsapp;
    request.fields['whatsapp_message'] = whatsappMessage;
    request.fields['call_number'] = callNumber;
    request.fields['address'] = address;
    request.fields['email'] = email;
    request.fields['info_contact'] = infoContact;
    request.fields['embeded_map_url'] = embededMapUrl;
    request.fields['info_location'] = infoLocation;
    if (backgroundContact != null) {
      var streamLi = http.ByteStream.fromBytes(
        await backgroundContact.readAsBytes(),
      );
      // get file length
      var lengthLi = await backgroundContact.length();
      var multipartFile = http.MultipartFile(
        'background_contact',
        streamLi,
        lengthLi,
        filename: basename(backgroundContact.path),
      );

      // add file to multipart
      request.files.add(multipartFile);
    }

    var hasil = await request.send();

    http.Response response = await http.Response.fromStream(hasil);

    return response;
  }

  Future<http.Response> show() async {
    var uri = Uri.parse('${EndPoint.value}contact/show');
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

import 'dart:io';

import 'package:danuras_web_service_editor/src/view_controller/controller.dart';
import 'package:danuras_web_service_editor/src/model/auth.dart';
import 'package:danuras_web_service_editor/src/model/endpoint.dart';
import 'package:http/http.dart' as http;
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class WebAttributeApiController extends BaseController {
  Future<http.Response> createOrUpdate(
    String title,
    String shortDescription,
    String longTitle,
    String mainHeading,
    String subHeading,
    File? icon,
    File? backgroundImage,
  ) async {
    var uri = Uri.parse('${EndPoint.value}web-attribute/create-or-update');
    var request = http.MultipartRequest('POST', uri);
    request.headers['Authorization'] = 'Bearer ${Auth.accessToken}';
    request.fields['title'] = title;
    request.fields['short_description'] = shortDescription;
    request.fields['long_title'] = longTitle;
    request.fields['main_heading'] = mainHeading;
    request.fields['sub_heading'] = subHeading;
    if (icon != null) {
      var streamLi = http.ByteStream.fromBytes(
        await icon.readAsBytes(),
      );
      // get file length
      var lengthLi = await icon.length();
      var multipartFile = http.MultipartFile(
        'icon',
        streamLi,
        lengthLi,
        filename: basename(icon.path),
      );

      // add file to multipart
      request.files.add(multipartFile);
    }
    if (backgroundImage != null) {
      var streamLi2 = http.ByteStream.fromBytes(
        await backgroundImage.readAsBytes(),
      );
      // get file length
      var lengthLi2 = await backgroundImage.length();
      var multipartFile2 = http.MultipartFile(
        'background_image',
        streamLi2,
        lengthLi2,
        filename: basename(backgroundImage.path),
      );

      // add file to multipart
      request.files.add(multipartFile2);
    }

    var hasil = await request.send();

    http.Response response = await http.Response.fromStream(hasil);

    return response;
  }

  Future<http.Response> show() async {
    var uri = Uri.parse('${EndPoint.value}web-attribute/show');
    final response = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${Auth.accessToken}',
      },
    );
    return response;
  }
}

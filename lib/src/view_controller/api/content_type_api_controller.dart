import 'dart:io';

import 'package:danuras_web_service_editor/src/view_controller/controller.dart';
import 'package:danuras_web_service_editor/src/model/auth.dart';
import 'package:danuras_web_service_editor/src/model/content_type.dart';
import 'package:danuras_web_service_editor/src/model/endpoint.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class ContentTypeApiController extends BaseController {
  Future<http.Response> create(
    ContentType contentType,
    File? imageUrl
  ) async {
    var uri = Uri.parse('${EndPoint.value}content-type/create');
    var request = http.MultipartRequest('POST', uri);
    request.headers['Authorization'] = 'Bearer ${Auth.accessToken}';
    request.fields['card_type_id'] = contentType.cardTypeId.toString();
    request.fields['text'] = contentType.text;
    request.fields['title'] = contentType.title;
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

  Future<http.Response> update(
    ContentType contentType,
    File? imageUrl
  ) async {
    var uri = Uri.parse('${EndPoint.value}content-type/update');
    var request = http.MultipartRequest('POST', uri);
    request.headers['Authorization'] = 'Bearer ${Auth.accessToken}';
    request.fields['content_id'] = contentType.id.toString();
    request.fields['text'] = contentType.text;
    request.fields['title'] = contentType.title;
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

  Future<http.Response> delete(int id) async {
    var uri = Uri.parse('${EndPoint.value}content-type/delete/$id');
    final response = await http.delete(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset-UTF-8',
        'Authorization': 'Bearer ${Auth.accessToken}',
      },
    );
    return response;
  }

}

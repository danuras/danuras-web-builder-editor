import 'dart:io';

import 'package:danuras_web_service_editor/src/model/card_type.dart';
import 'package:danuras_web_service_editor/src/view_controller/controller.dart';
import 'package:danuras_web_service_editor/src/model/auth.dart';
import 'package:danuras_web_service_editor/src/model/endpoint.dart';
import 'package:http/http.dart' as http;
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class CardTypeApiController extends BaseController {
  Future<http.Response> create(
    CardType cardType,
    String contentType,
    File? imageUrl
  ) async {
    var uri = Uri.parse('${EndPoint.value}card-type/create');
    var request = http.MultipartRequest('POST', uri);
    request.headers['Authorization'] = 'Bearer ${Auth.accessToken}';
    request.fields['content_type'] = contentType;
    request.fields['whatsapp_message'] = cardType.whatsappMessage??'';
    request.fields['card_id'] = cardType.cardId.toString();
    request.fields['text'] = cardType.text??'';
    request.fields['title'] = cardType.title??'';
    request.fields['description'] = cardType.description??'';
    request.fields['sub_content_title'] = cardType.subContentTitle??'';
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
    CardType cardType,
    File? imageUrl
  ) async {
    var uri = Uri.parse('${EndPoint.value}card-type/update');
    var request = http.MultipartRequest('POST', uri);
    request.headers['Authorization'] = 'Bearer ${Auth.accessToken}';
    request.fields['card_type_id'] = cardType.id.toString();
    request.fields['whatsapp_message'] = cardType.whatsappMessage??'';
    request.fields['card_id'] = cardType.cardId.toString();
    request.fields['text'] = cardType.text??'';
    request.fields['title'] = cardType.title??'';
    request.fields['description'] = cardType.description??'';
    request.fields['sub_content_title'] = cardType.subContentTitle??'';
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
    var uri = Uri.parse('${EndPoint.value}card-type/delete/$id');
    final response = await http.delete(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${Auth.accessToken}',
      },
    );
    return response;
  }

  Future<http.Response> show(int id) async {
    var uri = Uri.parse('${EndPoint.value}card-type/show/$id');
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

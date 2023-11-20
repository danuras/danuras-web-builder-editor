import 'dart:io';

import 'package:danuras_web_service_editor/src/view_controller/controller.dart';
import 'package:danuras_web_service_editor/src/model/auth.dart';
import 'package:danuras_web_service_editor/src/model/endpoint.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class OrderFlowApiController extends BaseController {
  Future<http.Response> create(
    String value,
    File? icon,
  ) async {
    var uri = Uri.parse('${EndPoint.value}order-flow/create');
    var request = http.MultipartRequest('POST', uri);
    request.headers['Authorization'] = 'Bearer ${Auth.accessToken}';
    request.fields['value'] = value;
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

    var hasil = await request.send();

    http.Response response = await http.Response.fromStream(hasil);

    return response;
  }

  Future<http.Response> update(
    int orderFlowId,
    String value,
    File? icon,
  ) async {
    var uri = Uri.parse('${EndPoint.value}order-flow/update');
    var request = http.MultipartRequest('POST', uri);
    request.headers['Authorization'] = 'Bearer ${Auth.accessToken}';
    request.fields['order_flow_id'] = orderFlowId.toString();
    request.fields['value'] = value;
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

    var hasil = await request.send();

    http.Response response = await http.Response.fromStream(hasil);

    return response;
  }

  Future<http.Response> delete(int id) async {
    var uri = Uri.parse('${EndPoint.value}order-flow/delete/$id');
    final response = await http.delete(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset-UTF-8',
        'Authorization': 'Bearer ${Auth.accessToken}',
      },
    );
    return response;
  }

  Future<http.Response> show() async {
    var uri = Uri.parse('${EndPoint.value}order-flow/show');
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

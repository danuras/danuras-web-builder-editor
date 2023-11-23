import 'dart:io';

import 'package:danuras_web_service_editor/src/view_controller/controller.dart';
import 'package:danuras_web_service_editor/src/model/auth.dart';
import 'package:danuras_web_service_editor/src/model/endpoint.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class TestimonyApiController extends BaseController {
  Future<http.Response> create(
    String value,
    String name,
    String job,
    File? photoProfile,
  ) async {
    var uri = Uri.parse('${EndPoint.value}testimony/create');
    var request = http.MultipartRequest('POST', uri);
    request.headers['Authorization'] = 'Bearer ${Auth.accessToken}';
    request.fields['value'] = value;
    request.fields['name'] = name;
    request.fields['job'] = job;
    if (photoProfile != null) {
      var streamLi = http.ByteStream.fromBytes(
        await photoProfile.readAsBytes(),
      );
      // get file length
      var lengthLi = await photoProfile.length();
      var multipartFile = http.MultipartFile(
        'photo_profile',
        streamLi,
        lengthLi,
        filename: basename(photoProfile.path),
      );

      // add file to multipart
      request.files.add(multipartFile);
    }

    var hasil = await request.send();

    http.Response response = await http.Response.fromStream(hasil);

    return response;
  }

  Future<http.Response> update(
    int testimoyId,
    String value,
    String name,
    String job,
    File? photoProfile,
  ) async {
    var uri = Uri.parse('${EndPoint.value}testimony/update');
    var request = http.MultipartRequest('POST', uri);
    request.headers['Authorization'] = 'Bearer ${Auth.accessToken}';
    request.fields['testimony_id'] = testimoyId.toString();
    request.fields['value'] = value;
    request.fields['name'] = name;
    request.fields['job'] = job;
    if (photoProfile != null) {
      var streamLi = http.ByteStream.fromBytes(
        await photoProfile.readAsBytes(),
      );
      // get file length
      var lengthLi = await photoProfile.length();
      var multipartFile = http.MultipartFile(
        'photo_profile',
        streamLi,
        lengthLi,
        filename: basename(photoProfile.path),
      );

      // add file to multipart
      request.files.add(multipartFile);
    }

    var hasil = await request.send();

    http.Response response = await http.Response.fromStream(hasil);

    return response;
  }

  Future<http.Response> updateBackground(
    File? backgrouund,
  ) async {
    var uri = Uri.parse('${EndPoint.value}testimony/update-background');
    var request = http.MultipartRequest('POST', uri);
    request.headers['Authorization'] = 'Bearer ${Auth.accessToken}';
    if (backgrouund != null) {
      var streamLi = http.ByteStream.fromBytes(
        await backgrouund.readAsBytes(),
      );
      // get file length
      var lengthLi = await backgrouund.length();
      var multipartFile = http.MultipartFile(
        'background_testimonies',
        streamLi,
        lengthLi,
        filename: basename(backgrouund.path),
      );

      // add file to multipart
      request.files.add(multipartFile);
    }

    var hasil = await request.send();

    http.Response response = await http.Response.fromStream(hasil);

    return response;
  }

  Future<http.Response> delete(int id) async {
    var uri = Uri.parse('${EndPoint.value}testimony/delete/$id');
    final response = await http.delete(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${Auth.accessToken}',
      },
    );
    return response;
  }

  Future<http.Response> show() async {
    var uri = Uri.parse('${EndPoint.value}testimony/show');
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

import 'dart:convert';
import 'dart:io';

import 'package:danuras_web_service_editor/src/view_controller/controller.dart';
import 'package:danuras_web_service_editor/src/model/auth.dart';
import 'package:danuras_web_service_editor/src/model/endpoint.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class WebContentApiController extends BaseController {
  Future<http.Response> createCard(
    String contentType,
    int rank,
    String cardType,
    String title,
    String info,
  ) async {
    var uri = Uri.parse('${EndPoint.value}web-content/create-card');
    final response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset-UTF-8',
        'Authorization': 'Bearer ${Auth.accessToken}',
      },
      body: jsonEncode(<String, dynamic>{
        'content_type': contentType,
        'rank': rank,
        'card_type': cardType,
        'title': title,
        'info': info,
      }),
    );
    return response;
  }

  Future<http.Response> createAdvantage(
    String contentType,
    int rank,
    String description,
    String title,
    File imageUrl,
  ) async {
    var uri = Uri.parse('${EndPoint.value}web-content/create-advantage');
    var request = http.MultipartRequest('POST', uri);
    request.headers['Authorization'] = 'Bearer ${Auth.accessToken}';
    request.fields['content_type'] = contentType;
    request.fields['rank'] = rank.toString();
    request.fields['description'] = description;
    request.fields['title'] = title;
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

    var hasil = await request.send();

    http.Response response = await http.Response.fromStream(hasil);

    return response;
  }

  Future<http.Response> createMaps(
    String contentType,
    int rank,
    String infoLocation,
    String embededMapUrl,
  ) async {
    var uri = Uri.parse('${EndPoint.value}web-content/create-maps');
    final response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset-UTF-8',
        'Authorization': 'Bearer ${Auth.accessToken}',
      },
      body: jsonEncode(<String, dynamic>{
        'content_type': contentType,
        'rank': rank,
        'info_location': infoLocation,
        'embeded_map_url': embededMapUrl,
      }),
    );
    return response;
  }

  Future<http.Response> createTestimony(
    String contentType,
    int rank,
    String value,
    String name,
    String job,
    File photoProfile,
    File backgroundTestimonies,
  ) async {
    var uri = Uri.parse('${EndPoint.value}web-content/create-testimony');
    var request = http.MultipartRequest('POST', uri);
    request.headers['Authorization'] = 'Bearer ${Auth.accessToken}';
    request.fields['content_type'] = contentType;
    request.fields['rank'] = rank.toString();
    request.fields['value'] = value;
    request.fields['name'] = name;
    request.fields['job'] = job;
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

    var streamLi2 = http.ByteStream.fromBytes(
      await backgroundTestimonies.readAsBytes(),
    );
    // get file length
    var lengthLi2 = await backgroundTestimonies.length();
    var multipartFile2 = http.MultipartFile(
      'background_testimonies',
      streamLi2,
      lengthLi2,
      filename: basename(backgroundTestimonies.path),
    );

    // add file to multipart
    request.files.add(multipartFile2);

    var hasil = await request.send();

    http.Response response = await http.Response.fromStream(hasil);

    return response;
  }

  Future<http.Response> createBlog(
    String contentType,
    int rank,
    String datePublished,
    String title,
    String author,
    String text,
    String link,
    File imageUrl,
  ) async {
    var uri = Uri.parse('${EndPoint.value}web-content/create-blog');
    var request = http.MultipartRequest('POST', uri);
    request.headers['Authorization'] = 'Bearer ${Auth.accessToken}';
    request.fields['content_type'] = contentType;
    request.fields['rank'] = rank.toString();
    request.fields['date_published'] = datePublished;
    request.fields['title'] = title;
    request.fields['author'] = author;
    request.fields['text'] = text;
    request.fields['link'] = link;
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

    var hasil = await request.send();

    http.Response response = await http.Response.fromStream(hasil);

    return response;
  }

  Future<http.Response> update(
    int rank,
    int webContentId,
  ) async {
    var uri = Uri.parse('${EndPoint.value}web-content/update');
    final response = await http.post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset-UTF-8',
          'Authorization': 'Bearer ${Auth.accessToken}',
        },
        body: jsonEncode(<String, dynamic>{
          'web_content_id': webContentId,
          'rank': rank,
        }));
    return response;
  }

  Future<http.Response> deleteCard(int id) async {
    var uri = Uri.parse('${EndPoint.value}web-content/delete-card/$id');
    final response = await http.delete(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset-UTF-8',
        'Authorization': 'Bearer ${Auth.accessToken}',
      },
    );
    return response;
  }

  

  Future<http.Response> deleteAdvantage(int id) async {
    var uri = Uri.parse('${EndPoint.value}web-content/delete-advantage/$id');
    final response = await http.delete(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset-UTF-8',
        'Authorization': 'Bearer ${Auth.accessToken}',
      },
    );
    return response;
  }
  

  Future<http.Response> deleteMaps(int id) async {
    var uri = Uri.parse('${EndPoint.value}web-content/delete-maps/$id');
    final response = await http.delete(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset-UTF-8',
        'Authorization': 'Bearer ${Auth.accessToken}',
      },
    );
    return response;
  }
  

  Future<http.Response> deleteTestimony(int id) async {
    var uri = Uri.parse('${EndPoint.value}web-content/delete-testimony/$id');
    final response = await http.delete(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset-UTF-8',
        'Authorization': 'Bearer ${Auth.accessToken}',
      },
    );
    return response;
  }
  

  Future<http.Response> deleteBlog(int id) async {
    var uri = Uri.parse('${EndPoint.value}web-content/delete-blog/$id');
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
    var uri = Uri.parse('${EndPoint.value}web-content/show');
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

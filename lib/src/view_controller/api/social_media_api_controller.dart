
import 'package:danuras_web_service_editor/src/model/social_media.dart';
import 'package:danuras_web_service_editor/src/view_controller/controller.dart';
import 'package:danuras_web_service_editor/src/model/auth.dart';
import 'package:danuras_web_service_editor/src/model/endpoint.dart';
import 'package:http/http.dart' as http;

class SocialMediaApiController extends BaseController {
  Future<http.Response> createOrUpdate(
    SocialMedia socialMedia,
  ) async {
    var uri = Uri.parse('${EndPoint.value}social-media/create-or-update');
    final response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset-UTF-8',
        'Authorization': 'Bearer ${Auth.accessToken}',
      },
      body: <String, dynamic> {
        'facebook': socialMedia.facebook,
        'twitter': socialMedia.twitter,
        'linkedin': socialMedia.linkedin,
        'instagram': socialMedia.instagram,
        'google_plus': socialMedia.googlePlus,
        'youtube': socialMedia.youtube,
      }
    );
    return response;
  }

  Future<http.Response> show() async {
    var uri = Uri.parse('${EndPoint.value}social-media/show');
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

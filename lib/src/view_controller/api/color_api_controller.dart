
import 'package:danuras_web_service_editor/src/model/color_model.dart';
import 'package:danuras_web_service_editor/src/model/social_media.dart';
import 'package:danuras_web_service_editor/src/view_controller/controller.dart';
import 'package:danuras_web_service_editor/src/model/auth.dart';
import 'package:danuras_web_service_editor/src/model/endpoint.dart';
import 'package:http/http.dart' as http;

class ColorApiController extends BaseController {
  Future<http.Response> createOrUpdate(
    ColorModel colorModel,
  ) async {
    var uri = Uri.parse('${EndPoint.value}color/create-or-update');
    final response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset-UTF-8',
        'Authorization': 'Bearer ${Auth.accessToken}',
      },
      body: <String, dynamic> {
        'header_text_color': colorModel.headerTextColor,
        'common_text_color': colorModel.commonTextColor,
        'background_color_1': colorModel.backgroundColor1,
        'background_color_2': colorModel.backgroundColor2,
        'card_color': colorModel.cardColor,
        'highlight_color': colorModel.highlightColor,
      }
    );
    return response;
  }

  Future<http.Response> show() async {
    var uri = Uri.parse('${EndPoint.value}color/show');
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

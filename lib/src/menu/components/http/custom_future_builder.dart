import 'package:danuras_web_service_editor/src/menu/components/http/custom_error_widget.dart';
import 'package:danuras_web_service_editor/src/menu/components/http/custom_loading.dart';
import 'package:flutter/material.dart';

class CustomFutureBuilder extends StatelessWidget {
  const CustomFutureBuilder({
    super.key,
    required this.future,
    required this.widgetResult,
    this.name,
  });
  final Future<Map<String, dynamic>?> future;
  final Widget Function(Map<String, dynamic> result) widgetResult;
  final String? name;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data!['status_code'] == 200) {
              return widgetResult(snapshot.data!);
            } else if (snapshot.data!['status_code'] == 404 && name != null) {
              return CustomErrorWidget.notFound(name!);
            } else if (snapshot.data!['status_code'] == 502) {
              return CustomErrorWidget.lostConnection;
            } else if (snapshot.data!['status_code'] == 401) {
              return CustomErrorWidget.needAuthentication(context);
            } else if (snapshot.data!['status_code'] == 403) {
              return CustomErrorWidget.needVerification(context);
            } else {
              return CustomErrorWidget.dynamicError;
            }
          } else {
            return const CustomLoading();
          }
        });
  }
}

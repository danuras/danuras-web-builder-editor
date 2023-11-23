import 'package:danuras_web_service_editor/src/menu/components/http/custom_future_builder.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/card/list_card.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/custom_button.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/input_type_bar.dart';
import 'package:danuras_web_service_editor/src/model/contact_model.dart';
import 'package:danuras_web_service_editor/src/model/web_content.dart';
import 'package:danuras_web_service_editor/src/view_controller/controller/contact_controller.dart';
import 'package:danuras_web_service_editor/src/view_controller/controller/web_content_controller.dart';
import 'package:flutter/material.dart';

class AddSectionLocation extends StatefulWidget {
  const AddSectionLocation({
    super.key,
    required this.rank,
    required this.wcc,
    required this.action,
  });
  static const routeName = '/web-content/add-section-location';
  final WebContentController wcc;
  final int rank;
  final Function(WebContent webContent) action;

  @override
  State<AddSectionLocation> createState() => AddSectionLocationState();
}

class AddSectionLocationState extends State<AddSectionLocation> {
  TextEditingController infoLocationController =
      TextEditingController(text: '');
  TextEditingController embededMapUrlController =
      TextEditingController(text: '');

  ValueNotifier<String?> infoLocationError = ValueNotifier(null);
  ValueNotifier<String?> embededMapUrlError = ValueNotifier(null);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Edit Bagian Lokasi'),
          backgroundColor: const Color(0xff110011),
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/images/background.jpeg',
              ),
              fit: BoxFit.cover,
            ),
            color: Colors.black,
          ),
          child: Container(
            color: const Color(0x88110011),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
                right: 8.0,
              ),
              child: ListView(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  InputTypeBar(
                    labelText: 'Info lokasi',
                    tooltip: 'Masukan keterangan tambahan lokasi usaha anda.',
                    errorText: infoLocationError,
                    controller: infoLocationController,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  InputTypeBar(
                    labelText: 'Link Embeded Map',
                    maxLines: 4,
                    tooltip:
                        'Masukan link embeded map dari google map sesuai dengan lokasi usaha anda.',
                    errorText: embededMapUrlError,
                    controller: embededMapUrlController,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  CustomButton(
                    text: 'Simpan',
                    action: () async {
                      resetError();
                      await widget.wcc.createMaps(
                        infoLocation: infoLocationController.text,
                        embededMapUrl: embededMapUrlController.text,
                        context: context,
                        action: widget.action,
                        action400: (errors) {
                          checkError(errors);
                        },
                        rank: widget.rank,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void resetError() {
    embededMapUrlError.value = null;
    infoLocationError.value = null;
  }

  void checkError(errors) {
    if (errors.containsKey('embeded_map_url')) {
      embededMapUrlError.value = errors['embeded_map_url'][0];
    }
    if (errors.containsKey('info_location')) {
      infoLocationError.value = errors['info_location'][0];
    }
  }
}

import 'package:danuras_web_service_editor/src/menu/components/widget/custom_button.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/input_type_bar.dart';
import 'package:danuras_web_service_editor/src/menu/pages/auth/input_email.dart';
import 'package:danuras_web_service_editor/src/menu/pages/tutorial_deploy.dart';
import 'package:danuras_web_service_editor/src/view_controller/controller/auth_controller.dart';
import 'package:danuras_web_service_editor/src/view_controller/controller/endpoint_controller.dart';
import 'package:flutter/material.dart';

class InputEndpoint extends StatefulWidget {
  const InputEndpoint({super.key});
  static const routeName = '/input-endpoint';

  @override
  State<InputEndpoint> createState() => _InputEndpointState();
}

class _InputEndpointState extends State<InputEndpoint> {
  TextEditingController endpointController = TextEditingController(text: '');
  ValueNotifier<String?> inputError = ValueNotifier(null);

  EndPointController epc = EndPointController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Masukan link web (endpoint)'),
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
                top: 16.0,
              ),
              child: ListView(
                children: [
                  InputTypeBar(
                    labelText: 'Link',
                    tooltip:
                        'Masukan link website yang telah dideploy danuras-web-builder (pastikan tidak ada kesalahan pengetikan).',
                    errorText: inputError,
                    hintText: 'https://www.example.com/',
                    controller: endpointController,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          TutorialDeploy.routeName,
                        ); 
                      },
                      child: const Text(
                        'Belum Deploy Web?',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  CustomButton(
                    text: 'Simpan',
                    action: () async {
                      resetError();
                      await epc.save(endpointController.text, context);
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
    inputError.value = null;
  }
}

import 'package:danuras_web_service_editor/src/menu/components/widget/custom_button.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/input_type_Bar.dart';
import 'package:flutter/material.dart';

class SocialMedia extends StatelessWidget {
  const SocialMedia({super.key});
  static const routeName = '/social-media';

  @override
  Widget build(BuildContext context) {
    TextEditingController senderController = TextEditingController(text: '');
    TextEditingController passwordController = TextEditingController(text: '');
    TextEditingController receiverController = TextEditingController(text: '');
    ValueNotifier<String?> senderError = ValueNotifier(null);
    ValueNotifier<String?> passwordError = ValueNotifier(null);
    ValueNotifier<String?> receiverError = ValueNotifier(null);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Media Sosial'),
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
                    labelText: 'Facebook',
                    tooltip:
                        'Masukan link yang mengarah ke akun facebook perusahaan.',
                    errorText: senderError,
                    controller: senderController,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  InputTypeBar(
                    labelText: 'Twitter',
                    tooltip:
                        'Masukan link yang mengarah ke akun twitter perusahaan.',
                    errorText: senderError,
                    controller: senderController,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  InputTypeBar(
                    labelText: 'LinkedIn',
                    tooltip:
                        'Masukan link yang mengarah ke akun linkedin perusahaan.',
                    errorText: senderError,
                    controller: senderController,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  InputTypeBar(
                    labelText: 'Instagram',
                    tooltip:
                        'Masukan link yang mengarah ke akun Instagram perusahaan.',
                    errorText: senderError,
                    controller: senderController,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  InputTypeBar(
                    labelText: 'Google Plus',
                    tooltip:
                        'Masukan link yang mengarah ke akun Google Plus perusahaan.',
                    errorText: senderError,
                    controller: senderController,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  InputTypeBar(
                    labelText: 'Youtube',
                    tooltip:
                        'Masukan link yang mengarah ke akun Youtube perusahaan.',
                    errorText: senderError,
                    controller: senderController,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  CustomButton(text: 'Simpan', action: () {}),
                  const SizedBox(
                    height: 32.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

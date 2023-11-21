import 'package:danuras_web_service_editor/src/menu/components/widget/custom_button.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/input_type_Bar.dart';
import 'package:danuras_web_service_editor/src/menu/pages/auth/input_token.dart';
import 'package:danuras_web_service_editor/src/view_controller/controller/auth_controller.dart';
import 'package:flutter/material.dart';

class InputEmail extends StatefulWidget {
  const InputEmail({super.key, required this.authController});
  final AuthController authController;
  static const routeName = '/input-email';

  @override
  State<InputEmail> createState() => _InputEmailState();
}

class _InputEmailState extends State<InputEmail> {
  TextEditingController emailController = TextEditingController(text: '');
  ValueNotifier<String?> emailError = ValueNotifier(null);
  ValueNotifier<String?> timeError = ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Masukan email'),
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
                    labelText: 'Email',
                    tooltip:
                        'Masukan alamat email yang inging di ubah passwordnya',
                    errorText: emailError,
                    controller: emailController,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  ValueListenableBuilder(
                    valueListenable: timeError,
                    builder: (context, le, child) {
                      if (le != null) {
                        return Text(
                          le,
                          style: const TextStyle(color: Colors.red),
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                  CustomButton(
                    text: 'Kirim',
                    action: () async {
                      resetError();
                      timeError.value = null;
                      await widget.authController.requestForgetPassword(
                        email: emailController.text,
                        context: context,
                        action400: (errors) {
                          checkError(errors);
                        },
                        action: () {
                          Navigator.of(context).pushNamed(
                            SaveNewPassword.routeName,
                            arguments: <String, dynamic>{
                              'ac': widget.authController,
                              'email': emailController.text,
                            },
                          );
                        },
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
    timeError.value = null;
    emailError.value = null;
  }

  void checkError(errors) {
    if (errors.containsKey('message')) {
      timeError.value = errors['message'][0];
    }
    if (errors.containsKey('email')) {
      emailError.value = errors['email'][0];
    }
  }
}

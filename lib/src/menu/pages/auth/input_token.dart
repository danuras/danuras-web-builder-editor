import 'package:danuras_web_service_editor/src/menu/components/widget/custom_button.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/input_type_Bar.dart';
import 'package:danuras_web_service_editor/src/menu/list_menu.dart';
import 'package:danuras_web_service_editor/src/view_controller/controller/auth_controller.dart';
import 'package:flutter/material.dart';

class SaveNewPassword extends StatefulWidget {
  const SaveNewPassword({
    super.key,
    required this.authController,
    required this.email,
  });
  final AuthController authController;
  final String email;
  static const routeName = '/input-token';

  @override
  State<SaveNewPassword> createState() => _SaveNewPasswordState();
}

class _SaveNewPasswordState extends State<SaveNewPassword> {
  TextEditingController tokenController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');
  TextEditingController passwordConfirmationController =
      TextEditingController(text: '');

  ValueNotifier<String?> tokenError = ValueNotifier(null);
  ValueNotifier<String?> passwordError = ValueNotifier(null);
  ValueNotifier<String?> passwordConfirmationError = ValueNotifier(null);
  ValueNotifier<String?> timeError = ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Masukan token yang telah dikirim'),
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
                    labelText: 'Token',
                    tooltip: 'Masukan token yang dikirimkan ke email!',
                    errorText: tokenError,
                    controller: tokenController,
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
                  Row(
                    children: [
                      const Text(
                        'Tidak Mendapatkan token?',
                        style: TextStyle(color: Colors.white),
                      ),
                      const Spacer(),
                      CustomButton(
                        text: 'Kirim lagi',
                        action: () async {
                          resetError();
                          timeError.value = null;
                          await widget.authController.sendTokenVerification(
                            email: widget.email,
                            context: context,
                            action400: (errors) {
                              checkError(errors);
                            },
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  InputTypeBar(
                    labelText: 'Password Baru',
                    tooltip: 'Masukan password baru!',
                    errorText: passwordError,
                    controller: passwordController,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  InputTypeBar(
                    labelText: 'Konfirmasi Password Baru',
                    tooltip: 'Masukan password konfirmasi!',
                    errorText: passwordConfirmationError,
                    controller: passwordConfirmationController,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  CustomButton(
                    text: 'Simpan',
                    action: () async {
                      resetError();
                      timeError.value = null;
                      await widget.authController.verifyUpdatePassword(
                        email: widget.email,
                        context: context,
                        action400: (errors) {
                          checkError(errors);
                        },
                        action: () {
                          Navigator.of(context)
                              .popUntil(ModalRoute.withName('/'));
                          Navigator.of(context)
                              .pushReplacementNamed(ListMenu.routeName);
                        },
                        password: passwordController.text,
                        passwordConfirmation:
                            passwordConfirmationController.text,
                        token: tokenController.text,
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
    tokenError.value = null;
    passwordError.value = null;
    passwordConfirmationError.value = null;
  }

  void checkError(errors) {
    if (errors.containsKey('message')) {
      timeError.value = errors['message'];
    }
    if (errors.containsKey('code')) {
      tokenError.value = errors['code'][0];
    }
    if (errors.containsKey('password')) {
      passwordError.value = errors['password'][0];
    }
    if (errors.containsKey('password_confirmation')) {
      passwordConfirmationError.value = errors['password_confirmation'][0];
    }
  }
}

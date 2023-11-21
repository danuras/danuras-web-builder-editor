import 'dart:developer';
import 'dart:io';

import 'package:danuras_web_service_editor/src/menu/components/widget/custom_button.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/input_cirle_image.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/input_type_bar.dart';
import 'package:danuras_web_service_editor/src/model/user.dart';
import 'package:danuras_web_service_editor/src/view_controller/controller/user_controller.dart';
import 'package:flutter/material.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key, required this.uc, required this.action});
  static const routeName = '/user/add';
  final UserController uc;
  final Function(User user) action;

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');
  TextEditingController passwordConfirmationController = TextEditingController(text: '');

  ValueNotifier<String?> emailError = ValueNotifier(null);
  ValueNotifier<String?> passwordError = ValueNotifier(null);
  ValueNotifier<String?> passwordConfirmationError = ValueNotifier(null);

  File? image;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Tambah akun'),
          backgroundColor: const Color(0xff110011),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
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
                    tooltip: 'Masukan alamat email yang terdaftar',
                    errorText: emailError,
                    controller: emailController,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  InputTypeBar(
                    labelText: 'Password',
                    tooltip: 'Masukan password',
                    errorText: passwordError,
                    controller: passwordController,
                    obscureText: true,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  InputTypeBar(
                    labelText: 'Konfirmasi Password',
                    tooltip: 'Masukan kembali password',
                    errorText: passwordConfirmationError,
                    controller: passwordConfirmationController,
                    obscureText: true,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  CustomButton(
                    text: 'Buat Akun',
                    action: () async {
                      resetError();
                      await widget.uc.registerUser(
                        email: emailController.text,
                        password: passwordController.text,
                        passwordConfirmation: passwordConfirmationController.text,
                        action: (result){
                          widget.action(result);
                          Navigator.of(context).pop();
                        },
                        action400: (errors){
                          checkError(errors);
                        },
                        context: context,
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
    emailError.value = null;
    passwordError.value = null;
  }

  void checkError(errors) {
    if (errors.containsKey('email')) {
      emailError.value = errors['email'][0];
    }
    if (errors.containsKey('password')) {
      passwordError.value = errors['password'][0];
    }
  }
}

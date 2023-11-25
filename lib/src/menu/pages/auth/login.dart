import 'package:danuras_web_service_editor/src/menu/components/widget/custom_button.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/input_type_bar.dart';
import 'package:danuras_web_service_editor/src/menu/pages/auth/input_email.dart';
import 'package:danuras_web_service_editor/src/menu/pages/auth/input_endpoint.dart';
import 'package:danuras_web_service_editor/src/view_controller/controller/auth_controller.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  static const routeName = '/login';

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');
  ValueNotifier<String?> emailError = ValueNotifier(null);
  ValueNotifier<String?> passwordError = ValueNotifier(null);
  ValueNotifier<String?> loginError = ValueNotifier(null);

  AuthController authController = AuthController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Masuk'),
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
                  ValueListenableBuilder(
                    valueListenable: loginError,
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
                  const SizedBox(
                    height: 8.0,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          InputEmail.routeName,
                          arguments: <String, dynamic>{
                            'ac': authController,
                          },
                        );
                      },
                      child: const Text(
                        'Lupa Password?',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                      onPressed: () {
                      Navigator.of(context).pushNamed(InputEndpoint.routeName);
                        
                      },
                      child: const Text(
                        'Ubah EndPoint?',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  CustomButton(
                    text: 'Login',
                    action: () async {
                      resetError();
                      loginError.value = null;
                      await authController.login(
                          email: emailController.text,
                          password: passwordController.text,
                          context: context,
                          action400: (errors) {
                            checkError(errors);
                          },
                          loginFail: () {
                            loginError.value =
                                "Kombinasi email dan password tidak ditemukan";
                          });
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
    passwordError.value = null;
    emailError.value = null;
  }

  void checkError(errors) {
    if (errors.containsKey('password')) {
      passwordError.value = errors['password'][0];
    }
    if (errors.containsKey('email')) {
      emailError.value = errors['email'][0];
    }
  }
}

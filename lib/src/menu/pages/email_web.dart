
import 'package:danuras_web_service_editor/src/menu/components/widget/custom_button.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/input_type_Bar.dart';
import 'package:flutter/material.dart';

class EmailWeb extends StatelessWidget {
  const EmailWeb({super.key});
  static const routeName = '/email-web';

  @override
  Widget build(BuildContext context) {
    TextEditingController senderController = TextEditingController(text: '');
    TextEditingController passwordController =
        TextEditingController(text: '');
    TextEditingController receiverController =
        TextEditingController(text: '');
    ValueNotifier<String?> senderError = ValueNotifier(null);
    ValueNotifier<String?> passwordError = ValueNotifier(null);
    ValueNotifier<String?> receiverError = ValueNotifier(null);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Email Web'),
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
                    labelText: 'Email Pengirim',
                    tooltip:
                        'Alamat email yang digunakan untuk mengirimkan pesan email dari website',
                    errorText: senderError,
                    controller: senderController,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  InputTypeBar(
                    labelText: 'Password Email Pengirim',
                    tooltip:
                        'Password aplikasi dari alamat email yang digunakan untuk mengirim pesan',
                    errorText: passwordError,
                    controller: passwordController,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  InputTypeBar(
                    labelText: 'Email Penerima',
                    tooltip:
                        'Alamat email yang digunakan untuk menerima pesan yang dikirim dari website https://support.google.com/mail/answer/185833?hl=en',
                    errorText: receiverError,
                    controller: receiverController,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  CustomButton(text: 'Simpan', action: (){}),
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

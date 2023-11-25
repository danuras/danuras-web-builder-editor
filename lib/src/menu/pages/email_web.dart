import 'package:danuras_web_service_editor/src/menu/components/http/custom_future_builder.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/custom_button.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/input_type_Bar.dart';
import 'package:danuras_web_service_editor/src/model/email_service.dart';
import 'package:danuras_web_service_editor/src/view_controller/controller/email_service_controller.dart';
import 'package:flutter/material.dart';

class EmailWeb extends StatefulWidget {
  const EmailWeb({super.key});
  static const routeName = '/email-web';

  @override
  State<EmailWeb> createState() => _EmailWebState();
}

class _EmailWebState extends State<EmailWeb> {
  TextEditingController nameController = TextEditingController(text: '');
  TextEditingController senderController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');
  TextEditingController receiverController = TextEditingController(text: '');

  EmailServiceController esc = EmailServiceController();
  late EmailService emailService;

  ValueNotifier<String?> nameError = ValueNotifier(null);
  ValueNotifier<String?> senderError = ValueNotifier(null);
  ValueNotifier<String?> passwordError = ValueNotifier(null);
  ValueNotifier<String?> receiverError = ValueNotifier(null);

  ValueNotifier<bool> refresher = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
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
            child: RefreshIndicator(
              onRefresh: () async {
                refresher.value = !refresher.value;
              },
              color: const Color(0xffffffff),
              backgroundColor: const Color(0xff110011),
              child: ValueListenableBuilder(
                valueListenable: refresher,
                builder: (context, r, child) {
                  return CustomFutureBuilder(
                    future: esc.show(),
                    widgetResult: (result) {
                      if (result['data'] != null) {
                        emailService = result['data'];
                        nameController.text = emailService.name;
                        senderController.text = emailService.emailSender;
                        passwordController.text = emailService.password;
                        receiverController.text = emailService.emailReceiver;
                      }
                      return Padding(
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
                              labelText: 'Nama Email Pengirim',
                              tooltip: 'Nama yang dipakai oleh email pengirim',
                              errorText: nameError,
                              controller: nameController,
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
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
                                  'Alamat email yang digunakan untuk menerima pesan yang dikirim dari website',
                              errorText: receiverError,
                              controller: receiverController,
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            CustomButton(
                              text: 'Simpan',
                              action: () async {
                                resetError();
                                await esc.createOrUpdate(
                                  emailService: EmailService.fromJson({
                                    'name': nameController.text,
                                    'email_sender': senderController.text,
                                    'password': passwordController.text,
                                    'email_receiver': receiverController.text,
                                  }),
                                  context: context,
                                  action: () {},
                                  action400: (errors) {
                                    checkError(errors);
                                  },
                                );
                              },
                            ),
                            const SizedBox(
                              height: 32.0,
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              ),
            ),
          ),
        ),
      ),
    );
  }

  void resetError() {
    nameError.value = null;
    senderError.value = null;
    passwordError.value = null;
    receiverError.value = null;
  }

  void checkError(errors) {
    if (errors.containsKey('name')) {
      nameError.value = errors['name'][0];
    }
    if (errors.containsKey('email_sender')) {
      senderError.value = errors['email_sender'][0];
    }
    if (errors.containsKey('password')) {
      passwordError.value = errors['password'][0];
    }
    if (errors.containsKey('email_receiver')) {
      receiverError.value = errors['email_receiver'][0];
    }
  }
}

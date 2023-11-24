import 'dart:io';

import 'package:danuras_web_service_editor/src/menu/components/http/custom_future_builder.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/custom_button.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/input_html_editor.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/input_square_image.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/input_type_Bar.dart';
import 'package:danuras_web_service_editor/src/model/contact_model.dart';
import 'package:danuras_web_service_editor/src/view_controller/controller/contact_controller.dart';
import 'package:flutter/material.dart';

class Contact extends StatefulWidget {
  const Contact({super.key});
  static const routeName = '/contact';

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  TextEditingController whatsappController = TextEditingController(text: '');
  TextEditingController whatsappMessageController =
      TextEditingController(text: '');
  TextEditingController callNumberController = TextEditingController(text: '');
  TextEditingController addressController = TextEditingController(text: '');
  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController infoContactController = TextEditingController(text: '');
  TextEditingController backgroundContactController =
      TextEditingController(text: '');

  ValueNotifier<String?> whatsappError = ValueNotifier(null);
  ValueNotifier<String?> whatsappMessageError = ValueNotifier(null);
  ValueNotifier<String?> callNumberError = ValueNotifier(null);
  ValueNotifier<String?> addressError = ValueNotifier(null);
  ValueNotifier<String?> emailError = ValueNotifier(null);
  ValueNotifier<String?> infoContactError = ValueNotifier(null);
  ValueNotifier<String?> backgroundContactError = ValueNotifier(null);

  ValueNotifier<bool> refresher = ValueNotifier(false);

  ContactController cc = ContactController();

  late ContactModel cm;

  File? backgroundImageContact;
  String? infoContact;
  String? backgroundImageUrl;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Kontak'),
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
                    future: cc.show(),
                    widgetResult: (result) {
                      if (result['data'] != null) {
                        cm = result['data'];
                        whatsappController.text = cm.whatsapp;
                        whatsappMessageController.text = cm.whatsappMessage;
                        callNumberController.text = cm.callNumber;
                        addressController.text = cm.address;
                        emailController.text = cm.email;
                        infoContact = cm.infoContact;
                        backgroundImageUrl = cm.backgroundContact;
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
                              labelText: 'Nomor Whatsapp',
                              tooltip:
                                  'Masukan nomor whatsapp yang akan digunakan oleh pengunjung untuk menghubungi anda',
                              errorText: whatsappError,
                              controller: whatsappController,
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            InputTypeBar(
                              labelText: 'Pesan instan',
                              tooltip:
                                  'Masukan pesan instan yang dapat otomatis dimasukan ketika pengunjung ingin menghubungi anda lewat whatsapp',
                              errorText: whatsappMessageError,
                              controller: whatsappMessageController,
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            InputTypeBar(
                              labelText: 'Nomor Telephon',
                              tooltip:
                                  'Masukan nomor telepon yang digunakan untuk menerima panggilan',
                              errorText: callNumberError,
                              controller: callNumberController,
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            InputTypeBar(
                              labelText: 'Alamat',
                              tooltip: 'Masukan alamat dari usaha anda.',
                              errorText: addressError,
                              controller: addressController,
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            InputTypeBar(
                              labelText: 'Email',
                              tooltip:
                                  'Masukan alamat email yang dapat dihubungi agar dapat ditampilkan di website.',
                              errorText: emailError,
                              controller: emailController,
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            InputHtmlEditor(
                              title: 'Info Kontak',
                              tooltip:
                                  'Masukan informasi tambahan untuk kontak misal jadwal kerja untuk membalas kontak atau lainnya',
                              initialString: infoContact,
                              error: infoContactError,
                              changeText: ((changed) => infoContact = changed),
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            InputSquareImage(
                              action: (image) {
                                backgroundImageContact = image;
                              },
                              imageError: backgroundContactError,
                              imageUrl: backgroundImageUrl,
                              label: 'Gambar Background Halaman Kontak',
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            CustomButton(
                                text: 'Simpan',
                                action: () async {
                                  resetError();
                                  await cc.createOrUpdate(
                                    whatsapp: whatsappController.text,
                                    whatsappMessage:
                                        whatsappMessageController.text,
                                    callNumber: callNumberController.text,
                                    address: addressController.text,
                                    email: emailController.text,
                                    backgroundContact: backgroundImageContact,
                                    context: context,
                                    action: () {},
                                    action400: (errors) {
                                      checkError(errors);
                                    },
                                    infoContact: infoContactController.text,
                                  );
                                }),
                            const SizedBox(
                              height: 32.0,
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  void resetError() {
    whatsappError.value = null;
    whatsappMessageError.value = null;
    callNumberError.value = null;
    addressError.value = null;
    emailError.value = null;
    infoContactError.value = null;
    backgroundContactError.value = null;
  }

  void checkError(errors) {
    if (errors.containsKey('whatsapp')) {
      whatsappError.value = errors['whatsapp'][0];
    }
    if (errors.containsKey('whatsapp_message')) {
      whatsappMessageError.value = errors['whatsapp_message'][0];
    }
    if (errors.containsKey('call_number')) {
      callNumberError.value = errors['call_number'][0];
    }
    if (errors.containsKey('address')) {
      addressError.value = errors['address'][0];
    }
    if (errors.containsKey('email')) {
      emailError.value = errors['email'][0];
    }
    if (errors.containsKey('info_contact')) {
      infoContactError.value = errors['info_contact'][0];
    }
    if (errors.containsKey('background_contact')) {
      backgroundContactError.value = errors['background_contact'][0];
    }
  }
}

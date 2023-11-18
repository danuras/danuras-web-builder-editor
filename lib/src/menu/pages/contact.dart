import 'dart:io';

import 'package:danuras_web_service_editor/src/menu/components/widget/custom_button.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/input_html_editor.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/input_square_image.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/input_type_Bar.dart';
import 'package:flutter/material.dart';

class Contact extends StatelessWidget {
  const Contact({super.key});
  static const routeName = '/contact';

  @override
  Widget build(BuildContext context) {
    TextEditingController senderController = TextEditingController(text: '');
    TextEditingController passwordController = TextEditingController(text: '');
    TextEditingController receiverController = TextEditingController(text: '');
    ValueNotifier<String?> senderError = ValueNotifier(null);
    ValueNotifier<String?> passwordError = ValueNotifier(null);
    ValueNotifier<String?> receiverError = ValueNotifier(null);
    String? infoContact;

    File? backgroundImageContact;

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
            child: Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
                right: 8.0,
                top: 16.0,
              ),
              child: ListView(
                children: [
                  InputTypeBar(
                    labelText: 'Nomor Whatsapp',
                    tooltip:
                        'Masukan nomor whatsapp yang akan digunakan oleh pengunjung untuk menghubungi anda',
                    errorText: senderError,
                    controller: senderController,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  InputTypeBar(
                    labelText: 'Pesan instan',
                    tooltip:
                        'Masukan pesan instan yang dapat otomatis dimasukan ketika pengunjung ingin menghubungi anda lewat whatsapp',
                    errorText: passwordError,
                    controller: passwordController,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  InputTypeBar(
                    labelText: 'Nomor Telephon',
                    tooltip:
                        'Masukan nomor telepon yang digunakan untuk menerima panggilan',
                    errorText: receiverError,
                    controller: receiverController,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  InputTypeBar(
                    labelText: 'Alamat',
                    tooltip: 'Masukan alamat dari usaha anda.',
                    errorText: receiverError,
                    controller: receiverController,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  InputTypeBar(
                    labelText: 'Alamat',
                    tooltip:
                        'Masukan alamat email yang dapat dihubungi agar dapat ditampilkan di website.',
                    errorText: receiverError,
                    controller: receiverController,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  InputTypeBar(
                    labelText: 'Info Kontak',
                    tooltip: 'Masukan informasi untuk me.',
                    maxLines: 5,
                    errorText: receiverError,
                    controller: receiverController,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  InputHtmlEditor(
                    title: 'Info Kontak',
                    tooltip: 'Masukan informasi tambahan untuk kontak misal jadwal kerja untuk membalas kontak atau lainnya',
                    changeText: ((changed) => infoContact = changed),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  InputTypeBar(
                    labelText: 'Link Embeded Map',
                    tooltip: 'Masukan link embeded map dari google map sesuai dengan lokasi usaha anda.',
                    maxLines: 3,
                    errorText: receiverError,
                    controller: receiverController,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  InputTypeBar(
                    labelText: 'Info lokasi',
                    tooltip: 'Masukan keterangan tambahan lokasi usaha anda.',
                    maxLines: 3,
                    errorText: receiverError,
                    controller: receiverController,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  InputSquareImage(
                    action: (image) {
                      backgroundImageContact = image;
                    },
                    label: 'Gambar Background Halaman Kontak',
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

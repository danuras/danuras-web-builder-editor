import 'dart:io';

import 'package:danuras_web_service_editor/src/menu/components/widget/custom_button.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/input_square_image.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/input_type_Bar.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/input_type_icon.dart';
import 'package:flutter/material.dart';

class CompanyProfile extends StatelessWidget {
  const CompanyProfile({super.key});
  static const routeName = '/company-profile';

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController(text: '');
    TextEditingController longTitleController = TextEditingController(text: '');
    TextEditingController headingController = TextEditingController(text: '');
    TextEditingController subHeadingController =
        TextEditingController(text: '');
    ValueNotifier<String?> titleError = ValueNotifier(null);
    ValueNotifier<String?> longTitleError = ValueNotifier(null);
    ValueNotifier<String?> headingError = ValueNotifier(null);
    ValueNotifier<String?> subHeadingError = ValueNotifier(null);
    File? icon, backgroundImage, backgroundTestimony;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Profil Perusahaan'),
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
                    labelText: 'Deskripsi singkat',
                    tooltip:
                        'Deskripsikan secara singkat usaha anda.',
                    errorText: headingError,
                    maxLines: 2,
                    controller: headingController,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  InputTypeBar(
                    labelText: 'Deskripsi',
                    tooltip:
                        'Jelaskan usaha anda (bisa dengan menceritakan riwayat perusahaan anda)',
                        maxLines: 4,
                    errorText: subHeadingError,
                    controller: subHeadingController,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  InputSquareImage(
                    action: (image) {
                      backgroundImage = image;
                    },
                    label: 'Gambar Perusahaan',
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  InputTypeBar(
                    labelText: 'Deskripsi',
                    tooltip:
                        'Jelaskan usaha anda (bisa dengan menceritakan riwayat perusahaan anda)',
                    errorText: subHeadingError,
                    controller: subHeadingController,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  InputTypeBar(
                    labelText: 'Pesan instan',
                    tooltip:
                        'Masukan pesan instan yang dapat otomatis dimasukan ketika pengunjung ingin menghubungi anda lewat whatsapp',
                    errorText: subHeadingError,
                    controller: subHeadingController,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  InputTypeBar(
                    labelText: 'Visi Perusahaan',
                    tooltip:
                        'Ceritakan visi perusahaan Anda yang menjadikan perusahaan anda sumber daya yang tak tergantikan dan mendorong inovasi demi mewujudkan masa depan yang lebih baik.',
                    errorText: headingError,
                    maxLines: 2,
                    controller: headingController,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  InputTypeBar(
                    labelText: 'Misi Perusahaan',
                    tooltip:
                        'Ceritakan misi perusahaan Anda yang menggambarkan komitmen perusahaan untuk mencapai tujuan, layanan yang perusahaan tawarkan, dan dampak positif yang ingin perusahaan ciptakan dalam masyarakat.',
                    errorText: headingError,
                    maxLines: 2,
                    controller: headingController,
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

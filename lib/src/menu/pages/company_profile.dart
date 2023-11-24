import 'dart:io';

import 'package:danuras_web_service_editor/src/menu/components/http/custom_future_builder.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/custom_button.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/input_square_image.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/input_type_Bar.dart';
import 'package:danuras_web_service_editor/src/model/company_profile_model.dart';
import 'package:danuras_web_service_editor/src/view_controller/controller/company_profile_controller.dart';
import 'package:flutter/material.dart';

class CompanyProfile extends StatefulWidget {
  const CompanyProfile({super.key});
  static const routeName = '/company-profile';

  @override
  State<CompanyProfile> createState() => _CompanyProfileState();
}

class _CompanyProfileState extends State<CompanyProfile> {
  TextEditingController descriptionController = TextEditingController(text: '');
  TextEditingController whatsappMessageController =
      TextEditingController(text: '');
  TextEditingController missionController = TextEditingController(text: '');
  TextEditingController visionController = TextEditingController(text: '');
  String? imageUrl;
  File? image;

  CompanyProfileController cpc = CompanyProfileController();

  ValueNotifier<String?> descriptionError = ValueNotifier(null);
  ValueNotifier<String?> whatsappMessageError = ValueNotifier(null);
  ValueNotifier<String?> imageUrlError = ValueNotifier(null);
  ValueNotifier<String?> missionError = ValueNotifier(null);
  ValueNotifier<String?> visionError = ValueNotifier(null);
  ValueNotifier<bool> refresher = ValueNotifier(false);

  late CompanyProfileModel companyProfile;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                        future: cpc.show(),
                        widgetResult: (result) {
                          if (result['data'] != null) {
                            companyProfile = result['data'];
                            descriptionController.text =
                                companyProfile.description;
                            imageUrl = companyProfile.imageUrl;
                            whatsappMessageController.text =
                                companyProfile.whatsappMessage;
                            missionController.text = companyProfile.mission;
                            visionController.text = companyProfile.vision;
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
                                  labelText: 'Deskripsi',
                                  tooltip:
                                      'Jelaskan usaha anda (bisa dengan menceritakan riwayat perusahaan anda)',
                                  maxLines: 4,
                                  errorText: descriptionError,
                                  controller: descriptionController,
                                ),
                                const SizedBox(
                                  height: 8.0,
                                ),
                                InputSquareImage(
                                  action: (output) {
                                    image = output;
                                  },
                                  imageError: imageUrlError,
                                  label: 'Gambar Perusahaan',
                                  imageUrl: imageUrl,
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
                                  labelText: 'Visi Perusahaan',
                                  tooltip:
                                      'Ceritakan visi perusahaan Anda yang menjadikan perusahaan anda sumber daya yang tak tergantikan dan mendorong inovasi demi mewujudkan masa depan yang lebih baik.',
                                  errorText: visionError,
                                  maxLines: 2,
                                  controller: visionController,
                                ),
                                const SizedBox(
                                  height: 8.0,
                                ),
                                InputTypeBar(
                                  labelText: 'Misi Perusahaan',
                                  tooltip:
                                      'Ceritakan misi perusahaan Anda yang menggambarkan komitmen perusahaan untuk mencapai tujuan, layanan yang perusahaan tawarkan, dan dampak positif yang ingin perusahaan ciptakan dalam masyarakat.',
                                  errorText: missionError,
                                  maxLines: 2,
                                  controller: missionController,
                                ),
                                const SizedBox(
                                  height: 8.0,
                                ),
                                CustomButton(
                                  text: 'Simpan',
                                  action: () async {
                                    await cpc.createOrUpdate(
                                      description: descriptionController.text,
                                      whatsappMessage:
                                          whatsappMessageController.text,
                                      mission: missionController.text,
                                      vision: visionController.text,
                                      imageUrl: image,
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
                        });
                  }),
            ),
          ),
        ),
      ),
    );
  }

  void resetError() {
    descriptionError.value = null;
    whatsappMessageError.value = null;
    imageUrlError.value = null;
    missionError.value = null;
    visionError.value = null;
  }

  void checkError(errors) {
    if (errors.containsKey('description')) {
      descriptionError.value = errors['description'][0];
    }
    if (errors.containsKey('whatsapp_message')) {
      whatsappMessageError.value = errors['whatsapp_message'][0];
    }
    if (errors.containsKey('image_url')) {
      imageUrlError.value = errors['image_url'][0];
    }
    if (errors.containsKey('mission')) {
      missionError.value = errors['mission'][0];
    }
    if (errors.containsKey('vision')) {
      visionError.value = errors['vision'][0];
    }
  }
}

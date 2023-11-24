import 'dart:io';

import 'package:danuras_web_service_editor/src/menu/components/widget/custom_button.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/input_type_Bar.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/input_type_icon.dart';
import 'package:danuras_web_service_editor/src/model/testimony.dart';
import 'package:danuras_web_service_editor/src/view_controller/controller/testimony_controller.dart';
import 'package:flutter/material.dart';

class EditCardTestimony extends StatefulWidget {
  const EditCardTestimony({
    super.key,
    required this.t,
    required this.tc,
    required this.action,
  });
  static const routeName = '/edit-card-testimony';
  final Testimony t;
  final TestimonyController tc;
  final Function(Testimony t) action;

  @override
  State<EditCardTestimony> createState() => _EditCardTestimonyState();
}

class _EditCardTestimonyState extends State<EditCardTestimony> {
  TextEditingController valueController = TextEditingController(text: '');
  TextEditingController nameController = TextEditingController(text: '');
  TextEditingController jobController = TextEditingController(text: '');
  File? photoProfile;

  ValueNotifier<String?> ptError = ValueNotifier(null);
  ValueNotifier<String?> valueError = ValueNotifier(null);
  ValueNotifier<String?> nameError = ValueNotifier(null);
  ValueNotifier<String?> jobError = ValueNotifier(null);

  @override
  void initState() {
    valueController.text = widget.t.value;
    nameController.text = widget.t.name;
    jobController.text = widget.t.job;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Ubah Testimoni'),
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
              ),
              child: ListView(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InputTypeIcon(
                        action: (out) {
                          photoProfile = out;
                        },
                        iconError: ptError,
                        iconUrl: widget.t.photoProfile,
                        label: 'Foto',
                        tooltip: 'Foto dari orang yang memberikan penilaian',
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            InputTypeBar(
                              labelText: 'Nama',
                              tooltip:
                                  'Masukan nama dari orang yang memberikan testimoni',
                              errorText: nameError,
                              controller: nameController,
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            InputTypeBar(
                              labelText: 'Pekerjaan',
                              tooltip:
                                  'Masukan pekerjaan dari orang yang memberikan testimoni',
                              errorText: jobError,
                              controller: jobController,
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  InputTypeBar(
                    labelText: 'Pesan Testimoni',
                    tooltip: 'Masukan pesan testimoni dari pelanggan',
                    errorText: valueError,
                    maxLines: 4,
                    controller: valueController,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  CustomButton(
                    text: 'Simpan',
                    action: () async {
                      resetError();
                      await widget.tc.update(
                        value: valueController.text,
                        name: nameController.text,
                        job: jobController.text,
                        photoProfile: photoProfile,
                        context: context,
                        action: widget.action,
                        action400: (errors) {
                          checkError(errors);
                        },
                        testimonyid: widget.t.id,
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
    ptError.value = null;
    valueError.value = null;
    nameError.value = null;
    jobError.value = null;
  }

  void checkError(errors) {
    if (errors.containsKey('photo_profiles')) {
      ptError.value = errors['photo_profiles'][0];
    }
    if (errors.containsKey('value')) {
      valueError.value = errors['value'][0];
    }
    if (errors.containsKey('name')) {
      nameError.value = errors['name'][0];
    }
    if (errors.containsKey('job')) {
      jobError.value = errors['job'][0];
    }
  }
}

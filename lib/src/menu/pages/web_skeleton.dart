import 'dart:io';

import 'package:danuras_web_service_editor/src/menu/components/widget/custom_button.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/input_html_editor.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/input_square_image.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/input_type_Bar.dart';
import 'package:danuras_web_service_editor/src/menu/pages/add_section.dart';
import 'package:flutter/material.dart';

class WebSkeleton extends StatelessWidget {
  const WebSkeleton({super.key});
  static const routeName = '/web-skeleton';

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
          title: const Text('Kerangka Web'),
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
                  Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Color(0xff110011),
                          border: Border(
                            left: BorderSide(
                              width: 2,
                              color: Colors.white,
                            ),
                            top: BorderSide(
                              width: 2,
                              color: Colors.white,
                            ),
                            right: BorderSide(
                              width: 2,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        child: const Center(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Header',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xff110011),
                          border: Border.all(
                            width: 2,
                            color: Colors.white,
                          ),
                        ),
                        child: Image.asset(
                            'assets/images/kerangka/header/header-1.png'),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.restorablePushNamed(
                            context,
                            AddSection.routeName,
                          );
                        },
                        child: Container(
                          color: Colors.white,
                          child: const Icon(
                            Icons.add,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Color(0xff110011),
                          border: Border(
                            left: BorderSide(
                              width: 2,
                              color: Colors.white,
                            ),
                            top: BorderSide(
                              width: 2,
                              color: Colors.white,
                            ),
                            right: BorderSide(
                              width: 2,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        child: const Center(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Footer',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xff110011),
                          border: Border.all(
                            width: 2,
                            color: Colors.white,
                          ),
                        ),
                        child: Image.asset(
                            'assets/images/kerangka/footer/footer-1.png'),
                      ),
                    ],
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

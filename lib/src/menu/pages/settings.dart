import 'dart:developer';

import 'package:danuras_web_service_editor/src/menu/components/http/custom_future_builder.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/box_button.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/buy_me_a_coffee.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/custom_button.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/input_type_Bar.dart';
import 'package:danuras_web_service_editor/src/menu/pages/auth/input_endpoint.dart';
import 'package:danuras_web_service_editor/src/model/email_service.dart';
import 'package:danuras_web_service_editor/src/view_controller/controller/auth_controller.dart';
import 'package:danuras_web_service_editor/src/view_controller/controller/email_service_controller.dart';
import 'package:danuras_web_service_editor/src/view_controller/controller/endpoint_controller.dart';

import 'package:flutter/material.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});
  static const routeName = '/settings';

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  AuthController ac = AuthController();
  EndPointController epc = EndPointController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Pengaturan'),
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
            color: const Color(0xdd110011),
            child: Padding(
              padding: const EdgeInsets.only(
                right: 8.0,
                left: 8.0,
              ),
              child: ListView(
                children: [
                  Row(
                    children: const [
                      Expanded(
                          child: Divider(
                        color: Colors.white,
                      )),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          'Logout',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BoxButton(
                    label: 'Logout',
                    iconData: Icons.logout,
                    onTap: () async {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          backgroundColor: const Color(0xff110011),
                          title: const Text(
                            'Anda yakin ingin logout?',
                            style: TextStyle(color: Colors.white),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Tidak'),
                              child: const Text(
                                'Tidak',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            TextButton(
                              onPressed: () async {
                                AuthController au = AuthController();
                                await au.logout(context: context);
                                if (context.mounted) {
                                  Navigator.of(context).pop();
                                }
                              },
                              child: const Text(
                                'Ya',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  BoxButton(
                    label: 'Logout Semua Perangkat',
                    iconData: Icons.logout,
                    onTap: () async {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          backgroundColor: const Color(0xff110011),
                          title: const Text(
                            'Anda yakin ingin logout dari semua perangkat?',
                            style: TextStyle(color: Colors.white),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Tidak'),
                              child: const Text(
                                'Tidak',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            TextButton(
                              onPressed: () async {
                                AuthController au = AuthController();
                                await au.logoutAllDevice(context: context);
                                if (context.mounted) {
                                  Navigator.of(context).pop();
                                }
                              },
                              child: const Text(
                                'Ya',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: const [
                      Expanded(
                          child: Divider(
                        color: Colors.white,
                      )),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          'EndPoint',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BoxButton(
                    label: 'Ubah EndPoint',
                    iconData: Icons.edit,
                    onTap: () {
                      Navigator.of(context).pushNamed(InputEndpoint.routeName);
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: const [
                      Expanded(
                          child: Divider(
                        color: Colors.white,
                      )),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          'Dukung Pengembang',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Align(
                    alignment: Alignment.centerRight,
                    child: BuyMeACoffeeWidget(
                      sponsorID: 'danurasofficial',
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:danuras_web_service_editor/src/menu/components/widget/custom_button.dart';
import 'package:danuras_web_service_editor/src/menu/pages/auth/login.dart';
import 'package:flutter/material.dart'; /* 
import 'package:virture/view/auth/login.dart';
import 'package:virture/view/auth/verify_email.dart'; */

class CustomErrorWidget {
  static Widget dynamicError(BuildContext context) => ListView(
        children: [
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width - 20,
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xaa110011),
                border: Border.all(
                  width: 2,
                  color: Colors.white,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(4)),
              ),
              child: const Center(
                child: Text(
                  'Oops! Terjadi suatu kesalahan',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      );
  static Widget lostConnection(BuildContext context) => ListView(
        children: [
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width - 20,
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xaa110011),
                border: Border.all(
                  width: 2,
                  color: Colors.white,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(4)),
              ),
              child: const Center(
                child: Text(
                  'Koneksi Terputus',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      );

  static Widget notFound(String? data, BuildContext context) {
    return ListView(
      children: [
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width - 20,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xaa110011),
              border: Border.all(
                width: 2,
                color: Colors.white,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(4)),
            ),
            child: Center(
              child: Text(
                '$data tidak ditemukan',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }

  static Widget needAuthentication(BuildContext context) {
    return ListView(
      children: [
        Container(
          width: MediaQuery.of(context).size.width - 20,
          height: MediaQuery.of(context).size.height / 2,
          decoration: BoxDecoration(
            color: const Color(0xaa110011),
            border: Border.all(
              width: 2,
              color: Colors.white,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(4)),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Anda perlu login untuk mengakses halaman ini!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  CustomButton(
                    height: 60,
                    width: 160,
                    text: 'Login',
                    action: () {
                      Navigator.restorablePushNamed(
                        context,
                        Login.routeName,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  static Widget needVerification(BuildContext context) {
    return ListView(
      children: [
        Material(
          color: Colors.white,
          child: Center(
            child: Container(
              height: 40,
              width: 150,
              color: Colors.blue,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      opaque: false,
                      pageBuilder: (context, __, ___) {
                        return const SizedBox.shrink(); //const VerifyEmail();
                      },
                    ),
                  );
                },
                child: const Center(
                  child: Text(
                    'Verifikasi email',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

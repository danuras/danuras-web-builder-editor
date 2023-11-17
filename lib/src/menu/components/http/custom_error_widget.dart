import 'package:flutter/material.dart';/* 
import 'package:virture/view/auth/login.dart';
import 'package:virture/view/auth/verify_email.dart'; */

class CustomErrorWidget {
  static Widget dynamicError = ListView(
    children: const [
      Center(
        child: Text('Oops! Terjadi suatu kesalahan'),
      ),
    ],
  );
  static Widget lostConnection = ListView(
    children: const [
      Center(
        child: Text('Koneksi terputus'),
      ),
    ],
  );

  static Widget notFound(String? data) {
    return ListView(
      children: [
        Center(
          child: Text('$data tidak ditemukan'),
        ),
      ],
    );
  }

  static Widget needAuthentication(BuildContext context) {
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
                        return const SizedBox.shrink();//const Login();
                      },
                    ),
                  );
                },
                child: const Center(
                  child: Text(
                    'Login',
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
                        return const SizedBox.shrink();//const VerifyEmail();
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

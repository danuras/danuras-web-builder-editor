import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';


import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

class TutorialDeploy extends StatefulWidget {
  const TutorialDeploy({super.key});
  static const routeName = '/tutorial-deploy';

  @override
  State<TutorialDeploy> createState() => _TutorialDeployState();
}

class _TutorialDeployState extends State<TutorialDeploy> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Langkah-langkah deploy'),
          backgroundColor: const Color(0xff110011),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
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
                  const Text(
                    'Cara Deploy Manual',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  buildStep(
                    '1. Download atau clone repositori berikut: ',
                    'https://github.com/danuras/danuras-web-builder.git',
                  ),
                  buildStep(
                    '2. Run "composer install" di folder projek yang sudah diclone',
                    '',
                  ),
                  buildStep(
                    '3. Duplikat file ".env.example-2" lalu rename hasil duplikatnya dengan ".env"',
                    '',
                  ),
                  buildStep(
                    '4. Konfigurasi email pada file ".env"',
                    'MAIL_USERNAME=<email pengirim>\nMAIL_PASSWORD=<password aplikasi email pengirim>\nMAIL_FROM_ADDRESS=<email pengirim>\nMAIL_FROM_NAME=<nama email pengirim>',
                  ),
                  buildStep(
                    '5. Buat database bernama "dbwebbuilder" pada xampp',
                    '',
                  ),
                  buildStep(
                    '6. Run "php artisan migrate"',
                    '',
                  ),
                  buildStep(
                    '7. Run "php artisan db:seed --class=DatabaseSeeder" untuk mengisi data di database dengan data dami',
                    '',
                  ),
                  buildStep(
                    '8. Run "php artisan key:generate" untuk membuat App Key',
                    '',
                  ),
                  buildStep(
                    '9. Upload seluruh file projek di layanan hosting dan sesuaikan.',
                    '',
                  ),
                  buildStep(
                    '10. Buat database dengan isian dari mengimport file berikut: ',
                    'https://github.com/danuras/danuras-web-builder.git',
                  ),
                  buildStep(
                    '11. Sesuaikan konfigurasi database pada file ".env"',
                    'DB_DATABASE=<nama database yang berada di hosting>\nDB_USERNAME=<username database yang berada di hosting>\nDB_PASSWORD=<password database yang berada di hosting>',
                  ),
                  buildStep(
                    '12. Buka aplikasi "danuras-web-builder-editor"',
                    '',
                  ),
                  buildStep(
                    '13. Masukkan link web atau endpoint web yang telah di deploy.',
                    '',
                  ),
                  buildStep(
                    '14. Login dengan email: "a@a", password: "password"',
                    '',
                  ),
                  buildStep(
                    '15. Masuk ke menu pengguna',
                    '',
                  ),
                  buildStep(
                    '16. Tambahkan email anda beserta passwordnya',
                    '',
                  ),
                  buildStep(
                    '17. Ubah email yang ditambahkan tersebut sebagai akun utama',
                    '',
                  ),
                  buildStep(
                    '18. Logout dari aplikasi di menu pengaturan.',
                    '',
                  ),
                  buildStep(
                    '19. Login dengan akun yang telah ditambahkan sebelumnya.',
                    '',
                  ),
                  buildStep(
                    '20. Masuk ke menu pengguna.',
                    '',
                  ),
                  buildStep(
                    '21. Hapus akun default dengan email "a@a", password: "a@a".',
                    '',
                  ),
                  buildStep(
                    '22. Selesai, kirim email ke salam123.sb27@gmail.com bila butuh bantuan.',
                    '',
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Link (DEMO):',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  buildLink(
                    'https://demo-indoramah-web.000webhostapp.com/',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<String> _loadMarkdown() async {
    return await rootBundle.loadString('assets/tutorial_deploy.md');
  }

  Widget buildStep(String text, String link) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: link.isEmpty
          ? Text(
              text,
              style: const TextStyle(fontSize: 16, color: Colors.white),
            )
          : RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: text,
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  const TextSpan(text: '\n'),
                  TextSpan(
                    text: link,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        launchUrl(Uri.parse(link));
                      },
                  ),
                ],
              ),
            ),
    );
  }

  Widget buildLink(String link) {
    return InkWell(
      child: Text(
        link,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.blue,
          decoration: TextDecoration.underline,
        ),
      ),
      onTap: () {
        launch(link);
      },
    );
  }
}

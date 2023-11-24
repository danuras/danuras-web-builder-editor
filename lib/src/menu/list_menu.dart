
import 'package:danuras_web_service_editor/src/menu/pages/company_profile.dart';
import 'package:danuras_web_service_editor/src/menu/pages/contact.dart';
import 'package:danuras_web_service_editor/src/menu/pages/email_web.dart';
import 'package:danuras_web_service_editor/src/menu/pages/user/list_user.dart';
import 'package:danuras_web_service_editor/src/menu/pages/order_flow/order_flow_view.dart';
import 'package:danuras_web_service_editor/src/menu/pages/social_media.dart';
import 'package:danuras_web_service_editor/src/menu/pages/web_color.dart';
import 'package:danuras_web_service_editor/src/menu/pages/web_information.dart';
import 'package:danuras_web_service_editor/src/menu/pages/web_skeleton/web_skeleton.dart';
import 'package:danuras_web_service_editor/src/model/auth.dart';
import 'package:danuras_web_service_editor/src/view_controller/controller/auth_controller.dart';
import 'package:flutter/material.dart';


/// Displays a list of SampleItems.
class ListMenu extends StatelessWidget {
  const ListMenu({
    super.key,
  });

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Daftar Menu'),
          backgroundColor: const Color(0xff110011),
          actions: [
            IconButton(
              onPressed: () async {
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
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
            ),
          ],
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
          child: ListView(
            // Providing a restorationId allows the ListView to restore the
            // scroll position when a user leaves and returns to the app after it
            // has been killed while running in the background.
            restorationId: 'listMenu',
            children: [
              TileMenu(
                title1: 'Kerangka Web',
                title2: 'Informasi Web',
                icon1: Icons.web,
                icon2: Icons.info_outlined,
                action1: () {
                  Navigator.restorablePushNamed(
                    context,
                    WebSkeleton.routeName,
                  );
                },
                action2: () {
                  // Navigate to the details page. If the user leaves and returns to
                  // the app after it has been killed while running in the
                  // background, the navigation stack is restored.
                  Navigator.restorablePushNamed(
                    context,
                    WebInformation.routeName,
                  );
                },
              ),
              (Auth.isPrimary)
                  ? TileMenu(
                      title1: 'Pengguna',
                      title2: 'Email Web',
                      icon1: Icons.person,
                      icon2: Icons.email_outlined,
                      action1: () {
                        Navigator.restorablePushNamed(
                          context,
                          ListUser.routeName,
                        );
                      },
                      action2: () {
                        // Navigate to the details page. If the user leaves and returns to
                        // the app after it has been killed while running in the
                        // background, the navigation stack is restored.
                        Navigator.restorablePushNamed(
                          context,
                          EmailWeb.routeName,
                        );
                      },
                    )
                  : const SizedBox(),
              TileMenu(
                title1: 'Kontak',
                title2: 'Profil Perusahaan',
                icon1: Icons.contact_page_rounded,
                icon2: Icons.factory_outlined,
                action1: () {
                  Navigator.restorablePushNamed(
                    context,
                    Contact.routeName,
                  );
                },
                action2: () {
                  // Navigate to the details page. If the user leaves and returns to
                  // the app after it has been killed while running in the
                  // background, the navigation stack is restored.
                  Navigator.restorablePushNamed(
                    context,
                    CompanyProfile.routeName,
                  );
                },
              ),
              TileMenu(
                title1: 'Warna web',
                title2: 'Link Media Sosial',
                icon1: Icons.color_lens_rounded,
                icon2: Icons.link,
                action1: () {
                  Navigator.restorablePushNamed(
                    context,
                    WebColor.routeName,
                  );
                },
                action2: () {
                  Navigator.restorablePushNamed(
                    context,
                    SocialMedia.routeName,
                  );
                },
              ),
              TileMenu(
                title1: 'Langkah Pemesanan',
                title2: 'Link Media Sosial',
                icon1: Icons.follow_the_signs,
                icon2: Icons.link,
                is2null: true,
                action1: () {
                  Navigator.restorablePushNamed(
                    context,
                    OrderFlowView.routeName,
                  );
                },
                action2: () {
                  /* Navigator.restorablePushNamed(
                    context,
                    SocialMedia.routeName,
                  ); */
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TileMenu extends StatelessWidget {
  const TileMenu({
    super.key,
    required this.title1,
    required this.title2,
    required this.icon1,
    required this.icon2,
    required this.action1,
    required this.action2,
    this.is2null = false,
  });
  final Function() action1, action2;
  final IconData icon1, icon2;
  final String title1, title2;
  final bool is2null;

  @override
  Widget build(BuildContext context) {
    ValueNotifier isHover1 = ValueNotifier(false);
    ValueNotifier isHover2 = ValueNotifier(false);
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
                left: 8.0,
                right: 8.0,
              ),
              child: ValueListenableBuilder(
                  valueListenable: isHover1,
                  builder: (context, ih, child) {
                    return Container(
                      decoration: BoxDecoration(
                        color: (ih)
                            ? const Color(0xee220022)
                            : const Color(0xbb220022),
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                      child: InkWell(
                        onTap: action1,
                        onTapDown: (value) {
                          isHover1.value = true;
                        },
                        onTapCancel: () {
                          isHover1.value = false;
                        },
                        onTapUp: (v) {
                          isHover2.value = false;
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Icon(
                                icon1,
                                color: Colors.white,
                                size: (MediaQuery.of(context).size.width) / 3,
                              ),
                              Text(
                                title1,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ),
          Expanded(
            flex: 1,
            child: Builder(builder: (context) {
              if (is2null) {
                return const SizedBox.shrink();
              } else {
                return Padding(
                  padding: const EdgeInsets.only(
                    top: 8.0,
                    left: 8.0,
                    right: 8.0,
                  ),
                  child: ValueListenableBuilder(
                    valueListenable: isHover2,
                    builder: (context, ih, child) {
                      return Container(
                        decoration: BoxDecoration(
                          color: (ih)
                              ? const Color(0xee220022)
                              : const Color(0xbb220022),
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        child: InkWell(
                          onTap: action2,
                          onTapDown: (value) {
                            isHover2.value = true;
                          },
                          onTapCancel: () {
                            isHover2.value = false;
                          },
                          onTapUp: (v) {
                            isHover2.value = false;
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Icon(
                                  icon2,
                                  color: Colors.white,
                                  size: (MediaQuery.of(context).size.width) / 3,
                                ),
                                Text(
                                  title2,
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}

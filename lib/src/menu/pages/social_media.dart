import 'package:danuras_web_service_editor/src/menu/components/http/custom_future_builder.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/custom_button.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/input_type_Bar.dart';
import 'package:danuras_web_service_editor/src/model/social_media_model.dart';
import 'package:danuras_web_service_editor/src/view_controller/controller/social_media_controller.dart';
import 'package:flutter/material.dart';

class SocialMedia extends StatefulWidget {
  const SocialMedia({super.key});
  static const routeName = '/social-media';

  @override
  State<SocialMedia> createState() => _SocialMediaState();
}

class _SocialMediaState extends State<SocialMedia> {
  TextEditingController facebookController = TextEditingController(text: '');
  TextEditingController twitterController = TextEditingController(text: '');
  TextEditingController linkedinController = TextEditingController(text: '');
  TextEditingController instagramController = TextEditingController(text: '');
  TextEditingController googlePlusController = TextEditingController(text: '');
  TextEditingController youtubeController = TextEditingController(text: '');

  SocialMediaController smc = SocialMediaController();

  ValueNotifier<String?> facebookError = ValueNotifier(null);
  ValueNotifier<String?> twitterError = ValueNotifier(null);
  ValueNotifier<String?> linkedinError = ValueNotifier(null);
  ValueNotifier<String?> instagramError = ValueNotifier(null);
  ValueNotifier<String?> googlePlusError = ValueNotifier(null);
  ValueNotifier<String?> youtubeError = ValueNotifier(null);
  ValueNotifier<bool> refresher = ValueNotifier(false);

  late SocialMediaModel socialMediaModel;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Media Sosial'),
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
                        future: smc.show(),
                        widgetResult: (result) {
                          if (result['data'] != null) {
                            socialMediaModel = result['data'];
                            facebookController.text =
                                socialMediaModel.facebook ?? '';
                            twitterController.text =
                                socialMediaModel.twitter ?? '';
                            linkedinController.text =
                                socialMediaModel.linkedin ?? '';
                            instagramController.text =
                                socialMediaModel.instagram ?? '';
                            googlePlusController.text =
                                socialMediaModel.googlePlus ?? '';
                            youtubeController.text =
                                socialMediaModel.youtube ?? '';
                          }
                          return Padding(
                            padding: const EdgeInsets.only(
                              left: 8.0,
                              right: 8.0,
                              top: 16.0,
                            ),
                            child: ListView(
                              children: [
                                InputTypeBar(
                                  labelText: 'Facebook',
                                  tooltip:
                                      'Masukan link yang mengarah ke akun facebook perusahaan.',
                                  errorText: facebookError,
                                  controller: facebookController,
                                ),
                                const SizedBox(
                                  height: 8.0,
                                ),
                                InputTypeBar(
                                  labelText: 'Twitter',
                                  tooltip:
                                      'Masukan link yang mengarah ke akun twitter perusahaan.',
                                  errorText: twitterError,
                                  controller: twitterController,
                                ),
                                const SizedBox(
                                  height: 8.0,
                                ),
                                InputTypeBar(
                                  labelText: 'LinkedIn',
                                  tooltip:
                                      'Masukan link yang mengarah ke akun linkedin perusahaan.',
                                  errorText: linkedinError,
                                  controller: linkedinController,
                                ),
                                const SizedBox(
                                  height: 8.0,
                                ),
                                InputTypeBar(
                                  labelText: 'Instagram',
                                  tooltip:
                                      'Masukan link yang mengarah ke akun Instagram perusahaan.',
                                  errorText: instagramError,
                                  controller: instagramController,
                                ),
                                const SizedBox(
                                  height: 8.0,
                                ),
                                InputTypeBar(
                                  labelText: 'Google Plus',
                                  tooltip:
                                      'Masukan link yang mengarah ke akun Google Plus perusahaan.',
                                  errorText: googlePlusError,
                                  controller: googlePlusController,
                                ),
                                const SizedBox(
                                  height: 8.0,
                                ),
                                InputTypeBar(
                                  labelText: 'Youtube',
                                  tooltip:
                                      'Masukan link yang mengarah ke akun Youtube perusahaan.',
                                  errorText: youtubeError,
                                  controller: youtubeController,
                                ),
                                const SizedBox(
                                  height: 8.0,
                                ),
                                CustomButton(
                                    text: 'Simpan',
                                    action: () async {
                                      resetError();
                                      await smc.createOrUpdate(
                                          socialMedia:
                                              SocialMediaModel.fromJson({
                                            'facebook': facebookController.text,
                                            'twitter': twitterController.text,
                                            'linkedin': linkedinController.text,
                                            'instagram':
                                                instagramController.text,
                                            'google_plus':
                                                googlePlusController.text,
                                            'youtube': youtubeController.text,
                                          }),
                                          context: context,
                                          action: () {},
                                          action400: (errors) {
                                            checkError(errors);
                                          });
                                    }),
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
    facebookError.value = null;
    twitterError.value = null;
    linkedinError.value = null;
    instagramError.value = null;
    googlePlusError.value = null;
    youtubeError.value = null;
  }

  void checkError(errors) {
    if (errors.containsKey('facebook')) {
      facebookError.value = errors['facebook'][0];
    }
    if (errors.containsKey('twitter')) {
      twitterError.value = errors['twitter'][0];
    }
    if (errors.containsKey('linkedin')) {
      linkedinError.value = errors['linkedin'][0];
    }
    if (errors.containsKey('instagram')) {
      instagramError.value = errors['instagram'][0];
    }
    if (errors.containsKey('google_plus')) {
      googlePlusError.value = errors['google_plus'][0];
    }
    if (errors.containsKey('youtube')) {
      youtubeError.value = errors['youtube'][0];
    }
  }
}

import 'package:danuras_web_service_editor/src/menu/pages/auth/input_endpoint.dart';
import 'package:danuras_web_service_editor/src/menu/pages/card/add/add_card_1.dart';
import 'package:danuras_web_service_editor/src/menu/pages/card/add/add_card_2.dart';
import 'package:danuras_web_service_editor/src/menu/pages/card/add/add_card_3.dart';
import 'package:danuras_web_service_editor/src/menu/pages/card/add/add_card_advantage.dart';
import 'package:danuras_web_service_editor/src/menu/pages/card/add/add_card_blog.dart';
import 'package:danuras_web_service_editor/src/menu/pages/card/add/add_card_content_1.dart';
import 'package:danuras_web_service_editor/src/menu/pages/card/add/add_card_content_2.dart';
import 'package:danuras_web_service_editor/src/menu/pages/card/add/add_card_testimony.dart';
import 'package:danuras_web_service_editor/src/menu/pages/card/edit/edit_card_1.dart';
import 'package:danuras_web_service_editor/src/menu/pages/card/edit/edit_card_2.dart';
import 'package:danuras_web_service_editor/src/menu/pages/card/edit/edit_card_3.dart';
import 'package:danuras_web_service_editor/src/menu/pages/card/edit/edit_card_advantage.dart';
import 'package:danuras_web_service_editor/src/menu/pages/card/edit/edit_card_blog.dart';
import 'package:danuras_web_service_editor/src/menu/pages/card/edit/edit_card_content_1.dart';
import 'package:danuras_web_service_editor/src/menu/pages/card/edit/edit_card_content_2.dart';
import 'package:danuras_web_service_editor/src/menu/pages/card/edit/edit_card_testimony.dart';
import 'package:danuras_web_service_editor/src/menu/pages/content/add/add_content.dart';
import 'package:danuras_web_service_editor/src/menu/pages/content/add/add_content_1.dart';
import 'package:danuras_web_service_editor/src/menu/pages/content/add/add_content_2.dart';
import 'package:danuras_web_service_editor/src/menu/pages/content/edit/edit_content_1.dart';
import 'package:danuras_web_service_editor/src/menu/pages/content/edit/edit_content_2.dart';
import 'package:danuras_web_service_editor/src/menu/pages/settings.dart';
import 'package:danuras_web_service_editor/src/menu/pages/tutorial_deploy.dart';
import 'package:danuras_web_service_editor/src/menu/pages/web_skeleton/add_section.dart';
import 'package:danuras_web_service_editor/src/menu/pages/auth/input_email.dart';
import 'package:danuras_web_service_editor/src/menu/pages/auth/input_token.dart';
import 'package:danuras_web_service_editor/src/menu/pages/company_profile.dart';
import 'package:danuras_web_service_editor/src/menu/pages/contact.dart';
import 'package:danuras_web_service_editor/src/menu/pages/user/add_user.dart';
import 'package:danuras_web_service_editor/src/menu/pages/user/list_user.dart';
import 'package:danuras_web_service_editor/src/menu/pages/auth/login.dart';
import 'package:danuras_web_service_editor/src/menu/pages/order_flow/add_order_flow.dart';
import 'package:danuras_web_service_editor/src/menu/pages/order_flow/edit_order_flow.dart';
import 'package:danuras_web_service_editor/src/menu/pages/order_flow/order_flow_view.dart';
import 'package:danuras_web_service_editor/src/menu/pages/social_media.dart';
import 'package:danuras_web_service_editor/src/menu/pages/web_color.dart';
import 'package:danuras_web_service_editor/src/menu/pages/web_skeleton/add_section_widget/add_section_advantage.dart';
import 'package:danuras_web_service_editor/src/menu/pages/web_skeleton/add_section_widget/add_section_blog.dart';
import 'package:danuras_web_service_editor/src/menu/pages/web_skeleton/add_section_widget/add_section_card.dart';
import 'package:danuras_web_service_editor/src/menu/pages/web_skeleton/add_section_widget/add_section_location.dart';
import 'package:danuras_web_service_editor/src/menu/pages/web_skeleton/add_section_widget/add_section_testimony.dart';
import 'package:danuras_web_service_editor/src/menu/pages/web_skeleton/edit_section_widget/edit_section_advantage.dart';
import 'package:danuras_web_service_editor/src/menu/pages/web_skeleton/edit_section_widget/edit_section_blog.dart';
import 'package:danuras_web_service_editor/src/menu/pages/web_skeleton/edit_section_widget/edit_section_card.dart';
import 'package:danuras_web_service_editor/src/menu/pages/web_skeleton/edit_section_widget/edit_section_location.dart';
import 'package:danuras_web_service_editor/src/menu/pages/web_skeleton/edit_section_widget/edit_section_testimony.dart';
import 'package:danuras_web_service_editor/src/menu/pages/web_skeleton/web_skeleton.dart';
import 'package:danuras_web_service_editor/src/model/auth.dart';
import 'package:danuras_web_service_editor/src/model/endpoint.dart';
import 'package:danuras_web_service_editor/src/view_controller/controller/order_flow_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'menu/pages/email_web.dart';
import 'menu/pages/web_information.dart';
import 'menu/list_menu.dart';
import 'settings/settings_controller.dart';
import 'settings/settings_view.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.settingsController,
  });

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    // Glue the SettingsController to the MaterialApp.
    //
    // The AnimatedBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return AnimatedBuilder(
      animation: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          // Providing a restorationScopeId allows the Navigator built by the
          // MaterialApp to restore the navigation stack when a user leaves and
          // returns to the app after it has been killed while running in the
          // background.
          restorationScopeId: 'app',

          // Provide the generated AppLocalizations to the MaterialApp. This
          // allows descendant Widgets to display the correct translations
          // depending on the user's locale.
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''), // English, no country code
          ],

          // Use AppLocalizations to configure the correct application title
          // depending on the user's locale.
          //
          // The appTitle is defined in .arb files found in the localization
          // directory.
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,

          // Define a light and dark color theme. Then, read the user's
          // preferred ThemeMode (light, dark, or system default) from the
          // SettingsController to display the correct theme.
          theme: ThemeData(),
          darkTheme: ThemeData.dark(),
          themeMode: settingsController.themeMode,

          // Define a function to handle named routes in order to support
          // Flutter web url navigation and deep linking.
          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {
                Map<String, dynamic>? args =
                    routeSettings.arguments as Map<String, dynamic>?;
                switch (routeSettings.name) {
                  case WebInformation.routeName:
                    return const WebInformation();
                  case EmailWeb.routeName:
                    return const EmailWeb();
                  case Contact.routeName:
                    return const Contact();
                  case CompanyProfile.routeName:
                    return const CompanyProfile();
                  case WebColor.routeName:
                    return const WebColor();
                  case SocialMedia.routeName:
                    return const SocialMedia();
                  case ListUser.routeName:
                    return const ListUser();
                  case WebSkeleton.routeName:
                    return const WebSkeleton();
                  case AddSection.routeName:
                    return AddSection(
                      rank: args!['rank'],
                      lwc: args['lwc'],
                      wcc: args['wcc'],
                      action: args['action'],
                    );
                  case OrderFlowView.routeName:
                    return const OrderFlowView();
                  case Login.routeName:
                    return const Login();
                  case InputEmail.routeName:
                    return InputEmail(
                      authController: args!['ac'],
                    );
                  case SaveNewPassword.routeName:
                    return SaveNewPassword(
                      authController: args!['ac'],
                      email: args['email'],
                    );
                  case AddUser.routeName:
                    return AddUser(
                      uc: args!['uc'],
                      action: args['action'],
                    );
                  case AddOrderFlow.routeName:
                    return AddOrderFlow(
                      ofc: args!['ofc'] as OrderFlowController,
                      action: args['action'],
                    );
                  case EditOrderFlow.routeName:
                    return EditOrderFlow(
                      ofc: args!['ofc'] as OrderFlowController,
                      action: args['action'],
                      orderFlow: args['order_flow'],
                    );
                  case EditSectionCard.routeName:
                    return EditSectionCard(
                      cardBoxId: args!['card_box_id'],
                      cardType: args['card_type'],
                      action: args['action'],
                    );
                  case EditSectionAdvantage.routeName:
                    return const EditSectionAdvantage();
                  case EditSectionTestimony.routeName:
                    return const EditSectionTestimony();
                  case EditSectionBlog.routeName:
                    return const EditSectionBlog();
                  case EditSectionLocation.routeName:
                    return const EditSectionLocation();
                  case AddSectionCard.routeName:
                    return AddSectionCard(
                      cardType: args!['card_type'],
                      action: args['action'],
                      wcc: args['wcc'],
                      rank: args['rank'],
                    );
                  case AddSectionAdvantage.routeName:
                    return AddSectionAdvantage(
                      action: args!['action'],
                      wcc: args['wcc'],
                      rank: args['rank'],
                    );
                  case AddSectionTestimony.routeName:
                    return AddSectionTestimony(
                      action: args!['action'],
                      wcc: args['wcc'],
                      rank: args['rank'],
                    );
                  case AddSectionLocation.routeName:
                    return AddSectionLocation(
                      action: args!['action'],
                      wcc: args['wcc'],
                      rank: args['rank'],
                    );
                  case AddSectionBlog.routeName:
                    return AddSectionBlog(
                      action: args!['action'],
                      wcc: args['wcc'],
                      rank: args['rank'],
                    );
                  case AddCard1.routeName:
                    return AddCard1(
                      action: args!['action'],
                      cardBoxId: args['card_box_id'],
                      cc: args['cc'],
                    );
                  case EditCard1.routeName:
                    return EditCard1(
                      action: args!['action'],
                      cm: args['cm'],
                      cc: args['cc'],
                    );
                  case AddCard2.routeName:
                    return AddCard2(
                      action: args!['action'],
                      cardBoxId: args['card_box_id'],
                      cc: args['cc'],
                    );
                  case EditCard2.routeName:
                    return EditCard2(
                      action: args!['action'],
                      cm: args['cm'],
                      cc: args['cc'],
                    );
                  case AddCard3.routeName:
                    return AddCard3(
                      action: args!['action'],
                      cardBoxId: args['card_box_id'],
                      cc: args['cc'],
                    );
                  case EditCard3.routeName:
                    return EditCard3(
                      action: args!['action'],
                      cm: args['cm'],
                      cc: args['cc'],
                    );
                  case AddCardAdvantage.routeName:
                    return AddCardAdvantage(
                      action: args!['action'],
                      acc: args['acc'],
                    );
                  case EditCardAdvantage.routeName:
                    return EditCardAdvantage(
                      action: args!['action'],
                      acc: args['acc'],
                      ac: args['ac'],
                    );
                  case AddCardTestimony.routeName:
                    return AddCardTestimony(
                      action: args!['action'],
                      tc: args['tc'],
                    );
                  case EditCardTestimony.routeName:
                    return EditCardTestimony(
                      action: args!['action'],
                      tc: args['tc'],
                      t: args['t'],
                    );
                  case AddCardBlog.routeName:
                    return AddCardBlog(
                      action: args!['action'],
                      bc: args['bc'],
                    );
                  case EditCardBlog.routeName:
                    return EditCardBlog(
                      action: args!['action'],
                      bc: args['bc'],
                      b: args['b'],
                    );
                  case AddContent.routeName:
                    return AddContent(
                      action: args!['action'],
                      ctc: args['ctc'],
                      cardId: args['card_id'],
                    );
                  case AddContent1.routeName:
                    return AddContent1(
                      action: args!['action'],
                      ctc: args['ctc'],
                      cardId: args['card_id'],
                    );
                  case AddContent2.routeName:
                    return AddContent2(
                      action: args!['action'],
                      ctc: args['ctc'],
                      cardId: args['card_id'],
                    );
                  case EditContent1.routeName:
                    return EditContent1(
                      action: args!['action'],
                      ctc: args['ctc'],
                      cardId: args['card_id'],
                      contentType: args['ct'],
                    );
                  case EditContent2.routeName:
                    return EditContent2(
                      action: args!['action'],
                      ctc: args['ctc'],
                      cardId: args['card_id'],
                      contentType: args['ct'],
                    );
                  case AddCardContent1.routeName:
                    return AddCardContent1(
                      action: args!['action'],
                      ctc: args['ctc'],
                      cardTypeId: args['card_type_id'],
                    );
                  case AddCardContent2.routeName:
                    return AddCardContent2(
                      action: args!['action'],
                      ctc: args['ctc'],
                      cardTypeId: args['card_type_id'],
                    );
                  case EditCardContent1.routeName:
                    return EditCardContent1(
                      action: args!['action'],
                      ctc: args['ctc'],
                      contentTypeId: args['content_type_id'],
                    );
                  case EditCardContent2.routeName:
                    return EditCardContent2(
                      action: args!['action'],
                      ctc: args['ctc'],
                      contentTypeId: args['content_type_id'],
                    );
                  case Setting.routeName:
                    return const Setting();
                  case InputEndpoint.routeName:
                    return const InputEndpoint();
                  case TutorialDeploy.routeName:
                    return const TutorialDeploy();
                  case ListMenu.routeName:
                  default:
                    if (EndPoint.value == null) {
                      return const InputEndpoint();
                    }
                    if (Auth.accessToken == null) {
                      return const Login();
                    }
                    return const ListMenu();
                }
              },
            );
          },
        );
      },
    );
  }
}

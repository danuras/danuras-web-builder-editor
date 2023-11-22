
import 'package:danuras_web_service_editor/src/menu/components/http/custom_future_builder.dart';
import 'package:danuras_web_service_editor/src/menu/components/widget/card/list_card.dart';
import 'package:danuras_web_service_editor/src/model/blog.dart';
import 'package:danuras_web_service_editor/src/view_controller/controller/blog_controller.dart';
import 'package:flutter/material.dart';

class EditSectionBlog extends StatefulWidget {
  const EditSectionBlog({
    super.key,
  });
  static const routeName = '/web-content/edit-section-blog';

  @override
  State<EditSectionBlog> createState() => _EditSectionBlogState();
}

class _EditSectionBlogState extends State<EditSectionBlog> {

  ValueNotifier<bool> refresher = ValueNotifier(false);

  BlogController bc = BlogController();
  List<Blog> lb = [];

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
          title: const Text('Edit Bagian Blog'),
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
              child: ValueListenableBuilder(
                valueListenable: refresher,
                builder: (context, r, child) {
                  return CustomFutureBuilder(
                    future: bc.show(),
                    widgetResult: (result) {
                      lb = result['data'];
                      return Padding(
                        padding: const EdgeInsets.only(
                          left: 8.0,
                          right: 8.0,
                        ),
                        child: ListView(
                          children: [
                            
                            ListCard(lcm: lb, cardType: '', contentType: 'blog'),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

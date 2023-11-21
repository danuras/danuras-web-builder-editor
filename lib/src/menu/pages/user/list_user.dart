import 'package:danuras_web_service_editor/src/menu/components/http/custom_future_builder.dart';
import 'package:danuras_web_service_editor/src/menu/pages/user/add_user.dart';
import 'package:danuras_web_service_editor/src/model/user.dart';
import 'package:danuras_web_service_editor/src/view_controller/controller/user_controller.dart';
import 'package:flutter/material.dart';

class ListUser extends StatefulWidget {
  const ListUser({super.key});
  static const routeName = '/list-user';

  @override
  State<ListUser> createState() => _ListUserState();
}

class _ListUserState extends State<ListUser> {
  List<User> lou = [];
  UserController uc = UserController();
  ValueNotifier<bool> refresher = ValueNotifier(false);
  ValueNotifier<bool> refresherResult = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Daftar Akun'),
          backgroundColor: const Color(0xff110011),
        ),
        floatingActionButton: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              AddUser.routeName,
              arguments: <String, dynamic>{
                'uc': uc,
                'action': (user) {
                  lou.add(user);
                  refresherResult.value = !refresherResult.value;
                }
              },
            );
          },
          child: Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: const Color(0xff110011),
              borderRadius: const BorderRadius.all(Radius.circular(35)),
              border: Border.all(width: 2, color: Colors.white),
            ),
            child: const Icon(
              Icons.add,
              color: Colors.white,
              size: 50,
            ),
          ),
        ),
        body: Container(
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
                    future: uc.show(),
                    widgetResult: (result) {
                      lou = result['data'];
                      return Padding(
                        padding: const EdgeInsets.only(
                          left: 8.0,
                          right: 8.0,
                          top: 16.0,
                        ),
                        child: ValueListenableBuilder(
                            valueListenable: refresherResult,
                            builder: (context, rr, child) {
                              return ListView(
                                children: [
                                  Table(
                                    border: TableBorder.all(
                                      width: 2,
                                      color: Colors.white,
                                    ),
                                    columnWidths: const <int, TableColumnWidth>{
                                      0: FlexColumnWidth(2),
                                      1: FixedColumnWidth(80),
                                      2: FixedColumnWidth(64),
                                    },
                                    defaultVerticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                    children: [
                                          TableRow(
                                            children: <Widget>[
                                              const Center(
                                                child: Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text(
                                                    'Email',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Center(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      const Text(
                                                        'Akses',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      Tooltip(
                                                        message:
                                                            'Kolom ini dapat digunakan untuk mengubah hak akses dari user',
                                                        textStyle:
                                                            const TextStyle(
                                                                color: Colors
                                                                    .white),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: const Color(
                                                              0xff330033),
                                                          border: Border.all(
                                                              color:
                                                                  Colors.white,
                                                              width: 2),
                                                        ),
                                                        triggerMode:
                                                            TooltipTriggerMode
                                                                .tap,
                                                        child: const Icon(
                                                          Icons.help_outline,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              const Center(
                                                child: Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text(
                                                    'hapus',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ] +
                                        List.generate(
                                          lou.length,
                                          (index) {
                                            if (lou[index].isPrimary) {
                                              return TableRow(
                                                children: <Widget>[
                                                  Center(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        lou[index].email,
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Center(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: GestureDetector(
                                                        onTap: () {},
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10),
                                                          decoration:
                                                              const BoxDecoration(
                                                            color: Colors.green,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                  4),
                                                            ),
                                                          ),
                                                          child: const Icon(
                                                            Icons.shield,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Center(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            const SnackBar(
                                                              content: Text(
                                                                  "Anda tidak bisa menghapus akun utama"),
                                                            ),
                                                          );
                                                        },
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10),
                                                          decoration:
                                                              const BoxDecoration(
                                                            color: Colors.grey,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                  4),
                                                            ),
                                                          ),
                                                          child: const Icon(
                                                            Icons.delete,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            } else {
                                              return TableRow(
                                                children: <Widget>[
                                                  Center(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        lou[index].email,
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Center(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          showDialog<String>(
                                                            context: context,
                                                            builder: (BuildContext
                                                                    context) =>
                                                                AlertDialog(
                                                              backgroundColor:
                                                                  const Color(
                                                                      0xff110011),
                                                              title: Text(
                                                                'Anda yakin ingin mengubah akun ${lou[index].email} menjadi akun utama?',
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                              actions: <Widget>[
                                                                TextButton(
                                                                  onPressed: () =>
                                                                      Navigator.pop(
                                                                          context,
                                                                          'Tidak'),
                                                                  child:
                                                                      const Text(
                                                                    'Tidak',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                                TextButton(
                                                                  onPressed:
                                                                      () async {
                                                                    await uc
                                                                        .changePrimary(
                                                                      idx: lou[
                                                                              index]
                                                                          .id,
                                                                      email: lou[
                                                                              index]
                                                                          .email,
                                                                      context:
                                                                          context,
                                                                    );
                                                                  },
                                                                  child:
                                                                      const Text(
                                                                    'Ya',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10),
                                                          decoration:
                                                              const BoxDecoration(
                                                            color: Colors.grey,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                  4),
                                                            ),
                                                          ),
                                                          child: const Icon(
                                                            Icons.shield,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Center(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          showDialog<String>(
                                                            context: context,
                                                            builder: (BuildContext
                                                                    context) =>
                                                                AlertDialog(
                                                              backgroundColor:
                                                                  const Color(
                                                                      0xff110011),
                                                              title: Text(
                                                                'Anda yakin ingin menghapus akun ${lou[index].email}?',
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                              actions: <Widget>[
                                                                TextButton(
                                                                  onPressed: () =>
                                                                      Navigator.pop(
                                                                          context,
                                                                          'Tidak'),
                                                                  child:
                                                                      const Text(
                                                                    'Tidak',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                                TextButton(
                                                                  onPressed:
                                                                      () async {
                                                                    await uc
                                                                        .delete(
                                                                      idx: lou[
                                                                              index]
                                                                          .id,
                                                                      email: lou[
                                                                              index]
                                                                          .email,
                                                                      action:
                                                                          (idx) {
                                                                        lou.removeAt(
                                                                            index);
                                                                        refresherResult.value =
                                                                            !refresherResult.value;
                                                                      },
                                                                      context:
                                                                          context,
                                                                    );
                                                                    if (context
                                                                        .mounted) {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    }
                                                                  },
                                                                  child:
                                                                      const Text(
                                                                    'Ya',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10),
                                                          decoration:
                                                              const BoxDecoration(
                                                            color: Colors.red,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                  4),
                                                            ),
                                                          ),
                                                          child: const Icon(
                                                            Icons.delete,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            }
                                          },
                                        ),
                                  ),
                                ],
                              );
                            }),
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

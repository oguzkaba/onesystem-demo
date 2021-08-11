import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onesystem/controllers/database_controller.dart';
import 'package:onesystem/controllers/page_controller.dart';
import 'package:onesystem/controllers/sharpref_controller.dart';
import 'package:onesystem/controllers/theme_controller.dart';
import 'package:onesystem/models/globals_model.dart';
import 'package:onesystem/models/mysqlQuery_model.dart';
import 'package:onesystem/views/tablet/profile_page.dart';
import 'package:onesystem/views/tablet/widgets/dialog_widget.dart';

// ignore: must_be_immutable
class TabNavWidget extends StatelessWidget {
  final navList = [
    'Main',
    'Material',
    'Approval',
    'NDT',
    'Release',
    'Shipping'
    //'Settings'
  ];

  Map<int, List<int>> userLevelFilter = {
    1: [0, 1, 2, 3, 4, 5],
    2: [0, 1, 3]
  };

  final List<IconData> navIcon = [
    Icons.widgets,
    Icons.layers,
    Icons.fact_check,
    Icons.warning,
    Icons.assignment,
    Icons.airplane_ticket
    //Icons.settings
  ];
  @override
  Widget build(BuildContext context) {
    SharedPrefController sc = Get.put(SharedPrefController());
    PagesController pc = Get.put(PagesController());
    ThemeController tc = Get.put(ThemeController());
    DatabaseController dbc = Get.put(DatabaseController());

    return Obx(
      () => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(.2),
                blurRadius: 2,
                offset: Offset(0.5, 0.0),
                spreadRadius: 2)
          ],
        ),
        width: 80,
        height: Get.height,
        child: NavigationRail(
          labelType: NavigationRailLabelType.selected,
          groupAlignment: 0,
          onDestinationSelected: (int index) {
            pc.pindex = index;
            pc.pageindex(index);
          },
          leading: _navLogo(sc, tc),
          destinations: [
            if (userLevelFilter[sc.level].isNotEmpty)
              for (var i = 0; i < userLevelFilter[sc.level].length; i++)
                NavigationRailDestination(
                    padding: EdgeInsets.zero,
                    icon: Icon(navIcon[userLevelFilter[sc.level][i]],
                        color: tc.isColorChangeWD()),
                    label: Text(
                      navList[i],
                      style: TextStyle(color: Global.focusedBlue, fontSize: 13),
                    ),
                    selectedIcon: Container(
                        width: 80,
                        height: 40,
                        decoration: BoxDecoration(
                            //color: Colors.grey[100],
                            border: Border(
                                right: BorderSide(
                                    color: Global.focusedBlue, width: 3))),
                        child: Icon(navIcon[userLevelFilter[sc.level][i]],
                            color: Global.focusedBlue, size: 40))),
          ],
          selectedIndex: pc.pindex,
          trailing: Column(
            children: [
              _leadingwidget(sc, tc, dbc),
              //_logoutButton(sc),
            ],
          ),
        ),
      ),
    );
  }
}

getSignProfile(SharedPrefController sc, DatabaseController dbc) async {
  if (dbc.listForSign.isEmpty) {
    await dbc.loginQuery(
        name: sc.uname,
        pass: sc.password,
        query: MysqlQuery().queryList['login']);
  }
}

getLevelFilter() {}

Widget _navLogo(SharedPrefController sc, ThemeController tc) {
  return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [
          Image.asset(tc.isSavedDarkMode()
              ? "assets/images/dark/dark2.png"
              : "assets/images/light/light2.png"),
          Divider(color: tc.isColorChangeWD())
        ],
      ));
}

Widget _leadingwidget(
    SharedPrefController sc, ThemeController tc, DatabaseController dbc) {
  // ignore: unused_local_variable
  int userLevel;
  String pString, unameString;

  getSignProfile(sc, dbc);

  if (sc.isRemember) {
    if (sc.photoString.isNotEmpty) {
      pString = sc.photoString;
    } else if (dbc.listForSign.first.photo_String.isNotEmpty) {
      pString = dbc.listForSign.first.photo_String;
    } else {
      pString = 'https://img.icons8.com/dusk/64/000000/engineer.png';
    }
  } else {
    if (dbc.listForSign.first.photo_String.isNotEmpty) {
      pString = dbc.listForSign.first.photo_String;
    } else {
      pString = 'https://img.icons8.com/dusk/64/000000/engineer.png';
    }
  }

  if (sc.uname == null || sc.uname == '') {
    unameString = dbc.listForSign.first.user_Name;
    userLevel = dbc.listForSign.first.levels_id;
  } else {
    unameString = sc.uname;
    userLevel = sc.level;
  }

  return Padding(
    padding: const EdgeInsets.only(top: 35, left: 5, right: 5),
    child: Column(
      children: [
        Divider(color: tc.isColorChangeWD()),
        SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: () => Get.to(ProfilePage(
              widgetLogout: _logoutButton(sc, dbc, tc),
              pString: pString,
              unameString: unameString)),
          child: Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                  color: Global.focusedBlue, shape: BoxShape.circle),
              child: CircleAvatar(
                  backgroundColor: Global.trnsp,
                  backgroundImage: NetworkImage(pString))),
        ),
        SizedBox(
          height: 10,
        ),
        Text(unameString,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
      ],
    ),
  );
}

Widget _logoutButton(
    SharedPrefController sc, DatabaseController dbc, ThemeController tc) {
  return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
    InkWell(
        onTap: () => Get.dialog(
            ShowDialogWidget(
                title: 'Logout',
                tbtn1: 'OK',
                tbtn2: 'CANCEL',
                text1: 'Do you want to sign out of account?',
                text2: 'Account preferences will be reset!',
                onPressed: () {
                  sc.isRemember = false;
                  dbc.listForWeld.clear();
                  dbc.listForSpool.clear();
                  Get.offAllNamed('t/loginPage');
                  print('Çıkış yapıldı: ' + sc.uname);
                }),
            transitionDuration: Duration(milliseconds: 300),
            barrierDismissible: false),
        child: Icon(Icons.logout, color: Global.dark_red, size: 40)),
    Text('Logout', style: TextStyle(fontWeight: FontWeight.bold))
  ]);
}

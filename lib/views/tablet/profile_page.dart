import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onesystem/controllers/database_controller.dart';
import 'package:onesystem/controllers/dataview_controller.dart';
import 'package:onesystem/controllers/sharpref_controller.dart';
import 'package:onesystem/controllers/theme_controller.dart';
import 'package:onesystem/models/globals_model.dart';
import 'package:onesystem/views/tablet/widgets/dialog_widget.dart';
import 'package:restart_app/restart_app.dart';

class ProfilePage extends StatelessWidget {
  final Widget widgetLogout;
  final String pString, unameString;
  final List<String> prjList = [
    'Default Project',
    'ABC Project',
    '123 Project',
    'Demo Project',
  ];

  ProfilePage({Key key, this.widgetLogout, this.pString, this.unameString})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeController tc = Get.put(ThemeController());
    DatabaseController dbc = Get.put(DatabaseController());
    DataviewController dvc = Get.put(DataviewController());
    SharedPrefController sc = Get.put(SharedPrefController());
    return SafeArea(
        child: Scaffold(
            body: Obx(() => Container(
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(40, 50, 40, 10),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              flex: 7,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(child: getUserInfo(dbc, tc)),
                                    VerticalDivider(),
                                    Expanded(
                                        child: getUserSettings(
                                            tc, dvc, sc, context))
                                  ])),
                          Expanded(
                              flex: 1,
                              child: Column(children: [
                                Divider(thickness: 2),
                                widgetLogout
                              ])),
                        ]))))));
  }

  Widget getUserInfo(DatabaseController dbc, ThemeController tc) {
    return Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text('Profile Details',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      Stack(alignment: Alignment.bottomRight, children: [
        Container(
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
                color: Global.focusedBlue, shape: BoxShape.circle),
            child: CircleAvatar(
                radius: 40,
                backgroundColor: Global.trnsp,
                backgroundImage: NetworkImage(pString))),
        Positioned(
            top: 45,
            left: 45,
            child: IconButton(
                onPressed: () {
                  print('object');
                },
                icon: Container(
                  decoration: BoxDecoration(
                      color: Global.white, shape: BoxShape.circle),
                  child:
                      Icon(Icons.change_circle, color: Global.green, size: 25),
                )))
      ]),
      Container(
          width: Get.width / 3,
          child: Column(children: [
            ListTile(
                leading: Icon(Icons.person),
                title: Text('User Name',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(unameString.toUpperCase())),
            ListTile(
                leading: Icon(Icons.leaderboard),
                title: Text('User Level',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(dbc.listForSign.first.levels_id.toString())),
            ListTile(
                leading: Icon(Icons.help),
                title: Text('User Actual',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(dbc.listForSign.first.user_Actual.toString())),
            ListTile(
                leading: Icon(Icons.home_work),
                title: Text(
                  'Department',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text('Quality')),
            ListTile(
                leading: Icon(Icons.work),
                title: Text('Authorized Projects',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(prjList.map((e) => e).toString().toUpperCase(),
                    style: TextStyle(fontSize: 11)))
          ]))
    ]);
  }

  Widget getUserSettings(ThemeController tc, DataviewController dvc,
      SharedPrefController sc, BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text('Settings',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      Icon(Icons.settings, size: 90),
      Container(
          width: Get.width / 3,
          child: Column(children: [
            ListTile(
              leading: Icon(Icons.public),
              title: Text('Language',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('English'),
            ),
            ListTile(
              onTap: () {},
              leading: Icon(Icons.fingerprint),
              title: Text('Use Fingerprint',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('None'),
            ),
            ListTile(
              leading: Icon(Icons.lock_clock),
              title: Text('Change Password',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('********'),
            ),
            SwitchListTile(
                secondary: tc.darkTheme
                    ? Icon(Icons.brightness_2)
                    : Icon(Icons.wb_sunny, color: Colors.amber),
                title: Text('Change Theme',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(tc.darkTheme
                    ? 'Dark Theme Enabled'
                    : 'Light Theme Enabled'),
                value: tc.darkTheme,
                onChanged: (x) {
                  tc.changeThemeMode();
                  print('theme son durumu: ' + x.toString());
                  tc.darkTheme = !tc.darkTheme;
                }),
            GetPlatform.isAndroid
                ? ListTile(
                    leading: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                            value: dvc.choseProject,
                            //elevation: 5,
                            style: TextStyle(color: Colors.black),
                            items: prjList
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value,
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: tc.isColorChangeWD(),
                                          fontWeight: FontWeight.bold)));
                            }).toList(),
                            onChanged: (String value) {
                              //if (sc.prjName != value)
                              dvc.onSavedProject(value);
                            })),
                    trailing: dvc.choseProject == sc.prjName
                        ? Text('You are already in this project',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Global.dark_red))
                        : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Global.medium),
                            child: Text('Change Project'),
                            onPressed: () => Get.dialog(
                                ShowDialogWidget(
                                    title: 'Warning..!',
                                    tbtn1: 'OK',
                                    tbtn2: 'CANCEL',
                                    text1: 'Do you want to change the project?',
                                    text2:
                                        'All screens that are not registered during project switching will be refreshed..!',
                                    onPressed: () {
                                      //Phoenix.rebirth(context); kontrol edilecek.....
                                      sc.saveToPrefsProjectName();
                                      print('Proje değiştirildi..: ' +
                                          dvc.choseProject);
                                      Restart.restartApp();
                                    }),
                                transitionDuration: Duration(milliseconds: 300),
                                barrierDismissible: false),
                          ),
                    subtitle: Text(''))
                : Text(
                    '*Project switching is only available on android device.'),
          ]))
    ]);
  }
}

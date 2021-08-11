import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onesystem/controllers/page_controller.dart';
import 'package:onesystem/models/globals_model.dart';

// ignore: must_be_immutable
class SideLayout extends StatelessWidget {
  int _selectedIndex = 0;
  bool _extended = false;
  PagesController pc = Get.put(PagesController());

  List<IconData> icons = [
    Icons.home,
    Icons.check_circle_outline,
    Icons.menu,
    Icons.warning_rounded,
    Icons.swap_horiz,
    Icons.local_shipping,
    Icons.settings,
    Icons.logout
  ];

  List<String> titles = [
    'MainPage',
    'Approval',
    'Materials',
    'NDT',
    'Release',
    'Ship',
    'Settings',
    'LOGOUT'
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraint.maxHeight),
            child: IntrinsicHeight(
              child: NavigationRail(
                trailing: GestureDetector(
                  onTap: () {
                    _extended = !_extended;
                  },
                  child: _extended
                      ? Icon(
                          Icons.menu_open,
                          size: 30,
                          color: Global.focusedBlue,
                        )
                      : Icon(Icons.menu, size: 30),
                ),
                leading: Column(
                  children: [
                    Image.asset('assets/images/logo_min_home.png', width: 40),
                  ],
                ),
                extended: _extended,
                minExtendedWidth: 170,
                groupAlignment: -1,
                selectedIndex: _selectedIndex,
                selectedIconTheme: IconThemeData(color: Global.focusedBlue),
                selectedLabelTextStyle: TextStyle(color: Global.focusedBlue),
                onDestinationSelected: (int index) {
                  if (index != _selectedIndex) _selectedIndex = index;
                  pc.savedIndex(index);
                  print('MenuSelect: ' + _selectedIndex.toString());
                },
                labelType: NavigationRailLabelType.none,
                destinations: [
                  for (var i = 0; i < titles.length; i++)
                    NavigationRailDestination(
                        icon: Icon(icons[i]), label: Text(titles[i])),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:onesystem/controllers/sharpref_controller.dart';
import 'package:onesystem/controllers/theme_controller.dart';
import 'package:onesystem/models/navigator_model.dart';
import 'package:onesystem/models/theme_model.dart';

Future<void> main() async {
  await GetStorage.init(); //uygulama ilk acilirken pref deki bilgileri yukle
  runApp(MyApp());
}

//GetStorage Path:/data/data/com.example.onesystem/app_flutter/GetStorage.gs
class MyApp extends StatelessWidget {
  Future<void> getStorage() async {
    await GetStorage.init();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      //Ekran yonunu ayarla
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return GetMaterialApp(
      //*GetX paketini kullanmak icin
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.native,
      getPages: MyNavigator.route, //sayfalari ilgili olusturulan classtan al
      initialRoute: SharedPrefController()
          .getShared(), //Ilk sayfa belirlemek icin pref bilgilerine bak
      theme: Themes().lightTheme,
      darkTheme: Themes().darkTheme,
      themeMode: ThemeController()
          .getThemeMode(), //Tema durumunu belirlemek icin pref bilgilerine bak
    );
  }
}

class RestartWidget extends StatefulWidget {
  RestartWidget({this.child});

  final Widget child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>().restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}

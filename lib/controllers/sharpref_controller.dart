import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:onesystem/controllers/database_controller.dart';
import 'package:onesystem/controllers/login_controller.dart';
import 'package:onesystem/models/exporter_model.dart';

class SharedPrefController extends GetxController {
  DatabaseController dbc = Get.put(DatabaseController());
  LoginController _controller = Get.put(LoginController());
  DataviewController dvc = Get.put(DataviewController());

  final box = GetStorage();
  final _uname = ''.obs;
  final _password = ''.obs;
  final _isRemember = false.obs;
  final _photoString = ''.obs;
  final _level = 1.obs;
  final _prjName = ''.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    GetStorage box = GetStorage();
    _prjName.value =
        box.read('project'); //sistem direkt login olmasada proje ismini yükle
    if (box.read('login') != null) {
      await _loadFromPrefs();
      print('İlk gelen Uname: ' + box.read('name'));
      print('İlk gelen Pass: ' + _password.value);
      print('İlk gelen Photo: ' + _photoString.value.toString());
      print('İlk gelen Level: ' + _level.value.toString());
      print('İlk gelen Login: ' + _isRemember.value.toString());
      print('İlk gelen Proje: ' + _prjName.value.toString());
    }
  }

  int get level => _level.value;
  String get photoString => _photoString.value;
  bool get isRemember => _isRemember.value;
  String get uname => _uname.value;
  String get password => _password.value;
  String get prjName => _prjName.value;

  String getShared() {
    return remember()
        ? 't/homePage'
        : 't/loginPage'; // beni hatırla durumuna göre yönlendirilecek sayfa
  }

  bool remember() {
    return box.read('login') ??
        false; //beni hatırla isaretli ise bir sonraki otomatik giris icin login=true
  }

  //Login remember shared pref begin-----

  _initPrefs() async {
    await GetStorage.init();
  }

  _saveToPrefs() async {
    await _initPrefs();
    if (_controller.uname != null || _controller.password != null) {
      //textbox lari kontrol et , bilgileri kayda al
      box.write('name', _controller.uname);
      box.write('pass', _controller.password);
      box.write('login', _isRemember.value);
      // box.write('photo', dbc.lisForSign.first.photo_String);
    } //print(_isLogin.value);
  }

  saveToPrefsPhotoLevel() async {
    await _initPrefs();
    if (dbc.listForSign.isNotEmpty) {
      //kullanicinin database de bilgileri varsa , kaydet
      box.write('photo', dbc.listForSign.first.photo_String);
      box.write('level', dbc.listForSign.first.levels_id);
    }
  }

  saveToPrefsProjectName() async {
    await _initPrefs();
    box.write('project', dvc.choseProject); //proje ismini kaydet
  }

  _loadFromPrefs() async {
    //tum degiskenlere pref deki bilgileri at
    _uname.value = box.read('name');
    _password.value = box.read('pass');
    _isRemember.value = box.read('login');
    _photoString.value = box.read('photo');
    _level.value = box.read('level');
    _prjName.value = box.read('project');
    await _initPrefs();
    // print(_isLogin.value);
  }

  _deleteFromPrefs() async {
    //tum pref bilgilerini sil
    await _initPrefs();
    box.remove('name');
    box.remove('pass');
    box.remove('login');
    box.remove('photo');
    box.remove('level');
    box.remove('project');
  }

  set isRemember(bool value) {
    _isRemember.value = value;
    if (_isRemember.value) {
      //beni hatirla isaretli mi? => kaydet/sil
      _saveToPrefs();
      //print('Remember: isLogin=>' + _isLogin.toString());
    } else {
      _deleteFromPrefs();
    }
  }

//Login remember shared pref end-----
}

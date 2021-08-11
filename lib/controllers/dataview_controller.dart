import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DataviewController extends GetxController {
  final _getStorage = GetStorage();
  final radioValue = 1.obs; //Mainpage > SelectRadio Observable

  final selectedDate1 = DateTime.now().obs; //SelectDate Observable
  final selectedDate2 = DateTime.now().obs; //SelectDate Observable

  final selectedDate3 = DateTime.now().obs; //FitupEntry > SelectDate Observable
  final selectedDate4 = DateTime.now().obs; //WeldEntry > SelectDate Observable

  final dropSelectQ1 = 'Oğuz KABA'.obs; //IsoSpool Info > SelectQC Observable
  final dropSelectQ2 = 'Oğuz KABA'.obs; //IsoSpool Info > SelectQC Observable

  final dropSelectT1 = 'E-050'.obs; //FitupEntry > SelectTeam Observable
  final dropSelectT2 = 'E-050'.obs; //WeldEntry > SelectTeam Observable

  final selectHeat = true.obs; //FitupEntry > SelectHeat Observable
  final selectWelderR1 = false.obs; //WeldEntry > SelectWelder Root-1 Observable
  final selectWelderR2 = false.obs; //WeldEntry > SelectWelder Root-1 Observable
  final selectWelderC1 = false.obs; //WeldEntry > SelectWelder Cap-1 Observable
  final selectWelderC2 = false.obs; //WeldEntry > SelectWelder Cap-2 Observable

  final selectWPS = true.obs; //WeldEntry > SelectWPS Observable
  final wpsData = ''.obs; //WeldEntry > wpsData Observable

  final dragText = ''.obs; //WeldEntry > DragText Observable

  final refreshData = false.obs; //WeldEntry >ListView refresh Observable

  final checkValue = false.obs; //Entry Pages>Checkbox Observable

  final gridState = false.obs; //All Grid Line Style

  final _choseProject =
      'Default Project'.obs; //All Pages >ProjectName  Observable

  String get choseProject => _choseProject.value;
  //set choseProject(value) => _choseProject.value = value;
  void onSavedProject(String projectName) {
    _choseProject.value = projectName;
    saveProje(projectName);
  }

  void saveProje(String proje) {
    _getStorage.write('project', proje);
  }
}

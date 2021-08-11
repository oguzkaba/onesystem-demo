import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final _uname = ''.obs;
  final _password = ''.obs;
  final formKey = GlobalKey<FormState>().obs;
  final _autoValidate = false.obs;
  final _isVisible = false.obs;
  final _checkVal = false.obs;

  String get uname => _uname.value;
  String get password => _password.value;
  bool get autoValidate => _autoValidate.value;
  bool get isVisible => _isVisible.value;
  bool get checkVal => _checkVal.value;

  set autoValidate(bool value) => _autoValidate.value = value;

  set isVisible(bool value) => _isVisible.value = value;
  set checkVal(bool value) => _checkVal.value = value;

  void onSavedUname(String unameStr) => _uname.value = unameStr;

  void onSavedPassword(String passwordStr) => _password.value = passwordStr;

  String validateUname(String value) {
    if (value.length == 0) {
      return 'Please fill username';
    } else if (value.length < 6) {
      return 'Username must be 6 length character';
    } else {
      print('nullbura');
      return null;
    }
  }

  String validatePassword(String value) {
    if (value.length == 0) {
      return 'Please fill password';
    } else if (value.length < 6) {
      return 'Password must be 6 length character';
    } else {
      print('nullburada');
      return null;
    }
  }
}

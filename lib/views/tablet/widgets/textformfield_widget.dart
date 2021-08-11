import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onesystem/controllers/login_controller.dart';
import 'package:onesystem/controllers/theme_controller.dart';
import 'package:onesystem/models/globals_model.dart';

class TextFormFieldWidget extends StatelessWidget {
  final String hintText;
  final IconData prefixIconData;
  final IconData suffixIconData;
  final bool obscureText;
  final TextInputAction action;
  final Function onChanged;
  final Function validator;

  TextFormFieldWidget(
      {this.hintText,
      this.prefixIconData,
      this.suffixIconData,
      this.obscureText,
      this.onChanged,
      this.action,
      this.validator});

  @override
  Widget build(BuildContext context) {
    LoginController lc = Get.put(LoginController());
    ThemeController tc = Get.put(ThemeController());
    return TextFormField(
      //autofocus: focus,
      textInputAction: action,
      validator: validator,
      onChanged: onChanged,
      obscureText: obscureText,
      cursorColor: Global.focusedBlue,
      style: TextStyle(
        color: tc.isSavedDarkMode() ? Global.white : Global.dark_default,
        fontSize: 16.0,
      ),
      decoration: InputDecoration(
        labelStyle: TextStyle(
            color: tc.isSavedDarkMode() ? Global.white : Global.dark_default,
            fontSize: 18.0),
        focusColor: Global.focusedBlue,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: Global.extra_light, width: 1.3),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Global.focusedBlue, width: 1.3),
        ),
        labelText: hintText,
        prefixIcon: Icon(
          prefixIconData,
          size: 25,
          color: tc.isSavedDarkMode() ? Global.white : Global.dark_default,
        ),
        suffixIcon: GestureDetector(
          onTap: () {
            lc.isVisible = !lc.isVisible;
          },
          child: Icon(
            suffixIconData,
            size: 20,
            color: lc.isVisible ? Global.dark_default : Global.light,
          ),
        ),
      ),
    );
  }
}

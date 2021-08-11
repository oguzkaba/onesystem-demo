import 'dart:io';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onesystem/controllers/database_controller.dart';
import 'package:onesystem/controllers/dataview_controller.dart';
import 'package:onesystem/controllers/internet_controller.dart';
import 'package:onesystem/controllers/login_controller.dart';
import 'package:onesystem/controllers/sharpref_controller.dart';
import 'package:onesystem/controllers/theme_controller.dart';
import 'package:onesystem/models/globals_model.dart';
import 'package:onesystem/models/mysqlQuery_model.dart';
import 'package:onesystem/models/signin_model.dart';
import 'package:onesystem/views/tablet/widgets/dialog_widget.dart';
import 'package:onesystem/views/tablet/widgets/eButton_widget.dart';
import 'package:onesystem/views/tablet/widgets/textFormField_widget.dart';

// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  LoginController lc = Get.put(LoginController());
  SharedPrefController sc = Get.put(SharedPrefController());
  ThemeController tc = Get.put(ThemeController());
  NetController nc = Get.put(NetController());
  DatabaseController db = Get.put(DatabaseController());
  DataviewController dvc = Get.put(DataviewController());
  //String _chosenValue;
  List images = [
    'assets/images/intro1_crossplatform.png',
    'assets/images/intro2_qc.png',
    'assets/images/intro3_database.png',
    'assets/images/intro4_welders.png'
  ];

  @override
  Widget build(BuildContext context) {
    final bool keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    return SafeArea(
      child: Scaffold(
          backgroundColor: tc.isColorChangeDW(),
          body: Row(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: SingleChildScrollView(
                  child: Container(
                    //padding: EdgeInsets.only(left: sizeWidth * .05),
                    color: tc.isColorChangeDW(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Image.asset(
                            tc.isSavedDarkMode()
                                ? 'assets/images/dark/dark1_lowheight.png'
                                : 'assets/images/light/light1_lowheight.png',
                            height: keyboardOpen ? 0 : 50,
                          ),
                        ),
                        SizedBox(height: keyboardOpen ? 0 : Get.height * .03),
                        Obx(() => buildChangeProjectDDWidget(dvc, tc)),
                        buildFormLogin(dvc, sc, lc, tc, db, context),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: SingleChildScrollView(
                  child: Container(
                    height: Get.height,
                    color: tc.isColorChangeWD(),
                    child: Swiper(
                      scale: 0.9,
                      viewportFraction: 0.9,
                      itemCount: images.length,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          images[index],
                          fit: BoxFit.fitWidth,
                        );
                      },
                      autoplay: true,
                      autoplayDelay: 3000,
                      control: SwiperControl(color: tc.isColorChangeDW()),
                      pagination: SwiperPagination(
                        margin: EdgeInsets.only(bottom: 30),
                        builder: DotSwiperPaginationBuilder(
                            activeColor: Global.focusedBlue, activeSize: 15.0),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}

Form buildFormLogin(
    DataviewController dvc,
    SharedPrefController sc,
    LoginController lc,
    ThemeController tc,
    DatabaseController db,
    BuildContext context) {
  return Form(
    key: lc.formKey.value,
    // ignore: deprecated_member_use
    autovalidate: lc.autoValidate,
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 5.0,
          ),
          buildTextFormFieldWidgetUsername(lc),
          SizedBox(
            height: 10.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Obx(
                () => buildTextFormFieldWidgetPass(lc),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GetX<LoginController>(
                    builder: (_) => Row(
                      children: [
                        Theme(
                          data: ThemeData(
                            unselectedWidgetColor: tc.isColorChangeWD(),
                          ),
                          child: Checkbox(
                            activeColor: tc.isColorChangeWD(),
                            checkColor: tc.isColorChangeDW(),
                            value: lc.checkVal,
                            onChanged: (bool value) {
                              lc.checkVal = !lc.checkVal;
                              sc.isRemember = lc.checkVal;
                              print('Remember: Login Value: ' +
                                  sc.isRemember.toString());
                            },
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            lc.checkVal = !lc.checkVal;
                            sc.isRemember = lc.checkVal;
                            print('Remember: Login Value: ' +
                                sc.isRemember.toString());
                          },
                          child: Text(
                            'Remember Me?',
                            style: TextStyle(
                                color: tc.isColorChangeWD(),
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Forgot password?',
                      style: TextStyle(
                          color: tc.isColorChangeWD(),
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              EButtonWidget(
                tcolor: Global.white,
                width: Get.width * .3,
                height: Get.height * .06,
                color: Global.focusedBlue,
//#region LOGIN CONTROL
                onClick: () async {
                  if (!GetPlatform.isWeb) {
                    if (lc.formKey.value.currentState.validate()) {
                      List<SigninModel> access = await db.loginQuery(
                          name: lc.uname,
                          pass: lc.password,
                          query: MysqlQuery().queryList['login']);
                      print('Access: ' + db.islogin.toString());
                      print('Sign ' + lc.uname);

                      if (db.islogin) {
                        if (access[0].user_Actual == 1) {
                          lc.formKey.value.currentState.save();
                          sc.saveToPrefsPhotoLevel();
                          sc.saveToPrefsProjectName();
                          Get.offNamed('t/homePage'); //with arguments
                          print('Sign in successfully' +
                              lc.uname +
                              db.islogin.toString());
                        } else {
                          Get.snackbar('Warning..!',
                              'User is inactive, contact your administrator', //'Kullanıcı aktif değil....',
                              backgroundColor: Global.dark_red,
                              colorText: Global.light_pink);
                        }
                      } else {
                        Get.snackbar('Warning..!',
                            'No such user found in the system', //'Kayıtlı kullanıcı bulunamadı....',
                            backgroundColor: Global.dark_red,
                            colorText: Global.light_pink);
                      }
                    } else {
                      lc.autoValidate = true;
                      print('Failed to sign in ' + db.islogin.toString());
                    }
                  } else {
                    Get.snackbar('Uyarı', 'Demo mod....');
                    Get.offNamed('t/homePage');
                  }
                },
//#endregion
                title: 'Login',
              ),
              SizedBox(
                height: 5.0,
              ),
              EButtonWidget(
                width: Get.width * .3,
                height: Get.height * .06,
                color: tc.isColorChangeWD(),
                tcolor: tc.isColorChangeDW(),
                onClick: () => Get.dialog(
                  ShowDialogWidget(
                    title: 'Exit',
                    tbtn1: 'OK',
                    tbtn2: 'CANCEL',
                    text1: 'Close the application.',
                    text2: 'Would you like to approve of this message?',
                    onPressed: () => exit(0),
                  ),
                  barrierDismissible: false,
                ),
                title: 'Exit',
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget buildChangeProjectDDWidget(DataviewController dvc, ThemeController tc) {
  return Padding(
    padding: const EdgeInsets.only(top: 2),
    child: Center(
      child: Container(
        width: Get.width * .3,
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
            border: Border.all(color: tc.isColorChangeWD(), width: 1)),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            icon: Icon(Icons.line_weight),
            iconSize: 28,
            focusColor: Global.focusedBlue,
            value: dvc.choseProject,
            //elevation: 5,
            style: TextStyle(
                color: tc.isColorChangeWD(),
                fontSize: 18,
                fontWeight: FontWeight.w600),
            items: <String>[
              'Default Project',
              'ABC Project',
              '123 Project',
              'Demo Project',
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String value) {
              dvc.onSavedProject(value);
            },
          ),
        ),
      ),
    ),
  );
}

TextFormFieldWidget buildTextFormFieldWidgetUsername(LoginController lc) {
  return TextFormFieldWidget(
    action: TextInputAction.next,
    hintText: 'Username',
    obscureText: false,
    prefixIconData: Icons.person,
    //suffixIconData: model.isValid ? Icons.check : null,
    validator: lc.validateUname,
    onChanged: (value) => lc.onSavedUname(value),
  );
}

TextFormFieldWidget buildTextFormFieldWidgetPass(LoginController lc) {
  return TextFormFieldWidget(
    action: TextInputAction.send,
    hintText: 'Password',
    obscureText: lc.isVisible ? false : true,
    prefixIconData: Icons.lock,
    suffixIconData: lc.isVisible ? Icons.visibility : Icons.visibility_off,
    validator: lc.validatePassword,
    onChanged: (value) => lc.onSavedPassword(value),
  );
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore: unused_import
import 'package:mysql1/mysql1.dart';
import 'package:onesystem/models/mysqlConn_model.dart';
import 'package:onesystem/models/signin_model.dart';

class DatabaseController extends GetxController {
  //OBS GetStateManagement variables
  final _result = 0.obs;
  int get sonuc => _result.value;
  final _islogin = false.obs;
  bool get islogin => _islogin.value;
  final List<SigninModel> _listForSign = <SigninModel>[].obs;
  List<SigninModel> get listForSign => _listForSign;
  List<dynamic> _listForSpool = <dynamic>[].obs;
  List<dynamic> get listForSpool => _listForSpool;
  final List<dynamic> _listForWeld = <dynamic>[].obs;
  List<dynamic> get listForWeld => _listForWeld;
  final List<dynamic> _listForWeldCopy = <dynamic>[].obs;
  List<dynamic> get listForWeldCopy => _listForWeldCopy;
  final List<dynamic> _listForWeldCopy1 = <dynamic>[].obs;
  List<dynamic> get listForWeldCopy1 => _listForWeldCopy1;
  final List<dynamic> _listForFile = <dynamic>[].obs;
  List<dynamic> get listForFile => _listForFile;
  final List<dynamic> _listForFileSpool = <dynamic>[].obs;
  List<dynamic> get listForFileSpool => _listForFileSpool;
  final List<dynamic> _listForFields = <dynamic>[].obs;
  List<dynamic> get listForFields => _listForFields;
  final List<dynamic> _listForNote = <dynamic>[].obs;
  List<dynamic> get listForNote => _listForNote;
  final List<dynamic> _listForNoteByUser = <dynamic>[].obs;
  List<dynamic> get listForNoteByUser => _listForNoteByUser;

//#region DATABASE-LOGIN KONTROL METHOD
  Future<List<SigninModel>> loginQuery(
      {@required String name,
      @required String pass,
      @required String query}) async {
    try {
      print('bağlanmayı deniyorum...');
      var connect = await MysqlConn().getConnection();

//#region SORGU OLUSTUR
      var result = await connect.query(query, [name, pass]);
//#endregion

      _listForSign.clear();

//#region SONUC BOSMU KONTROL
      if (result.isNotEmpty) {
//#region SONUCU LISTEYE AKTAR
        for (var item in result) {
          _listForSign.add(
            SigninModel(item[0], item[1], item[2], item[6], item[3], item[4]),
          );
        }
//#endregion
        _islogin.value = true;
      } else {
        _islogin.value = false;
      }
//#endregion

      await connect.close();
      return listForSign;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
//#endregion

//#region DATABASE-GETSpool KONTROL METHOD
  Future<List<dynamic>> getSpool(
      {@required String fno, @required String query}) async {
    try {
      var connect = await MysqlConn().getConnection();

//#region SORGU OLUSTUR
      var result = await connect.query(query, [fno]);
//#endregion

      _listForSpool.clear();

      _result.value = result.length;

//#region KOLON ISIMLERINI AL
      List<dynamic> getfields() {
        _listForFields.clear();

        for (int z = 0; z < 23; z++) {
          _listForFields.add(result.fields[z].name);
        }
        return listForFields;
      }

//#endregion
      getfields();
      result.forEach((v) => _listForSpool.add(v));

      // // print('Fields : ' + listForFields.length.toString());
      // // print('Dataop daki listemiz2 : ' + listem2.length.toString());
      await connect.close();
      return listForSpool;
    } catch (e) {
      return null;
    }
  }
//#endregion

//#region DATABASE-GETWeld KONTROL METHOD
  Future<List<dynamic>> getWeld(
      {@required String fno,
      @required String sno,
      @required String query}) async {
    try {
      var connect = await MysqlConn().getConnection();

//#region SORGU OLUSTUR
      var result = await connect.query(query, [fno, sno]);
//#endregion

      _listForWeld.clear();

      _result.value = result.length;

//#region KOLON ISIMLERINI AL
      List<dynamic> getfields() {
        _listForFields.clear();

        for (int z = 0; z < 38; z++) {
          _listForFields.add(result.fields[z].name);
        }
        return listForFields;
      }
//#endregion

      getfields();
      result.forEach((v) => _listForWeld.add(v));
      await connect.close();
      return listForWeld;
    } catch (e) {
      return null;
    }
  }
//#endregion

//#region DATABASE-GETUserNote KONTROL METHOD
  Future<List<dynamic>> getUserNote(
      {@required String fsno, @required String query}) async {
    try {
      var connect = await MysqlConn().getConnection();

//#region SORGU OLUSTUR
      var result = await connect.query(query, [fsno]);
//#endregion

      _listForNote.clear();

      _result.value = result.length;

      result.forEach((v) => _listForNote.add(v));
      await connect.close();
      return listForNote;
    } catch (e) {
      return null;
    }
  }
//#endregion

//#region DATABASE-GETWeldCopy-Copy1 KONTROL METHOD
  Future<List<dynamic>> getWeldCopy(
      {@required String fno,
      @required String selectWF,
      @required String sno,
      @required String query}) async {
    try {
      var connect = await MysqlConn().getConnection();

//#region SORGU OLUSTUR
      var result = await connect.query(query, [fno, sno]);
//#endregion

      _result.value = result.length;

//#region KOLON ISIMLERINI AL
      List<dynamic> getfields() {
        _listForFields.clear();

        for (int z = 0; z < 38; z++) {
          _listForFields.add(result.fields[z].name);
        }
        return listForFields;
      }
//#endregion

      getfields();

      if (selectWF == 'weld') {
        _listForWeldCopy.clear();
        result.forEach((v) => _listForWeldCopy.add(v));
        await connect.close();
        return listForWeldCopy;
      } else {
        _listForWeldCopy1.clear();
        result.forEach((v) => _listForWeldCopy1.add(v));
        await connect.close();
        return listForWeldCopy1;
      }
    } catch (e) {
      return null;
    }
  }
//#endregion

//#region DATABASE-GETFileNO KONTROL METHOD
  Future<List<dynamic>> getFileNO({@required String query}) async {
    try {
      var connect = await MysqlConn().getConnection();

//#region SORGU OLUSTUR
      var result = await connect.query(query);
//#endregion

      _listForFile.clear();

      _result.value = result.length;

      result.forEach((v) => _listForFile.add(v[1].toString()));
      await connect.close();
      return listForFile;
    } catch (e) {
      return null;
    }
  }
//#endregion

//#region DATABASE-GETFileNOandSpool KONTROL METHOD
  Future<List<dynamic>> getFileNoSpool({@required String query}) async {
    try {
      var connect = await MysqlConn().getConnection();

//#region SORGU OLUSTUR
      var result = await connect.query(query, ['Fabrication']);
//#endregion

      _listForFileSpool.clear();

      _result.value = result.length;

      result.forEach((v) => _listForFileSpool.add(v));
      await connect.close();
      return listForFileSpool;
    } catch (e) {
      return null;
    }
  }
//#endregion

//#region DATABASE-GETUserNote KONTROL METHOD
  Future<List<dynamic>> getNoteByUser(
      {@required String id, @required String query}) async {
    try {
      var connect = await MysqlConn().getConnection();

//#region SORGU OLUSTUR
      var result = await connect.query(query, [id]);
//#endregion

      _listForNoteByUser.clear();

      _result.value = result.length;

      result.forEach((v) => _listForNoteByUser.add(v));
      await connect.close();
      return listForNoteByUser;
    } catch (e) {
      return null;
    }
  }
//#endregion

//#region DATABASE-ADDUserNote KONTROL METHOD
  Future<List<dynamic>> addNoteUser(
      {@required String note,
      @required visibility,
      @required active,
      @required uid,
      @required String fsno,
      @required String query}) async {
    try {
      var connect = await MysqlConn().getConnection();

//#region SORGU OLUSTUR
      await connect.query(query, [note, visibility, active, uid, fsno]);
//#endregion

      await connect.close();
      return listForNoteByUser;
    } catch (e) {
      return null;
    }
  }
//#endregion

// SELECT `COLUMN_NAME`
// FROM `INFORMATION_SCHEMA`.`COLUMNS`
// WHERE `TABLE_SCHEMA`='yourdatabasename'
//     AND `TABLE_NAME`='yourtablename';
  // Future<bool> veriEkle(
  //     {@required String name, String password, String role}) async {
  //   try {
  //     final baglan = await MySqlConnection.connect(
  //       ConnectionSettings(
  //           host: _host,
  //           port: _port,
  //           user: _user,
  //           password: _password,
  //           db: _db),
  //     );
  //     // ekleme kodları sonra eklerse true döndür

  //     await baglan.query(
  //         "insert into $_db.$_tablename (name,password,role) values (?,?,?)",
  //         [name, password, role]);
  //     await baglan.close();
  //     return true;
  //   } catch (e) {
  //     return false;
  //   }
  // }

  // Future<bool> veriGuncelle(
  //     {@required int id, String ders, String ogretmen, String donem}) async {
  //   try {
  //     final baglan = await MySqlConnection.connect(
  //       ConnectionSettings(
  //           host: _host,
  //           port: _port,
  //           user: _user,
  //           password: _password,
  //           db: _db),
  //     );
  //     // güncelledikte  sonra  true döndür

  //     await baglan.query(
  //         "update deneme.dersler set ders=? , ogretmen=? , donem = ? where id = ?",
  //         [ders, ogretmen, donem, id]);
  //     await baglan.close();
  //     return true;
  //   } catch (e) {
  //     return false;
  //   }
  // }

  // Future<bool> veriSil({@required int id}) async {
  //   try {
  //     final baglan = await MySqlConnection.connect(
  //       ConnectionSettings(
  //           host: _host,
  //           port: _port,
  //           user: _user,
  //           password: _password,
  //           db: _db),
  //     );
  //     // sildikten sonra  true döndür

  //     await baglan.query('delete from deneme.dersler where id=?', [id]);
  //     await baglan.close();
  //     return true;
  //   } catch (e) {
  //     return false;
  //   }
  // }

}

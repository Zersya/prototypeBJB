import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:prototype_bjb/screens/dataktpnpwp_screen.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

final String tableProfile = 'profile';
final String columnId = '_id';
final String columnNama = 'nama';
final String columnAlamat = 'alamat';
final String columnNIK = 'nik';
final String columnNPWP = 'npwp';
final String columnImgtKtp = 'imgktp';
final String columnImgNpwp = 'imgnpwp';

class Profile {
  final String nama;
  final String alamat;
  final String nik;
  final String npwp;
  String imgktp;
  String imgnpwp;

  Profile(
      this.nama, this.alamat, this.nik, this.npwp, this.imgktp, this.imgnpwp);

  set imageKtp(String base64) {
    imgktp = base64;
  }

  set imageNpwp(String base64) {
    imgnpwp = base64;
  }

  Map<String, dynamic> toMap() => {
        'nama': this.nama,
        'alamat': this.alamat,
        'nik': this.nik,
        'npwp': this.npwp,
        'imgnpwp': this.imgnpwp,
        'imgktp': this.imgktp
      };

  factory Profile.fromMap(Map _map) => Profile(_map['nama'], _map['alamat'],
      _map['nik'], _map['npwp'], _map['imgktp'], _map['imgnpwp']);
}

class ProfileProvider {
  Database db;

  Profile profile;

  final controllerNama = TextEditingController();
  final controllerAlamat = TextEditingController();
  final controllerNIK = TextEditingController();
  final controllerNPWP = TextEditingController();
  String imageKtp;
  String imageNpwp;

  void decodeImage(File _image, TypeImage _type) async {
    List<int> imageBytes = await _image.readAsBytes();
    String base64Image = base64Encode(imageBytes);
    if (_type == TypeImage.ktp)
      imageKtp = base64Image;
    else if (_type == TypeImage.npwp) imageNpwp = base64Image;
  }

  Future open() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    String path = join(documentsDirectory.path, "PrototypeBJB_DB.db");

    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
        create table $tableProfile ( 
          $columnId integer primary key autoincrement, 
          $columnNama text,
          $columnAlamat text,
          $columnNIK text,
          $columnNPWP text,
          $columnImgNpwp text,
          $columnImgtKtp text)''');
    });
  }

  Future<Profile> insert() async {
    profile = Profile(controllerNama.text, controllerAlamat.text,
        controllerNIK.text, controllerNPWP.text, imageKtp, imageNpwp);

    int id = await db.insert(tableProfile, profile.toMap());
    print(id);
    profile = profile;
    return profile;
  }

  Future<Profile> getAccount() async {
    List<Map> maps = await db.query(
      tableProfile,
      columns: [
        columnId,
        columnNama,
        columnAlamat,
        columnNIK,
        columnNPWP,
        columnImgNpwp,
        columnImgtKtp
      ],
    );
    if (maps.length > 0) {
      profile = Profile.fromMap(maps.first);

      return profile;
    }
    return null;
  }
}

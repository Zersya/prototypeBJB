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
final String columnNamaIbu = 'nama_ibu';
final String columnAlamatDomisil = 'alamat_domisil';
final String columnTelepon = 'telepon';

final String columnImgtKtp = 'imgktp';
final String columnImgNpwp = 'imgnpwp';

class Profile {
  final String nama;
  final String alamat;
  final String nik;
  final String npwp;
  final String namaIbu;
  final String alamatDomisil;
  final String telepon;

  String imgktp;
  String imgnpwp;

  Profile(this.nama, this.alamat, this.nik, this.npwp, this.imgktp,
      this.imgnpwp, this.namaIbu, this.alamatDomisil, this.telepon);

  set imageKtp(String base64) {
    imgktp = base64;
  }

  set imageNpwp(String base64) {
    imgnpwp = base64;
  }

  Map<String, dynamic> toMap() => {
        columnNama: this.nama,
        columnAlamat: this.alamat,
        columnNIK: this.nik,
        columnNPWP: this.npwp,
        columnNamaIbu: this.namaIbu,
        columnAlamatDomisil: this.alamatDomisil,
        columnTelepon: this.telepon,
        columnImgNpwp: this.imgnpwp,
        columnImgtKtp: this.imgktp,
      };

  factory Profile.fromMap(Map _map) => Profile(
      _map[columnNama],
      _map[columnAlamat],
      _map[columnNIK],
      _map[columnNPWP],
      _map[columnImgtKtp],
      _map[columnImgNpwp],
      _map[columnNamaIbu],
      _map[columnAlamatDomisil],
      _map[columnTelepon]);
}

class ProfileProvider {
  Database db;

  Profile profile;

  final controllerNama = TextEditingController();
  final controllerAlamat = TextEditingController();
  final controllerNIK = TextEditingController();
  final controllerNPWP = TextEditingController();
  final controllerIbuKandung = TextEditingController();
  final controllerAlamatDomisil = TextEditingController();
  final controllerTelepon = TextEditingController();

  File _imageKTP;
  File get imageKtp => _imageKTP;
  set setImageKtp(File image) {
    _imageKTP = image;
  }

  File _imageNPWP;
  File get imageNpwp => _imageNPWP;
  set setImageNpwp(File image) {
    _imageNPWP = image;
  }

  String imageKtpStr;
  String imageNpwpStr;

  void setController() {
    controllerNama.text = profile?.nama ?? '';
    controllerAlamat.text = profile?.alamat ?? '';
    controllerNIK.text = profile?.nik ?? '';
    controllerNPWP.text = profile?.npwp ?? '';
    controllerTelepon.text = profile?.telepon ?? '';
    controllerIbuKandung.text = profile?.namaIbu ?? '';
    controllerAlamatDomisil.text = profile?.alamatDomisil ?? '';
    imageKtpStr = profile.imgktp;
    imageNpwpStr = profile.imgnpwp;

  }

  Future<String> encodeImage(File _image, TypeImage _type) async {
    List<int> imageBytes = await _image.readAsBytes();
    String base64Image = base64Encode(imageBytes);
    if (_type == TypeImage.ktp)
      imageKtpStr = base64Image;
    else if (_type == TypeImage.npwp) imageNpwpStr = base64Image;
    return base64Image;
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
          $columnNamaIbu text,
          $columnAlamatDomisil text,
          $columnTelepon text,
          $columnImgNpwp text,
          $columnImgtKtp text)''');
    });
  }

  Future<Profile> insert() async {
    if (_imageNPWP != null) await encodeImage(_imageNPWP, TypeImage.npwp);

    if (_imageKTP != null) await encodeImage(_imageKTP, TypeImage.ktp);

    profile = Profile(
        controllerNama.text,
        controllerAlamat.text,
        controllerNIK.text,
        controllerNPWP.text,
        imageKtpStr,
        imageNpwpStr,
        controllerIbuKandung.text,
        controllerAlamatDomisil.text,
        controllerTelepon.text);

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
        columnTelepon,
        columnNamaIbu,
        columnAlamatDomisil,
        columnImgNpwp,
        columnImgtKtp
      ],
    );
    if (maps.length > 0) {
      profile = Profile.fromMap(maps.last);

      return profile;
    }
    return null;
  }
}

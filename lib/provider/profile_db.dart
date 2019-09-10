import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:path_provider/path_provider.dart';
import 'package:prototype_bjb/screens/dataktpnpwp_screen.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

import 'pengajuan_db.dart';

final String tableProfile = 'profile';
final String columnId = '_id';
final String columnNama = 'nama';
final String columnAlamat = 'alamat';
final String columnNIK = 'nik';
final String columnNPWP = 'npwp';
final String columnNamaIbu = 'nama_ibu';
final String columnAlamatDomisil = 'alamat_domisil';
final String columnTelepon = 'telepon';
final String columnPekerjaan = 'pekerjaan';
final String columnNIP = 'nip';
final String columnNamaInstansi = 'nama_instansi';
final String columnalamatKantor = 'alamat_kantor';
final String columnTeleponKantor = 'telepon_kantor';
final String columnPenghasilanBersih = 'penghasilan_bersih';
final String columnTunjangan = 'tunjangan';
final String columnnNoRekTabungan = 'no_rek_tabungan';
final String columnNoRekKredit = 'no_rek_kredit';

final String columnImgtKtp = 'imgktp';
final String columnImgNpwp = 'imgnpwp';

class Profile {
  final int id;
  final String nama;
  final String alamat;
  final String nik;
  final String npwp;
  final String namaIbu;
  final String alamatDomisil;
  final String telepon;
  final String pekerjaan;
  final String nip;
  final String namaInstansi;
  final String alamatKantor;
  final String teleponKantor;
  final String penghasilanBersih;
  final String tunjangan;
  final String noRekTabungan;
  final String noRekKredit;

  String imgktp;
  String imgnpwp;

  Profile({
    this.id,
    this.nama,
    this.alamat,
    this.nik,
    this.npwp,
    this.imgktp,
    this.imgnpwp,
    this.namaIbu,
    this.alamatDomisil,
    this.telepon,
    this.pekerjaan,
    this.nip,
    this.namaInstansi,
    this.alamatKantor,
    this.teleponKantor,
    this.penghasilanBersih,
    this.tunjangan,
    this.noRekTabungan,
    this.noRekKredit,
  });

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
        columnTeleponKantor: this.teleponKantor,
        columnPekerjaan: this.pekerjaan,
        columnNIP: this.nip,
        columnNamaInstansi: this.namaInstansi,
        columnalamatKantor: this.alamatKantor,
        columnTunjangan: this.tunjangan,
        columnPenghasilanBersih: this.penghasilanBersih,
        columnNoRekKredit: this.noRekKredit,
        columnnNoRekTabungan: this.noRekTabungan
      };

  factory Profile.fromMap(Map _map) => Profile(
      id: _map[columnId],
      nama: _map[columnNama],
      alamat: _map[columnAlamat],
      nik: _map[columnNIK],
      npwp: _map[columnNPWP],
      imgktp: _map[columnImgtKtp],
      imgnpwp: _map[columnImgNpwp],
      namaIbu: _map[columnNamaIbu],
      alamatDomisil: _map[columnAlamatDomisil],
      telepon: _map[columnTelepon],
      alamatKantor: _map[columnalamatKantor],
      namaInstansi: _map[columnNamaInstansi],
      nip: _map[columnNIP],
      pekerjaan: _map[columnPekerjaan],
      teleponKantor: _map[columnTeleponKantor],
      penghasilanBersih: _map[columnPenghasilanBersih],
      tunjangan: _map[columnTunjangan],
      noRekKredit: _map[columnNoRekKredit],
      noRekTabungan: _map[columnnNoRekTabungan]);
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

  final controllerPekerjaan = TextEditingController();
  final controllerNIP = TextEditingController();
  final controllerNamaInstansi = TextEditingController();
  final controllerAlamatKantor = TextEditingController();
  final controllerTeleponKantor = TextEditingController();

  final controllerNoRekTabungan = TextEditingController();
  final controllerNoRekKredit =
      new MaskedTextController(mask: '000-0000000000');

  final controllerPenghasilan = new MoneyMaskedTextController(
      leftSymbol: 'IDR ',
      thousandSeparator: '.',
      precision: 0,
      decimalSeparator: '');
  final controllerTunjangan = new MoneyMaskedTextController(
      leftSymbol: 'IDR ',
      thousandSeparator: '.',
      precision: 0,
      decimalSeparator: '');

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

  bool _isTermsAgree = false;
  bool get isTermsAgree => _isTermsAgree;
  set setIsTermAgree(bool val) {
    _isTermsAgree = val;
  }

  String imageKtpStr;
  String imageNpwpStr;

  void setController() {
    controllerNama.text = profile?.nama ?? '';
    controllerAlamat.text = profile?.alamat ?? '';
    controllerNIK.text = profile?.nik ?? '123';
    controllerNPWP.text = profile?.npwp ?? '123';
    controllerTelepon.text = profile?.telepon ?? '';
    controllerIbuKandung.text = profile?.namaIbu ?? '';
    controllerAlamatDomisil.text = profile?.alamatDomisil ?? '';
    controllerAlamatKantor.text = profile?.alamatKantor ?? '';
    controllerNamaInstansi.text = profile?.namaInstansi ?? '';
    controllerNIP.text = profile?.nip ?? '';
    controllerPekerjaan.text = profile?.pekerjaan ?? '';
    controllerTeleponKantor.text = profile?.teleponKantor ?? '';
    controllerTunjangan.text = profile?.tunjangan ?? '0';
    controllerPenghasilan.text = profile?.penghasilanBersih ?? '0';
    controllerNoRekKredit.text = profile?.noRekKredit ?? '';
    controllerNoRekTabungan.text = profile?.noRekTabungan ?? '';

    imageKtpStr = profile?.imgktp ?? null;
    imageNpwpStr = profile?.imgnpwp ?? null;
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
          $columnalamatKantor text,
          $columnNamaInstansi text,
          $columnNIP text,
          $columnPekerjaan text,
          $columnTeleponKantor text,
          $columnPenghasilanBersih text,
          $columnTunjangan text,
          $columnnNoRekTabungan text,
          $columnNoRekKredit text,
          $columnImgNpwp text,
          $columnImgtKtp text)''');

      await db.execute('''
      create table $tablePengajuan ( 
          $columnIdPengajuan integer primary key autoincrement, 
          $columnNikProfile text,
          $columnStatusPengajuan text,
          $columnWaktuDiajukan text,
          $columnTujuanPinjaman text,
          $columnNominalPinjaman text,
          $columnProductPinjaman text,
          $columnImgRekeningKoran text)
        ''');
    });
  }

  Future<Profile> insert() async {
    if (_imageNPWP != null) await encodeImage(_imageNPWP, TypeImage.npwp);

    if (_imageKTP != null) await encodeImage(_imageKTP, TypeImage.ktp);

    profile = Profile(
        nama: controllerNama.text,
        alamat: controllerAlamat.text,
        nik: controllerNIK.text,
        npwp: controllerNPWP.text,
        imgktp: imageKtpStr,
        imgnpwp: imageNpwpStr,
        namaIbu: controllerIbuKandung.text,
        alamatDomisil: controllerAlamatDomisil.text,
        telepon: controllerTelepon.text,
        alamatKantor: controllerAlamatKantor.text,
        namaInstansi: controllerNamaInstansi.text,
        nip: controllerNIP.text,
        pekerjaan: controllerPekerjaan.text,
        teleponKantor: controllerTeleponKantor.text,
        tunjangan: controllerTunjangan.text,
        penghasilanBersih: controllerPenghasilan.text,
        noRekTabungan: controllerNoRekTabungan.text,
        noRekKredit: controllerNoRekKredit.text);

    int id = await db.insert(tableProfile, profile.toMap());
    print(id);
    return profile;
  }

  Future<Profile> update(_id) async {
    if (_imageNPWP != null) await encodeImage(_imageNPWP, TypeImage.npwp);

    if (_imageKTP != null) await encodeImage(_imageKTP, TypeImage.ktp);

    profile = Profile(
        nama: controllerNama.text,
        alamat: controllerAlamat.text,
        nik: controllerNIK.text,
        npwp: controllerNPWP.text,
        imgktp: imageKtpStr,
        imgnpwp: imageNpwpStr,
        namaIbu: controllerIbuKandung.text,
        alamatDomisil: controllerAlamatDomisil.text,
        telepon: controllerTelepon.text,
        alamatKantor: controllerAlamatKantor.text,
        namaInstansi: controllerNamaInstansi.text,
        nip: controllerNIP.text,
        pekerjaan: controllerPekerjaan.text,
        teleponKantor: controllerTeleponKantor.text,
        tunjangan: controllerTunjangan.text,
        penghasilanBersih: controllerPenghasilan.text,
        noRekTabungan: controllerNoRekTabungan.text,
        noRekKredit: controllerNoRekKredit.text);

    int id = await db.update(tableProfile, profile.toMap(),
        where: '$columnId = ?', whereArgs: [_id]);
    print(id);
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
        columnalamatKantor,
        columnNIP,
        columnPekerjaan,
        columnTeleponKantor,
        columnNamaInstansi,
        columnTunjangan,
        columnPenghasilanBersih,
        columnNoRekKredit,
        columnnNoRekTabungan,
        columnImgNpwp,
        columnImgtKtp
      ],
    );
    if (maps.length > 0) {
      profile = Profile.fromMap(maps.last);
      print(profile.id);
      return profile;
    }
    return null;
  }
}

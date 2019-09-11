import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/widgets.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'profile_db.dart';

final String tablePengajuan = 'pengajuan';
final String columnNikProfile = 'nik_profile';
final String columnIdPengajuan = 'pengajuan_id';
final String columnStatusPengajuan = 'status_pengajuan';
final String columnWaktuDiajukan = 'waktu_pengajuan';
final String columnTujuanPinjaman = 'tujuan_pinjaman';
final String columnNominalPinjaman = 'nominal_pinjaman';
final String columnProductPinjaman = 'product_pinjaman';
final String columnImgRekeningKoran = 'img_rek_koran';

class Pengajuan {
  final String nikProfile;
  final int idPengajuan;
  final String tujuanPinjaman;
  final String nominalPinjaman;
  final String statusPengajuan;
  final String waktuDiajukan;
  final String product;
  final String imgRekeningKoran;

  Pengajuan(
    this.nikProfile,
    this.statusPengajuan,
    this.waktuDiajukan,
    this.tujuanPinjaman,
    this.nominalPinjaman,
    this.imgRekeningKoran,
    this.product, {
    this.idPengajuan,
  });

  Map<String, dynamic> toMap() => {
        columnNikProfile: this.nikProfile,
        columnStatusPengajuan: this.statusPengajuan,
        columnWaktuDiajukan: this.waktuDiajukan,
        columnTujuanPinjaman: this.tujuanPinjaman,
        columnNominalPinjaman: this.nominalPinjaman,
        columnProductPinjaman: this.product,
        columnImgRekeningKoran: this.imgRekeningKoran
      };

  factory Pengajuan.fromMap(Map _map) => Pengajuan(
        _map[columnNikProfile],
        _map[columnStatusPengajuan],
        _map[columnWaktuDiajukan],
        _map[columnTujuanPinjaman],
        _map[columnNominalPinjaman],
        _map[columnImgRekeningKoran],
        _map[columnProductPinjaman],
        idPengajuan: _map[columnIdPengajuan],
      );
}

class PengajuanProvider {
  Database db;
  Pengajuan pengajuan;
  List<Pengajuan> _listPengajuan;

  bool isTermsAgree = false;

  String productSelected;
  final controllerNominal = new MoneyMaskedTextController(
      leftSymbol: 'IDR ',
      thousandSeparator: '.',
      precision: 0,
      decimalSeparator: '');

  final controllerBulan = TextEditingController();
  File image;



  Future open() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    String path = join(documentsDirectory.path, "PrototypeBJB_DB.db");

    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
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

  String pickStatus(int rand) {
    if (rand == 0) return 'Pengajuan dibuat';
    if (rand == 1) return 'Pengajuan direview';
    if (rand == 2) return 'Pengajuan dalam proses vertfikasi';
    if (rand == 3) return 'Pengajuan berhasil';

    return 'Pengajuan Ditolak';
  }

  Future<Pengajuan> insert(
    Profile _profile,
    String tujuanPinjaman,
    String nominalPinjaman,
  ) async {
    String _image = await encodeImage(image);
    pengajuan = Pengajuan(
        _profile.nik,
        pickStatus(Random().nextInt(5)),
        DateTime.now().millisecondsSinceEpoch.toString(),
        tujuanPinjaman,
        nominalPinjaman,
        _image,
        productSelected);

    int id = await db.insert(tablePengajuan, pengajuan.toMap());
    print(id);
    return pengajuan;
  }

  Future<String> encodeImage(File _image) async {
    List<int> imageBytes = await _image.readAsBytes();
    String base64Image = base64Encode(imageBytes);

    return base64Image;
  }

  Future<List<Pengajuan>> getPengajuan() async {
    List<Map> maps = await db.query(
      tablePengajuan,
    );
    if (maps.length > 0) {
      _listPengajuan = maps.map((val) => Pengajuan.fromMap(val)).toList();

      return _listPengajuan;
    }
    return List();
  }
}

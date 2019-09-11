import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/widgets.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'profile_db.dart';

final String tablePinjaman = 'pinjaman';
final String columnNikProfile = 'nik_profile';
final String columnIdPinjaman = 'pinjaman_id';
final String columnJenisPinjaman = 'jenis_pinjaman';
final String columnJenisPeminjam = 'jenis_peminjam';
final String columnTujuanPinjam = 'tujuan_pinjam';
final String columnPengajuanPinjaman = 'pengajuan_pinjaman';
final String columnWaktuPengajuanPinjaman = 'waktu_pengajuan_pinjaman';
final String columnStatusPinjaman = 'status_pinjaman';
final String columnNominalPinjaman = 'nominal_pinjaman';
final String columnBulanPinjaman = 'bulan_pinjaman';
final String columnImgRekeningKoran = 'img_rekening_koran';
final String columnImgSuratKeterangan = 'img_surat_keterangan';
final String columnImgSuratIzinUsaha = 'img_surat_izin_usaha';

class Pinjaman {
  final String nikProfile;
  final int idPinjaman;
  final String jenisPinjaman;
  final String jenisPeminjam;
  final String tujuanPinjaman;
  final String pengajuanPinjaman;
  final String imgRekeningKoran;
  final String imgSuratKeterangan;
  final String imgSuratIzinUsaha;
  final String waktuDiajukan;
  final String statusPinjaman;
  final String nominalPinjaman;
  final String bulanPinjaman;

  Pinjaman({
    this.nikProfile,
    this.jenisPeminjam,
    this.jenisPinjaman,
    this.tujuanPinjaman,
    this.pengajuanPinjaman,
    this.imgRekeningKoran,
    this.imgSuratKeterangan,
    this.imgSuratIzinUsaha,
    this.waktuDiajukan,
    this.nominalPinjaman,
    this.bulanPinjaman,
    this.statusPinjaman,
    this.idPinjaman,
  });

  Map<String, dynamic> toMap() => {
        columnNikProfile: this.nikProfile,
        columnJenisPeminjam: this.jenisPeminjam,
        columnJenisPinjaman: this.jenisPinjaman,
        columnTujuanPinjam: this.tujuanPinjaman,
        columnPengajuanPinjaman: this.pengajuanPinjaman,
        columnStatusPinjaman: this.statusPinjaman,
        columnNominalPinjaman: this.nominalPinjaman,
        columnBulanPinjaman: this.bulanPinjaman,
        columnWaktuPengajuanPinjaman: this.waktuDiajukan,
        columnImgSuratKeterangan: this.imgSuratKeterangan,
        columnImgSuratIzinUsaha: this.imgSuratIzinUsaha,
        columnImgRekeningKoran: this.imgRekeningKoran
      };

  factory Pinjaman.fromMap(Map _map) => Pinjaman(
        nikProfile: _map[columnNikProfile],
        jenisPeminjam: _map[columnJenisPeminjam],
        jenisPinjaman: _map[columnJenisPinjaman],
        tujuanPinjaman: _map[columnTujuanPinjam],
        pengajuanPinjaman: _map[columnPengajuanPinjaman],
        statusPinjaman: _map[columnStatusPinjaman],
        waktuDiajukan: _map[columnWaktuPengajuanPinjaman],
        bulanPinjaman: _map[columnBulanPinjaman],
        nominalPinjaman: _map[columnNominalPinjaman],
        imgRekeningKoran: _map[columnImgRekeningKoran],
        imgSuratKeterangan: _map[columnImgSuratKeterangan],
        imgSuratIzinUsaha: _map[columnImgSuratIzinUsaha],
        idPinjaman: _map[columnIdPinjaman],
      );
}

class PinjamanProvider {
  Database db;
  Pinjaman pinjaman;
  List<Pinjaman> _listPinjaman;

  bool isTermsAgree = false;


  String jenisPinjaman;
  String jenisPeminjam;
  String tujuanPinjaman;
  String pengajuanPinjaman;
  File rekeningKoran;
  File suratKeterangan;
  File suratIzinUsaha;

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
      create table $tablePinjaman ( 
          $columnIdPinjaman integer primary key autoincrement, 
          $columnNikProfile text,
          $columnJenisPeminjam text,
          $columnJenisPinjaman text,
          $columnTujuanPinjam text,
          $columnPengajuanPinjaman text,
          $columnStatusPinjaman text,
          $columnWaktuPengajuanPinjaman text,
          $columnNominalPinjaman text,
          $columnBulanPinjaman text,
          $columnImgSuratIzinUsaha text,
          $columnImgRekeningKoran text,
          $columnImgSuratKeterangan text)
        ''');
    });

    return true;
  }

  String pickStatus(int rand) {
    if (rand == 0) return 'Pengajuan';
    else if (rand == 1) return 'Vertifikasi Data';
    else if (rand == 2) return 'Tinjauan';
    else if (rand == 3) return 'Survey';
    else if (rand == 4) return 'Akad';
    else if (rand == 5) return 'Pencairan';


    return 'Pinjaman Ditolak';
  }

  Future<Pinjaman> insert(
      Profile _profile,
      String jenisPinjaman,
      String jenisPeminjam,
      String tujuanPeminjam,
      String pengajuanPinjaman,
      File rekeningKoran,
      File suratKeterangan,
      File suratIzinUsaha) async {
    String _imageRekKoran = await encodeImage(rekeningKoran);
    String _imageSuratKeterangan = await encodeImage(suratKeterangan);
    String _imageSuratIzinUsaha = await encodeImage(suratIzinUsaha);

    pinjaman = Pinjaman(
        imgRekeningKoran: _imageRekKoran,
        imgSuratIzinUsaha: _imageSuratIzinUsaha,
        imgSuratKeterangan: _imageSuratKeterangan,
        jenisPeminjam: jenisPeminjam,
        jenisPinjaman: jenisPinjaman,
        nikProfile: _profile.nik,
        pengajuanPinjaman: pengajuanPinjaman,
        tujuanPinjaman: tujuanPeminjam,
        bulanPinjaman: controllerBulan.text,
        nominalPinjaman: controllerNominal.text,
        statusPinjaman: pickStatus(Random().nextInt(7)),
        waktuDiajukan: DateTime.now().millisecondsSinceEpoch.toString());

    int id = await db.insert(tablePinjaman, pinjaman.toMap());
    print(id);
    return pinjaman;
  }

  Future<String> encodeImage(File _image) async {
    String _img = _image.uri.toFilePath();
    // List<int> imageBytes = await _image.readAsBytes();
    // String base64Image = base64Encode(imageBytes);

    return _img;
  }

  Future<List<Pinjaman>> getPinjaman() async {
    List<Map> maps = await db.query(
      tablePinjaman,
    );
    if (maps.length > 0) {
      _listPinjaman = maps.map((val) => Pinjaman.fromMap(val)).toList();

      return _listPinjaman;
    }
    return List();
  }
}

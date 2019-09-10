import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'profile_db.dart';

final String tablePengajuan = 'pengajuan';
final String columnNikProfile = 'nik_profile';
final String columnIdPengajuan = 'pengajuan_id';
final String columnStatusPengajuan = 'status_pengajuan';
final String columnWaktuDiajukan = 'waktu_pengajuan';

class Pengajuan {
  final String nikProfile;
  final int idPengajuan;
  final String statusPengajuan;
  final String waktuDiajukan;

  Pengajuan(
    this.nikProfile,
    this.statusPengajuan,
    this.waktuDiajukan, {
    this.idPengajuan,
  });

  Map<String, dynamic> toMap() => {
        columnNikProfile: this.nikProfile,
        columnStatusPengajuan: this.statusPengajuan,
        columnWaktuDiajukan: this.waktuDiajukan
      };

  factory Pengajuan.fromMap(Map _map) => Pengajuan(
        _map[columnNikProfile],
        _map[columnStatusPengajuan],
        _map[columnWaktuDiajukan],
        idPengajuan: _map[columnIdPengajuan],
      );
}

class PengajuanProvider {
  Database db;
  Pengajuan pengajuan;

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
          $columnWaktuDiajukan text)
        ''');
    });
  }

  Future<Pengajuan> insert(Profile _profile) async {
    pengajuan = Pengajuan(
        _profile.nik, 'Proses Diajukan', DateTime.now().toLocal().toString());

    int id = await db.insert(tablePengajuan, pengajuan.toMap());
    print(id);
    return pengajuan;
  }
}

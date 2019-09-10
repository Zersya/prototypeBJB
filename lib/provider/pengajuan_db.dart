import 'dart:io';
import 'dart:math';
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
  List<Pengajuan> _listPengajuan;

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
  String pickStatus(int rand){
    if(rand == 0)
      return 'Pengajuan dibuat';
    if(rand == 1)
      return 'Pengajuan direview';
    if(rand == 2)
      return 'Pengajuan dalam proses vertfikasi';
    if(rand == 3)
      return 'Pengajuan berhasil';

    return 'Pengajuan Ditolak';
  } 
  Future<Pengajuan> insert(Profile _profile) async {
    pengajuan = Pengajuan(
        _profile.nik, pickStatus(Random().nextInt(5)), DateTime.now().millisecondsSinceEpoch.toString());

    int id = await db.insert(tablePengajuan, pengajuan.toMap());
    print(id);
    return pengajuan;
  }

  Future<List<Pengajuan>> getPengajuan() async {
    List<Map> maps = await db.query(
      tablePengajuan,
    );
    if (maps.length > 0) {
      _listPengajuan = maps.map((val) => Pengajuan.fromMap(val)).toList();

      return _listPengajuan;
    }
    return null;
  }
}

import 'package:flutter/material.dart';
import 'package:prototype_bjb/provider/profile_db.dart';
import 'package:prototype_bjb/utils/constant.dart';
import 'package:provider/provider.dart';

class RekapScreen extends StatefulWidget {
  RekapScreen({Key key}) : super(key: key);

  _RekapScreenState createState() => _RekapScreenState();
}

class _RekapScreenState extends State<RekapScreen> {
  ProfileProvider _provider;

  @override
  Widget build(BuildContext context) {
    _provider = Provider.of<ProfileProvider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 25,
            ),
            Text(
              'Rekap Pengajuan',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 21.0,
              ),
            ),
            Divider(
              color: Colors.black,
              height: 50.0,
            ),
            _dataPemohon(),
            SizedBox(
              height: MediaQuery.of(context).size.width / 10,
            ),
            _dataInstansi(),
            SizedBox(
              height: MediaQuery.of(context).size.width / 10,
            ),
            _dataPenghasilan(),
            SizedBox(
              height: MediaQuery.of(context).size.width / 10,
            ),
            _dataRekening()
          ],
        ),
      ),
    );
  }

  Column _dataRekening() {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Color(COLOR_MAIN),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Data Rekening',
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
          ),
        ),
        Divider(
          color: Colors.transparent,
          height: 10.0,
        ),
        Container(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ListTile(
                  title: Text(
                    'No Rekening Tabungan',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 18.0,
                    ),
                  ),
                  subtitle: Text(
                    _provider.profile.noRekTabungan,
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ),
                Divider(
                  color: Colors.black26,
                  height: 30.0,
                ),
                ListTile(
                  title: Text(
                    'No Rekening Kredit Lama',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 18.0,
                    ),
                  ),
                  subtitle: Text(
                    _provider.profile.noRekKredit,
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Column _dataPenghasilan() {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Color(COLOR_MAIN),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Data Penghasilan',
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
          ),
        ),
        Divider(
          color: Colors.transparent,
          height: 10.0,
        ),
        Container(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ListTile(
                  title: Text(
                    'Penghasilan Bersih',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 18.0,
                    ),
                  ),
                  subtitle: Text(
                    _provider.profile.penghasilanBersih,
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ),
                Divider(
                  color: Colors.black26,
                  height: 30.0,
                ),
                ListTile(
                  title: Text(
                    'Tunjangan Sertifikasi',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 18.0,
                    ),
                  ),
                  subtitle: Text(
                    _provider.profile.tunjangan,
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Column _dataInstansi() {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Color(COLOR_MAIN),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Data Instansi Pemohon',
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
          ),
        ),
        Divider(
          color: Colors.transparent,
          height: 10.0,
        ),
        Container(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ListTile(
                  title: Text(
                    'Pekerjaan: ',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 18.0,
                    ),
                  ),
                  subtitle: Text(
                    _provider.profile.pekerjaan,
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ),
                Divider(
                  color: Colors.black26,
                  height: 30.0,
                ),
                ListTile(
                  title: Text(
                    'NIP',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 18.0,
                    ),
                  ),
                  subtitle: Text(
                    _provider.profile.nip,
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ),
                Divider(
                  color: Colors.black26,
                  height: 30.0,
                ),
                ListTile(
                  title: Text(
                    'Nama Instansi',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 18.0,
                    ),
                  ),
                  subtitle: Text(
                    _provider.profile.namaInstansi,
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ),
                Divider(
                  color: Colors.black26,
                  height: 30.0,
                ),
                ListTile(
                  title: Text(
                    'Alamat Kantor',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 18.0,
                    ),
                  ),
                  subtitle: Text(
                    _provider.profile.alamatKantor,
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ),
                Divider(
                  color: Colors.black26,
                  height: 30.0,
                ),
                ListTile(
                  title: Text(
                    'Telepon',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 18.0,
                    ),
                  ),
                  subtitle: Text(
                    _provider.profile.teleponKantor,
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Column _dataPemohon() {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Color(COLOR_MAIN),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Data Pemohon',
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
          ),
        ),
        Divider(
          color: Colors.transparent,
          height: 10.0,
        ),
        Container(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ListTile(
                  title: Text(
                    'No. NIK',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 18.0,
                    ),
                  ),
                  subtitle: Text(
                    _provider.profile?.nik ?? '-',
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ),
                Divider(
                  color: Colors.black26,
                  height: 30.0,
                ),
                ListTile(
                  title: Text(
                    'No. NPWP',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 18.0,
                    ),
                  ),
                  subtitle: Text(
                    _provider.profile?.npwp ?? '-',
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ),
                Divider(
                  color: Colors.black26,
                  height: 30.0,
                ),
                ListTile(
                  title: Text(
                    'Nama Lengkap',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 18.0,
                    ),
                  ),
                  subtitle: Text(
                    _provider.profile.nama,
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ),
                Divider(
                  color: Colors.black26,
                  height: 30.0,
                ),
                ListTile(
                  title: Text(
                    'Nama Ibu Kandung',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 18.0,
                    ),
                  ),
                  subtitle: Text(
                    _provider.profile.namaIbu,
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ),
                Divider(
                  color: Colors.black26,
                  height: 30.0,
                ),
                ListTile(
                  title: Text(
                    'Alamat Domisil',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 18.0,
                    ),
                  ),
                  subtitle: Text(
                    _provider.profile.alamatDomisil,
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ),
                Divider(
                  color: Colors.black26,
                  height: 30.0,
                ),
                ListTile(
                  title: Text(
                    'Telepon/Handphone',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 18.0,
                    ),
                  ),
                  subtitle: Text(
                    _provider.profile.telepon,
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

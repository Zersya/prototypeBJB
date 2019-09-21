import 'package:flutter/material.dart';
import 'package:prototype_bjb/provider/pinjaman_db.dart';
import 'package:prototype_bjb/utils/constant.dart';
import 'package:provider/provider.dart';

class RekapScreen extends StatefulWidget {
  RekapScreen({Key key}) : super(key: key);

  _RekapScreenState createState() => _RekapScreenState();
}

class _RekapScreenState extends State<RekapScreen> {
  PinjamanProvider _pinjamanProvider;

  @override
  Widget build(BuildContext context) {
    _pinjamanProvider = Provider.of<PinjamanProvider>(context);

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
            _dataPinjaman(),
            SizedBox(
              height: MediaQuery.of(context).size.width / 10,
            ),
            _nominalPinjam(),
            SizedBox(
              height: MediaQuery.of(context).size.width / 10,
            ),
            _berkas()
          ],
        ),
      ),
    );
  }

  Column _berkas() {
    return Column(
      children: <Widget>[
        Text(
          'Rekening Koran',
          style: TextStyle(
            color: Colors.black54,
            fontSize: 18.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 4.0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: _pinjamanProvider.rekeningKoran == null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.close),
                          SizedBox(
                            height: 15.0,
                          ),
                          Text('Rekening koran belum di unggah')
                        ],
                      )
                    : Image.file(_pinjamanProvider.rekeningKoran,
                        fit: BoxFit.cover),
              ),
            ),
          ),
        ),
        Text(
          'Surat Keterangan Usaha',
          style: TextStyle(
            color: Colors.black54,
            fontSize: 18.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 4.0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: _pinjamanProvider.suratKeterangan == null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.close),
                          SizedBox(
                            height: 15.0,
                          ),
                          Text('Surat keterangan usaha belum di unggah')
                        ],
                      )
                    : Image.file(_pinjamanProvider.suratKeterangan,
                        fit: BoxFit.cover),
              ),
            ),
          ),
        ),
        Text(
          'Surat Izin Usaha',
          style: TextStyle(
            color: Colors.black54,
            fontSize: 18.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 4.0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: _pinjamanProvider.suratIzinUsaha == null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.close),
                          SizedBox(
                            height: 15.0,
                          ),
                          Text('Suran izin usaha belum di unggah')
                        ],
                      )
                    : Image.file(_pinjamanProvider.suratIzinUsaha,
                        fit: BoxFit.cover),
              ),
            ),
          ),
        )
      ],
    );
  }

  Column _nominalPinjam() {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Color(kColorMain),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Nominal Pinjaman',
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
                    'Jumlah Pinjam',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 18.0,
                    ),
                  ),
                  subtitle: Text(
                    _pinjamanProvider?.controllerNominal?.text ?? '-',
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
                    'Jangka Waktu',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 18.0,
                    ),
                  ),
                  subtitle: Text(
                    '${_pinjamanProvider?.controllerBulan?.text} Bulan' ?? '-',
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

  Column _dataPinjaman() {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Color(kColorMain),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Data Pinjaman',
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
                    'Jenis Peminjam',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 18.0,
                    ),
                  ),
                  subtitle: Text(
                    _pinjamanProvider?.jenisPeminjam ?? '-',
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
                    'Tujuan Pinjam',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 18.0,
                    ),
                  ),
                  subtitle: Text(
                    _pinjamanProvider?.tujuanPinjaman ?? '-',
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
                    'Jenis Pinjam',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 18.0,
                    ),
                  ),
                  subtitle: Text(
                    _pinjamanProvider?.jenisPinjaman ?? '-',
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
                    'Pengajuan Pinjam',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 18.0,
                    ),
                  ),
                  subtitle: Text(
                    _pinjamanProvider?.pengajuanPinjaman ?? '-',
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

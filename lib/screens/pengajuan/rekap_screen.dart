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
            (MediaQuery.of(context).size.width < kSmallPhone)
                ? _dataPinjamanSmallPhone()
                : _dataPinjamanWidePhone(),
            SizedBox(
              height: MediaQuery.of(context).size.width / 10,
            ),
            (MediaQuery.of(context).size.width < kSmallPhone)
                ? _dataDebiturSmallPhone()
                : _dataDebiturWidePhone(),
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

Column _dataDebiturSmallPhone() {
    return Column(
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Debitur',
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Colors.black54,
              fontSize: 18.0,
            ),
          ),
        ),
        Divider(
          color: Colors.transparent,
          height: 20.0,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Nama Badan Usaha',
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              'PT. KitaCode',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 18.0,
              ),
            ),
            Divider(
              color: Colors.black26,
              height: 25.0,
            ),
            Text(
              'Penanggung Jawab',
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              'Irvan Maulana',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 18.0,
              ),
            ),
          ],
        )
      ],
    );
  }


  Column _dataDebiturWidePhone() {
    return Column(
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Debitur',
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Colors.black54,
              fontSize: 18.0,
            ),
          ),
        ),
        Divider(
          color: Colors.transparent,
          height: 20.0,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Nama Badan Usaha',
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'PT. KitaCode',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
            Divider(
              color: Colors.black26,
              height: 25.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Penanggung Jawab',
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Irvan Maulana',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
          ],
        )
      ],
    );
}


  Column _dataPinjamanSmallPhone() {
    return Column(
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Pinjaman',
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Colors.black54,
              fontSize: 18.0,
            ),
          ),
        ),
        Divider(
          color: Colors.transparent,
          height: 20.0,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Produk',
              style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              _pinjamanProvider?.jenisPinjaman ?? '-',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 18.0,
              ),
            ),
            Divider(
              color: Colors.black26,
              height: 25.0,
            ),
            Text(
              'Jenis Peminjam',
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              _pinjamanProvider?.jenisPeminjam ?? '-',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 18.0,
              ),
            ),
            Divider(
              color: Colors.black26,
              height: 25.0,
            ),
            Text(
              'Tujuan Pinjaman',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black54,
                fontSize: 18.0,
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              _pinjamanProvider?.tujuanPinjaman ?? '-',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 18.0,
              ),
            ),
            Divider(
              color: Colors.black26,
              height: 25.0,
            ),
            
            Text(
              'Jenis Pengajuan',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black54,
                fontSize: 18.0,
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              _pinjamanProvider?.pengajuanPinjaman ?? '-',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 18.0,
              ),
            ),
            Divider(
              color: Colors.black26,
              height: 25.0,
            ),
            Text(
              'Nominal',
              style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              _pinjamanProvider?.controllerNominal?.text ?? '-',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 18.0,
              ),
            ),
            Divider(
              color: Colors.black26,
              height: 25.0,
            ),
            Text(
              'Jangka Waktu',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black54,
                fontSize: 18.0,
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              '${_pinjamanProvider?.controllerBulan?.text} Bulan' ?? '-',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 18.0,
              ),
            ),
          ],
        )
      ],
    );
  }

  Column _dataPinjamanWidePhone() {
    return Column(
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Pinjaman',
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Colors.black54,
              fontSize: 18.0,
            ),
          ),
        ),
        Divider(
          color: Colors.transparent,
          height: 20.0,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Produk',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                    fontSize: 18.0,
                  ),
                ),
                Text(
                  _pinjamanProvider?.jenisPinjaman ?? '-',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
            Divider(
              color: Colors.black26,
              height: 25.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Jenis Peminjaman',
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  _pinjamanProvider?.jenisPeminjam ?? '-',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
            Divider(
              color: Colors.black26,
              height: 25.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Tujuan Pinjaman',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                    fontSize: 18.0,
                  ),
                ),
                Text(
                  _pinjamanProvider?.tujuanPinjaman ?? '-',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
            Divider(
              color: Colors.black26,
              height: 25.0,
            ),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Pengajuan Pinjam',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                    fontSize: 18.0,
                  ),
                ),
                Text(
                  _pinjamanProvider?.pengajuanPinjaman ?? '-',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
            Divider(
              color: Colors.black26,
              height: 25.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Nominal',
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                Text(
                  _pinjamanProvider?.controllerNominal?.text ?? '-',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
            Divider(
              color: Colors.black26,
              height: 25.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Jangka Waktu',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                    fontSize: 18.0,
                  ),
                ),
                Text(
                  '${_pinjamanProvider?.controllerBulan?.text} Bulan' ?? '-',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 18.0,
                  ),
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}

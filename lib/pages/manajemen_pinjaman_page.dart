import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prototype_bjb/provider/pinjaman_db.dart';

class ManajemenPinjamanPage extends StatefulWidget {
  ManajemenPinjamanPage({Key key, this.pinjaman}) : super(key: key);
  final Pinjaman pinjaman;
  _ManajemenPinjamanPageState createState() => _ManajemenPinjamanPageState();
}

class _ManajemenPinjamanPageState extends State<ManajemenPinjamanPage> {
  final _dateFormater = new DateFormat('dd MMMM yyyy', 'id');
  final double heightDivider = 30.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        child: Center(
          child: SingleChildScrollView(
                      child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    'Manajemen Pinjaman',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 21.0,
                    ),
                  ),
                  Divider(
                    color: Colors.black,
                    height: 30.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Kode Pinjaman'),
                      Text('id-${widget.pinjaman.idPinjaman}', style: TextStyle(fontWeight:FontWeight.bold)),
                    ],
                  ),
                  Divider(color: Colors.black54, height: heightDivider),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Jenis Peminjam'),
                      Text('${widget.pinjaman.jenisPeminjam}', style: TextStyle(fontWeight:FontWeight.bold)),
                    ],
                  ),
                  Divider(color: Colors.black54, height: heightDivider),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Tujuan Pinjaman'),
                      Text('${widget.pinjaman.tujuanPinjaman}', style: TextStyle(fontWeight:FontWeight.bold)),
                    ],
                  ),
                  Divider(color: Colors.black54, height: heightDivider),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Nominal Pinjaman'),
                      Text('${widget.pinjaman.nominalPinjaman}', style: TextStyle(fontWeight:FontWeight.bold)),
                    ],
                  ),
                  Divider(color: Colors.black54, height: heightDivider),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Jangka Waktu Pinjaman'),
                      Text('${widget.pinjaman.bulanPinjaman} Bulan', style: TextStyle(fontWeight:FontWeight.bold)),
                    ],
                  ),
                  Divider(color: Colors.black54, height: heightDivider),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Tanggal Pinjaman Dibuat'),
                      Text(_dateFormater.format(
                          DateTime.fromMillisecondsSinceEpoch(
                              int.parse(widget.pinjaman.waktuDiajukan))), style: TextStyle(fontWeight:FontWeight.bold)),
                    ],
                  ),
                  Divider(color: Colors.black54, height: heightDivider),
                  _berkas()
                ],
              ),
            ),
          ),
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
                child: widget.pinjaman.imgRekeningKoran == null
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
                    : Image.memory(base64Decode(widget.pinjaman.imgRekeningKoran),
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
                child: widget.pinjaman.imgSuratKeterangan == null
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
                    : Image.memory(base64Decode(widget.pinjaman.imgSuratKeterangan),
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
                child: widget.pinjaman.imgSuratIzinUsaha == null
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
                    : Image.memory(base64Decode(widget.pinjaman.imgSuratIzinUsaha),
                        fit: BoxFit.cover),
              ),
            ),
          ),
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prototype_bjb/provider/pengajuan_db.dart';

class ManajemenPinjamanPage extends StatefulWidget {
  ManajemenPinjamanPage({Key key, this.pengajuan}) : super(key: key);
  final Pengajuan pengajuan;
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
                    Text('id-${widget.pengajuan.idPengajuan}', style: TextStyle(fontWeight:FontWeight.bold)),
                  ],
                ),
                Divider(color: Colors.black54, height: heightDivider),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Produk Pinjaman'),
                    Text('${widget.pengajuan.product}', style: TextStyle(fontWeight:FontWeight.bold)),
                  ],
                ),
                Divider(color: Colors.black54, height: heightDivider),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Tujuan Pinjaman'),
                    Text('${widget.pengajuan.tujuanPinjaman}', style: TextStyle(fontWeight:FontWeight.bold)),
                  ],
                ),
                Divider(color: Colors.black54, height: heightDivider),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Nominal Pinjaman'),
                    Text('${widget.pengajuan.nominalPinjaman}', style: TextStyle(fontWeight:FontWeight.bold)),
                  ],
                ),
                Divider(color: Colors.black54, height: heightDivider),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Tanggal Pinjaman Dibuat'),
                    Text(_dateFormater.format(
                        DateTime.fromMillisecondsSinceEpoch(
                            int.parse(widget.pengajuan.waktuDiajukan))), style: TextStyle(fontWeight:FontWeight.bold)),
                  ],
                ),
                Divider(color: Colors.black54, height: heightDivider),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

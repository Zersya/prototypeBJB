import 'package:flutter/material.dart';
import 'package:prototype_bjb/provider/pengajuan_db.dart';

class ManajemenPinjamanPage extends StatefulWidget {
  ManajemenPinjamanPage({Key key, this.pengajuan}) : super(key: key);
  final Pengajuan pengajuan;
  _ManajemenPinjamanPageState createState() => _ManajemenPinjamanPageState();
}

class _ManajemenPinjamanPageState extends State<ManajemenPinjamanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        child: Center(
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
              Text('Manajemen Pinjaman id-${widget.pengajuan.idPengajuan}'),
            ],
          ),
        ),
      ),
    );
  }
}

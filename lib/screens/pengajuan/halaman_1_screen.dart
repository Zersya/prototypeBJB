import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prototype_bjb/provider/pinjaman_db.dart';
import 'package:provider/provider.dart';

class Halaman1Screen extends StatefulWidget {
  Halaman1Screen({Key key}) : super(key: key);

  _Halaman1ScreenState createState() => _Halaman1ScreenState();
}

class _Halaman1ScreenState extends State<Halaman1Screen> {
  PinjamanProvider _pinjamanProvider;

  @override
  Widget build(BuildContext context) {
    _pinjamanProvider = Provider.of<PinjamanProvider>(context);

    return Scaffold(
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 30,
                ),
                _section1(),
                SizedBox(
                  height: 30,
                ),
                _section2(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _section2() {
    return Column(
      children: <Widget>[
        TextFormField(
          controller: _pinjamanProvider.controllerNominal,
          keyboardType: TextInputType.number,
          inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
          decoration: InputDecoration(labelText: 'Jumlah yang diajukan'),
        ),
        TextFormField(
          controller: _pinjamanProvider.controllerBulan,
          keyboardType: TextInputType.number,
          inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
          decoration:
              InputDecoration(labelText: 'Jangka waktu', hintText: 'Bulan', ),
        )
      ],
    );
  }

  Widget _section1() {
    return Column(
      children: <Widget>[
        
        SizedBox(
          width: double.infinity,
          child: DropdownButton(
            isExpanded: true,
            hint: Text('Produk Pinjaman', style:TextStyle(color:Colors.black54)),
            onChanged: (value) {
              setState(() {
                _pinjamanProvider.jenisPinjaman = value;
              });
            },
            value: _pinjamanProvider.jenisPinjaman,
            items: [
              DropdownMenuItem(
                child: Text('BJB Kredit Mikro Utama'),
                value: 'BJB Kredit Mikro Utama',
              ),
              DropdownMenuItem(
                child: Text('Kredit Cinta Rakyat'),
                value: 'Kredit Cinta Rakyat',
              ),
              DropdownMenuItem(
                child: Text('BJB KUKM'),
                value: 'BJB KUKM',
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        SizedBox(
          width: double.infinity,
          child: DropdownButton(
            isExpanded: true,
            hint: Text('Jenis Peminjam', style:TextStyle(color:Colors.black54)),
            onChanged: (value) {
              setState(() {
                _pinjamanProvider.jenisPeminjam = value;
              });
            },
            value: _pinjamanProvider.jenisPeminjam,
            items: [
              DropdownMenuItem(
                child: Text('Perorangan'),
                value: 'Perorangan',
              ),
              DropdownMenuItem(
                child: Text('Badan Usaha'),
                value: 'Badan Usaha',
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        SizedBox(
          width: double.infinity,
          child: DropdownButton(
            isExpanded: true,
            hint: Text('Tujuan Pinjaman', style:TextStyle(color:Colors.black54)),
            onChanged: (value) {
              setState(() {
                _pinjamanProvider.tujuanPinjaman = value;
              });
            },
            value: _pinjamanProvider.tujuanPinjaman,
            items: [
              DropdownMenuItem(
                child: Text('Pendidikan'),
                value: 'Pendidikan',
              ),
              DropdownMenuItem(
                child: Text('Kendaraan'),
                value: 'Kendaraan',
              ),
              DropdownMenuItem(
                child: Text('Tanah/Bangunan'),
                value: 'Tanah/Bangunan',
              ),
              DropdownMenuItem(
                child: Text('Modal Usaha'),
                value: 'Modal Usaha',
              ),
              DropdownMenuItem(
                child: Text('Lainnya'),
                value: 'Lainnya',
              )
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        SizedBox(
          width: double.infinity,
          child: DropdownButton(
            isExpanded: true,
            hint: Text('Pengajuan Pinjaman', style:TextStyle(color:Colors.black54)),
            onChanged: (value) {
              setState(() {
                _pinjamanProvider.pengajuanPinjaman = value;
              });
            },
            value: _pinjamanProvider.pengajuanPinjaman,
            items: [
              DropdownMenuItem(
                child: Text('Baru'),
                value: 'Baru',
              ),
              DropdownMenuItem(
                child: Text('Suplesi'),
                value: 'Suplesi',
              ),
              DropdownMenuItem(
                child: Text('Take Over'),
                value: 'Take Over',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

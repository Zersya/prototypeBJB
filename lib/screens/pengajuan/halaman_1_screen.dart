import 'package:flutter/material.dart';
import 'package:prototype_bjb/provider/pinjaman_db.dart';
import 'package:prototype_bjb/provider/profile_db.dart';
import 'package:provider/provider.dart';

class Halaman1Screen extends StatefulWidget {
  Halaman1Screen({Key key}) : super(key: key);

  _Halaman1ScreenState createState() => _Halaman1ScreenState();
}

class _Halaman1ScreenState extends State<Halaman1Screen> {
  ProfileProvider _profileProvider;
  PinjamanProvider _pinjamanProvider;



  @override
  Widget build(BuildContext context) {
    _profileProvider = Provider.of<ProfileProvider>(context);
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
        Text(
          'Nominal Pinjaman',
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
        TextFormField(
          controller: _pinjamanProvider.controllerNominal,
          decoration: InputDecoration(labelText: 'Jumlah yang diajukan'),
        ),
        TextFormField(
          controller: _pinjamanProvider.controllerBulan,
          decoration:
              InputDecoration(labelText: 'Jangka waktu', hintText: 'Bulan'),
        )
      ],
    );
  }

  Widget _section1() {
    return Column(
      children: <Widget>[
        Text(
          'Data Pinjaman',
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
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Jenis Peminjam',
            style: TextStyle(
              color: Colors.black54,
              fontSize: 18.0,
            ),
          ),
        ),
        Column(
          children: <Widget>[
            RadioListTile(
              value: 'Perorangan',
              title: Text('Perorangan'),
              groupValue: _pinjamanProvider.jenisPeminjam,
              onChanged: (String value) {
                setState(() {
                  _pinjamanProvider.jenisPeminjam = value;
                });
              },
            ),
            RadioListTile(
              value: 'Badan Usaha',
              title: Text('Badan Usaha'),
              groupValue: _pinjamanProvider.jenisPeminjam,
              onChanged: (String value) {
                setState(() {
                  _pinjamanProvider.jenisPeminjam = value;
                });
              },
            ),
          ],
        ),
        SizedBox(
          height: 30,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Tujuan Pinjaman',
            style: TextStyle(
              color: Colors.black54,
              fontSize: 18.0,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: double.infinity,
            child: DropdownButton(
              hint: Text('Pilih Tujuan'),
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
        ),
        SizedBox(
          height: 30,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Jenis Pinjaman',
            style: TextStyle(
              color: Colors.black54,
              fontSize: 18.0,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: double.infinity,
            child: DropdownButton(
              hint: Text('Pilih Jenis'),
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
        ),
        SizedBox(
          height: 30,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Pengajuan Pinjaman',
            style: TextStyle(
              color: Colors.black54,
              fontSize: 18.0,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: double.infinity,
            child: DropdownButton(
              hint: Text('Pilih Pengajuan'),
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
        ),
      ],
    );
  }
}

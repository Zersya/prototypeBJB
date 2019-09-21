import 'package:flutter/material.dart';
import 'package:prototype_bjb/provider/pinjaman_db.dart';
import 'package:prototype_bjb/provider/profile_db.dart';
import 'package:prototype_bjb/screens/pengajuan/halaman_1_screen.dart';
import 'package:prototype_bjb/screens/pengajuan/halaman_2_screen.dart';
import 'package:prototype_bjb/screens/pengajuan/rekap_screen.dart';
import 'package:prototype_bjb/screens/pengajuan/termsandcondition_screen.dart';
import 'package:prototype_bjb/utils/constant.dart';
import 'package:provider/provider.dart';

class PengajuanPage extends StatefulWidget {
  PengajuanPage({Key key}) : super(key: key);

  _PengajuanPageState createState() => _PengajuanPageState();
}

class _PengajuanPageState extends State<PengajuanPage> {
  PageController _pageController =
      PageController(initialPage: 0, keepPage: true);
  ProfileProvider _profileProvider;
  PinjamanProvider _pinjamanProvider = PinjamanProvider();

  int indexScreen = 0;
  Widget _step(
    int index,
  ) {
    return CircleAvatar(
      backgroundColor:
          index == indexScreen + 1 ? Colors.green : Color(kColorMain),
      radius: 15,
      child: Text(index.toString()),
    );
  }

  Widget _line() {
    return Expanded(
      flex: 1,
      child: Container(
        height: 1.5,
        color: Colors.black87,
      ),
    );
  }

  @override
  void initState() {
    _pinjamanProvider.open();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _profileProvider = Provider.of<ProfileProvider>(context);

    return Scaffold(
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            color: Colors.black12,
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _step(1),
                _line(),
                _step(2),
                _line(),
                _step(3),
                _line(),
                _step(4),
              ],
            ),
          ),
          Container(
              width: double.infinity,
              color: Color(kColorMain),
              child: Builder(
                builder: (context) {
                  return SafeArea(
                    bottom: true,
                    child: FlatButton(
                      child: Text(
                        indexScreen == 3 ? 'Ajukan' : 'Selanjutnya',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        await _showDialog(context);
                      },
                    ),
                  );
                },
              )),
        ],
      ),
      body: SafeArea(
        top: true,
        child: PageView(
          onPageChanged: (val) {
            setState(() {
              indexScreen = val;
            });
          },
          controller: _pageController,
          children: <Widget>[
            Provider.value(
              value: _pinjamanProvider,
              child: Halaman1Screen(),
            ),
            Provider.value(
              value: _pinjamanProvider,
              child: Halaman2Screen(),
            ),
            Provider.value(
              value: _pinjamanProvider,
              child: TermsAndConditionScreen(),
            ),
            Provider.value(
              value: _pinjamanProvider,
              child: RekapScreen(),
            ),
          ],
        ),
      ),
    );
  }

  _showDialog(_context) async {
    if (indexScreen == 3) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              title: Text('Konfirmasi'),
              content: Text('Apakah anda yakin ?'),
              actions: <Widget>[
                FlatButton(
                  child: Text('Tidak'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  child: Text('Iya'),
                  onPressed: () {
                    if (!_pinjamanProvider.isTermsAgree) {
                      Navigator.of(context).pop();

                      Scaffold.of(_context).showSnackBar(SnackBar(
                        content: Text('Silahkan setujui syarat dan ketentuan'),
                      ));
                    } else if (_pinjamanProvider.suratIzinUsaha == null &&
                        _pinjamanProvider.rekeningKoran == null &&
                        _pinjamanProvider.suratKeterangan == null) {
                      Navigator.of(context).pop();
                      Scaffold.of(_context).showSnackBar(SnackBar(
                        content: Text('Harap lengkapi berkas'),
                      ));
                    } else {
                      _pinjamanProvider.insert(
                          _profileProvider.profile,
                          _pinjamanProvider.jenisPinjaman,
                          _pinjamanProvider.jenisPeminjam,
                          _pinjamanProvider.tujuanPinjaman,
                          _pinjamanProvider.pengajuanPinjaman,
                          _pinjamanProvider.rekeningKoran,
                          _pinjamanProvider.suratKeterangan,
                          _pinjamanProvider.suratIzinUsaha);

                      _pinjamanProvider.isTermsAgree = false;
                      Navigator.of(context).pop();
                      Navigator.of(context).pop(true);
                    }
                  },
                )
              ],
            );
          });
    } else {
      if (indexScreen == 2 && !_pinjamanProvider.isTermsAgree)
        Scaffold.of(_context).showSnackBar(SnackBar(
          content: Text('Silahkan setujui syarat dan ketentuan'),
        ));
      else {
        _pageController.nextPage(
            duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
      }
    }
  }
}

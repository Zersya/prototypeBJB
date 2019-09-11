import 'package:flutter/material.dart';
import 'package:prototype_bjb/provider/pengajuan_db.dart';
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
  PengajuanProvider _pengajuanProvider;

  int indexScreen = 0;
  Widget _step(
    int index,
  ) {
    return CircleAvatar(
      backgroundColor:
          index == indexScreen + 1 ? Colors.green : Color(COLOR_MAIN),
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
  Widget build(BuildContext context) {
    _pengajuanProvider = Provider.of<PengajuanProvider>(context);

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
              color: Color(COLOR_MAIN),
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
            Halaman1Screen(),
            Halaman2Screen(),
            TermsAndConditionScreen(),
            RekapScreen()
          ],
        ),
      ),
    );
  }

  _showDialog(context) async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
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
                  if (indexScreen == 3) {
                    if (!_pengajuanProvider.isTermsAgree)
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text('Silahkan setujui syarat dan ketentuan'),
                      ));
                    else {
                      // _pengajuanProvider.insert(_profileProvider.profile);
                      _pengajuanProvider.isTermsAgree = false;
                      Navigator.of(context).pop(true);
                    }
                  } else {
                    if (indexScreen == 2 && !_pengajuanProvider.isTermsAgree)
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text('Silahkan setujui syarat dan ketentuan'),
                      ));
                    else {
                      _pageController.nextPage(
                          duration: Duration(milliseconds: 200),
                          curve: Curves.easeInOut);
                    }
                  }
                },
              )
            ],
          );
        });
  }
}

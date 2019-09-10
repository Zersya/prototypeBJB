import 'package:flutter/material.dart';
import 'package:prototype_bjb/provider/pengajuan_db.dart';
import 'package:prototype_bjb/provider/profile_db.dart';
import 'package:prototype_bjb/screens/datainstansi_screen.dart';
import 'package:prototype_bjb/screens/datapemohon_screen.dart';
import 'package:prototype_bjb/screens/datarekening_screen.dart';
import 'package:prototype_bjb/screens/penghasilan_screen.dart';
import 'package:prototype_bjb/screens/rekap_screen.dart';
import 'package:prototype_bjb/screens/termsandcondition_screen.dart';
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
  PengajuanProvider _pengajuanProvider;

  int indexScreen = 0;
  Widget _step(
    int index,
  ) {
    return CircleAvatar(
      backgroundColor: index == indexScreen ? Colors.green : Color(COLOR_MAIN),
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
    _profileProvider = Provider.of<ProfileProvider>(context);
    _pengajuanProvider = Provider.of<PengajuanProvider>(context);

    return Scaffold(
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _step(0),
                _line(),
                _step(1),
                _line(),
                _step(2),
                _line(),
                _step(3),
                _line(),
                _step(4),
                _line(),
                _step(5),
              ],
            ),
          ),
          SizedBox(height: 20,),
          Container(
              width: double.infinity,
              color: Color(COLOR_MAIN),
              child: Builder(
                builder: (context) {
                  return SafeArea(
                    bottom: true,
                    child: FlatButton(
                      child: Text(
                        indexScreen == 5 ? 'Ajukan' : 'Selanjutnya',
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
            DataPemohonScreen(),
            DataInstansiScreen(),
            PenghasilanScreen(),
            DataRekeningScreen(),
            TermsAndConditionScreen(),
            RekapScreen()
          ],
        ),
      ),
    );
  }

  _showDialog(context) async {
    if (indexScreen == 5) {
      if (!_profileProvider.isTermsAgree)
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Silahkan setujui syarat dan ketentuan'),
        ));
      else {
        _pengajuanProvider.insert(_profileProvider.profile);
        Navigator.of(context).pop(true);
      }
    } else {
      if (indexScreen == 4 && !_profileProvider.isTermsAgree)
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Silahkan setujui syarat dan ketentuan'),
        ));
      else {
        await _profileProvider.update(_profileProvider.profile.id);

        _pageController.nextPage(
            duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
      }
    }
  }
}

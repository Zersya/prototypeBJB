import 'package:flutter/material.dart';
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
  ProfileProvider _provider;
  int indexScreen = 0;

  @override
  Widget build(BuildContext context) {
    _provider = Provider.of<ProfileProvider>(context);

    return Scaffold(
        bottomNavigationBar: Container(
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
                    onPressed: () {
                      if (indexScreen == 5) {
                        if (!_provider.isTermsAgree)
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content:
                                Text('Silahkan setujui syarat dan ketentuan'),
                          ));
                        else {
                          _provider.insert();
                          Navigator.of(context).pop(true);
                        }
                      } else {
                        if (indexScreen == 4 && !_provider.isTermsAgree)
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content:
                                Text('Silahkan setujui syarat dan ketentuan'),
                          ));
                        else
                          _pageController.nextPage(
                              duration: Duration(milliseconds: 200),
                              curve: Curves.easeInOut);
                      }
                    },
                  ),
                );
              },
            )),
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
        ));
  }
}

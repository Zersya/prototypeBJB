import 'package:flutter/material.dart';
import 'package:prototype_bjb/provider/profile_db.dart';
import 'package:prototype_bjb/screens/profile/datainstansi_screen.dart';
import 'package:prototype_bjb/screens/profile/dataktpnpwp_screen.dart';
import 'package:prototype_bjb/screens/profile/datapemohon_screen.dart';
import 'package:prototype_bjb/screens/profile/datarekening_screen.dart';
import 'package:prototype_bjb/screens/profile/penghasilan_screen.dart';
import 'package:prototype_bjb/utils/colors.dart';
import 'package:prototype_bjb/utils/constant.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ProfileProvider _provider;

  int indexPage = 0;
  @override
  Widget build(BuildContext context) {
    _provider = Provider.of<ProfileProvider>(context);

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: Row(
            children: <Widget>[
              itemMenu('Profil', 0),
              itemMenu('Instansi', 1),
              itemMenu('Finansial', 2),
              itemMenu('Rekening', 3),
              itemMenu('Dokumen', 4),
            ],
          ),
        ),
        bottomNavigationBar: Builder(
          builder: (context) {
            return Padding(
              padding:
                  const EdgeInsets.only(bottom: 16.0, left: 16.0, right: 16.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Color(kColorButtonSimpan),
                    borderRadius: BorderRadius.circular(10)),
                child: SafeArea(
                  bottom: true,
                  child: FlatButton(
                    child: Text(
                      'SIMPAN',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      if (_provider.profile == null)
                        _provider.insert();
                      else
                        _provider.update(_provider.profile.id);

                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text('Berhasil Memperbaharui Profile'),
                      ));
                    },
                  ),
                ),
              ),
            );
          },
        ),
        body: IndexedStack(
          index: indexPage,
          alignment: Alignment.topCenter,
          children: <Widget>[
            DataPemohonScreen(),
            DataInstansiScreen(),
            PenghasilanScreen(),
            DataRekeningScreen(),
            DataKtpNpwpScreen(),
          ],
          sizing: StackFit.loose,
        ));
  }

  Widget itemMenu(String text, int index) {
    bool isActive = index == indexPage;
    return Expanded(
      flex: 1,
      child: InkWell(
        onTap: () {
          setState(() {
            indexPage = index;
          });
        },
        child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: kcolorPrimary[900],
              border: Border(
                bottom: BorderSide(
                  width: 4,
                  color: isActive ? Colors.orange : Colors.transparent,
                ),
              ),
            ),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: MediaQuery.of(context).size.width / 30),
            )),
      ),
    );
  }
}

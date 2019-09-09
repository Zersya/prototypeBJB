import 'package:flutter/material.dart';
import 'package:prototype_bjb/provider/profile_db.dart';
import 'package:prototype_bjb/screens/datainstansi_screen.dart';
import 'package:prototype_bjb/screens/dataktpnpwp_screen.dart';
import 'package:prototype_bjb/screens/datapemohon_screen.dart';
import 'package:prototype_bjb/screens/datarekening_screen.dart';
import 'package:prototype_bjb/screens/penghasilan_screen.dart';
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
        appBar: AppBar(
          title: Text(
            'Data Kamu',
            style: TextStyle(color: Colors.black),
          ),
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48.0),
            child: Row(
              children: <Widget>[
                itemMenu(Icons.add_a_photo, 0),
                itemMenu(Icons.person, 1),
                itemMenu(Icons.business, 2),
                itemMenu(Icons.account_balance_wallet, 3),
                itemMenu(Icons.account_balance, 4),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          width: double.infinity,
          color: Color(COLOR_MAIN),
          child: SafeArea(
            bottom: true,
            child: FlatButton(
              child: Text(
                'SIMPAN',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                _provider.insert();
              },
            ),
          ),
        ),
        body: IndexedStack(
          index: indexPage,
          alignment: Alignment.topCenter,
          children: <Widget>[
            DataKtpNpwpScreen(),
            DataPemohonScreen(),
            DataInstansiScreen(),
            PenghasilanScreen(),
            DataRekeningScreen(),
          ],
          sizing: StackFit.loose,
        ));
  }

  Widget itemMenu(IconData _icon, int index) {
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
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
                border: Border.all(
                    color: Colors.black26, width: isActive ? 1 : 1.25),
                // border: Border(
                //     top: BorderSide(
                //       color: Colors.black26,
                //       width: 1.25,
                //     ),
                //     bottom: BorderSide(
                //       color: isActive ? Colors.white : Colors.black12,
                //       width: 1.25,
                //     ),
                //     left: BorderSide(
                //       color: Colors.black26,
                //       width: 1.25,
                //     ),
                //     right: BorderSide(
                //       color: Colors.black26,
                //       width: 1.25,
                //     )),
                color: isActive ? Colors.white : Colors.black12),
            child: Icon(_icon)),
      ),
    );
  }
}

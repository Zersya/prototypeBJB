import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:prototype_bjb/screens/dataktpnpwp_screen.dart';
import 'package:prototype_bjb/screens/datapemohon_screen.dart';
import 'package:prototype_bjb/utils/constant.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int indexPage = 0;
  @override
  Widget build(BuildContext context) {
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
              )),
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
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: IndexedStack(
            index: indexPage,
            alignment: Alignment.topCenter,
            children: <Widget>[
              DataKtpNpwpScreen(),
              DataPemohonScreen(),
              Container(),
              Container(),
              Container(),

            ],
            sizing: StackFit.loose,
          ),
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
                border: Border(
                    top: BorderSide(
                      color: Colors.black26,
                      width: 0.5,
                    ),
                    bottom: BorderSide(
                      color: isActive ? Colors.white : Colors.black12,
                      width: 0.5,
                    ),
                    left: BorderSide(
                      color: Colors.black26,
                      width: 0.5,
                    ),
                    right: BorderSide(
                      color: Colors.black26,
                      width: 0.5,
                    )),
                color: isActive ? Colors.white : Colors.black12),
            child: Icon(_icon)),
      ),
    );
  }
}

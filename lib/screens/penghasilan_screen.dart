import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prototype_bjb/provider/profile_db.dart';
import 'package:prototype_bjb/utils/constant.dart';
import 'package:provider/provider.dart';

class PenghasilanScreen extends StatefulWidget {
  PenghasilanScreen({Key key}) : super(key: key);

  _PenghasilanScreenState createState() => _PenghasilanScreenState();
}

class _PenghasilanScreenState extends State<PenghasilanScreen> {
  ProfileProvider _provider;

  @override
  void initState() {
    super.initState();
    _provider = Provider.of<ProfileProvider>(context, listen: false);

    _provider.setController();
  }

  @override
  Widget build(BuildContext context) {
    _provider = Provider.of<ProfileProvider>(context);

    return Scaffold(
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 25,
              ),
              Text(
                'Penghasilan Pemohon Kredit',
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
              CircleAvatar(
                  backgroundColor: Color(COLOR_MAIN),
                  radius: 70.0,
                  child: Icon(
                    Icons.account_balance_wallet,
                    color: Colors.white,
                    size: MediaQuery.of(context).size.width / 5,
                  )),
              SizedBox(
                height: MediaQuery.of(context).size.width / 8,
              ),
              TextFormField(
                controller: _provider.controllerPenghasilan,
                decoration: InputDecoration(labelText: 'Penghasilan Bersih'),
                keyboardType: TextInputType.number,
                inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
              ),
              TextFormField(
                controller: _provider.controllerTunjangan,
                decoration: InputDecoration(labelText: 'Tunjangan Sertifikasi'),
                keyboardType: TextInputType.number,
                inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
              ),
              Divider(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prototype_bjb/provider/profile_db.dart';
import 'package:prototype_bjb/utils/constant.dart';
import 'package:provider/provider.dart';

class DataRekeningScreen extends StatefulWidget {
  DataRekeningScreen({Key key}) : super(key: key);

  _DataRekeningScreenState createState() => _DataRekeningScreenState();
}

class _DataRekeningScreenState extends State<DataRekeningScreen> {
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

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 25,
              ),
              Text(
                'Data Rekening',
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
                  backgroundColor: Color(kColorMain),
                  radius: 70.0,
                  child: Icon(
                    Icons.account_balance,
                    color: Colors.white,
                    size: MediaQuery.of(context).size.width / 5,
                  )),
              SizedBox(
                height: MediaQuery.of(context).size.width / 8,
              ),
              TextFormField(
                controller: _provider.controllerNoRekTabungan,
                decoration: InputDecoration(labelText: 'No Rekening Tabungan'),
                keyboardType: TextInputType.number,
                inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
              ),
              TextFormField(
                controller: _provider.controllerNoRekKredit,
                decoration:
                    InputDecoration(labelText: 'No Rekening Kredit Lama'),
                keyboardType: TextInputType.number,
                inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
              ),
              Divider(
                height: 20,
              ),
            ],
          ),
        ),
    );
  }
}

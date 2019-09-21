import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prototype_bjb/provider/profile_db.dart';
import 'package:prototype_bjb/utils/constant.dart';
import 'package:provider/provider.dart';

class DataPemohonScreen extends StatefulWidget {
  DataPemohonScreen({Key key}) : super(key: key);

  _DataPemohonScreenState createState() => _DataPemohonScreenState();
}

class _DataPemohonScreenState extends State<DataPemohonScreen> {
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
              'Data Pemohon',
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
                child: _provider.profile == null
                    ? Icon(
                        Icons.person,
                        color: Colors.white,
                        size: MediaQuery.of(context).size.width / 5,
                      )
                    : Text(
                        '${_provider.profile.nama[0].toUpperCase()} ${_provider.profile.nama[_provider.profile.nama.length - 1].toUpperCase()}',
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width / 8,
                            color: Colors.white),
                      )),
            SizedBox(
              height: MediaQuery.of(context).size.width / 8,
            ),
            TextFormField(
              controller: _provider.controllerNIK,
              decoration: InputDecoration(labelText: 'Nomor NIK'),
              keyboardType: TextInputType.number,
              inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
              readOnly: true,
            ),
            TextFormField(
              controller: _provider.controllerNPWP,
              decoration: InputDecoration(labelText: 'Nomor NPWP'),
              keyboardType: TextInputType.number,
              inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
              readOnly: true,
            ),
            TextFormField(
              controller: _provider.controllerNama,
              decoration: InputDecoration(labelText: 'Nama Lengkap'),
            ),
            TextFormField(
              controller: _provider.controllerIbuKandung,
              decoration: InputDecoration(labelText: 'Nama Ibu Kandung'),
            ),
            TextFormField(
              controller: _provider.controllerAlamatDomisil,
              decoration: InputDecoration(labelText: 'Alamat Domisil'),
            ),
            TextFormField(
              controller: _provider.controllerTelepon,
              decoration: InputDecoration(labelText: 'Telepon/Handphone'),
              keyboardType: TextInputType.phone,
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

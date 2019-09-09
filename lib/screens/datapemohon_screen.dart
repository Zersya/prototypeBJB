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
  final _formKey = GlobalKey<FormState>();
  ProfileProvider _provider;

  @override
  Widget build(BuildContext context) {
    _provider = Provider.of<ProfileProvider>(context);

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: SafeArea(
            top: true,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                    backgroundColor: Color(COLOR_MAIN),
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
                                fontSize:
                                    MediaQuery.of(context).size.width / 8),
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
                  controller: _provider.controllerAlamat,
                  decoration: InputDecoration(labelText: 'Alamat tempat tinggal saat ini'),
                ),
                
               
              ],
            ),
          ),
        ),
      ),
    );
  }
}
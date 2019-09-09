import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prototype_bjb/provider/profile_db.dart';
import 'package:prototype_bjb/utils/constant.dart';
import 'package:provider/provider.dart';

class DataInstansiScreen extends StatefulWidget {
  DataInstansiScreen({Key key}) : super(key: key);

  _DataInstansiScreenState createState() => _DataInstansiScreenState();
}

class _DataInstansiScreenState extends State<DataInstansiScreen> {
  ProfileProvider _provider;

  @override
  Widget build(BuildContext context) {
    _provider = Provider.of<ProfileProvider>(context);

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Data Instansi Pemohon',
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
              Icons.business,
              color: Colors.white,
              size: MediaQuery.of(context).size.width / 5,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width / 8,
          ),
          TextFormField(
            controller: _provider.controllerPekerjaan,
            decoration: InputDecoration(labelText: 'Pekerjaan'),
          ),
          TextFormField(
            controller: _provider.controllerNIP,
            decoration: InputDecoration(labelText: 'NIP'),
            keyboardType: TextInputType.number,
            inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
          ),
          TextFormField(
            controller: _provider.controllerNamaInstansi,
            decoration:
                InputDecoration(labelText: 'Nama Instansi Dinas / Perusahaan'),
          ),
          TextFormField(
            controller: _provider.controllerAlamatKantor,
            decoration: InputDecoration(labelText: 'Alamat Kantor'),
          ),
          TextFormField(
            controller: _provider.controllerTeleponKantor,
            decoration: InputDecoration(labelText: 'Telepon'),
            keyboardType: TextInputType.phone,
            inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
          ),
          Divider(
            height: 20,
          ),
          Container(
            width: double.infinity,
            child: FlatButton(
              color: Color(COLOR_MAIN),
              child: Text(
                'SUBMIT',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                _provider.insert();
              },
            ),
          )
        ],
      ),
    );
  }
}

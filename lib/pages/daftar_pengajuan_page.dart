import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prototype_bjb/provider/pengajuan_db.dart';
import 'package:prototype_bjb/utils/constant.dart';
import 'package:provider/provider.dart';

class DaftarPengajuanPage extends StatefulWidget {
  DaftarPengajuanPage({Key key}) : super(key: key);

  _DaftarPengajuanPageState createState() => _DaftarPengajuanPageState();
}

class _DaftarPengajuanPageState extends State<DaftarPengajuanPage> {
  PengajuanProvider _pengajuanProvider;
  final _dateFormater = new DateFormat('dd MMMM yyyy', 'id');

  @override
  Widget build(BuildContext context) {
    _pengajuanProvider = Provider.of<PengajuanProvider>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SafeArea(
          top: true,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 25,
              ),
              Text(
                'Daftar Pengajuan',
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
              StreamProvider.value(
                value: _pengajuanProvider.getPengajuan().asStream(),
                child: Consumer<List<Pengajuan>>(
                  builder: (_, data, child) {
                    if (data == null) {
                      return CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Color(COLOR_MAIN)),
                      );
                    }
                    return ListView.separated(
                      separatorBuilder: (context, index) {
                        return Divider(
                          color: Colors.black54,
                        );
                      },
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        String date = DateTime.fromMillisecondsSinceEpoch(
                                int.parse(data[index].waktuDiajukan))
                            .toString();
                        return ListTile(
                          leading: Container(
                            color: Color(COLOR_MAIN),
                            width: MediaQuery.of(context).size.width / 30,
                          ),
                          title: Text(data[index].statusPengajuan.toString()),
                          subtitle:
                              Text(_dateFormater.format(DateTime.parse(date))),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

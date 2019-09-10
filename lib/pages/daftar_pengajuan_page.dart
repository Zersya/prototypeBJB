import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prototype_bjb/provider/pengajuan_db.dart';
import 'package:prototype_bjb/utils/constant.dart';
import 'package:provider/provider.dart';

import 'manajemen_pinjaman_page.dart';

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
                          trailing: Card(
                            color: Colors.transparent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            elevation: 4,
                            child: GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text('Menu'),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            ListTile(
                                              title: Text('Manajemen Pinjaman'),
                                            ),
                                            Divider(color: Colors.black87,),
                                            ListTile(
                                              title: Text('Progress Pengajuan'),
                                            )
                                          ],
                                        ),
                                      );
                                    });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Color(COLOR_MAIN),
                                    borderRadius: BorderRadius.circular(30)),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Icon(
                                    Icons.more_vert,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          leading: Material(
                            elevation: 4,
                            child: Container(
                              color: Color(COLOR_MAIN),
                              width: MediaQuery.of(context).size.width / 40,
                            ),
                          ),
                          title: Text(data[index].statusPengajuan.toString()),
                          subtitle:
                              Text(_dateFormater.format(DateTime.parse(date))),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ManajemenPinjamanPage(
                                      pengajuan: data[index],
                                    )));
                          },
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

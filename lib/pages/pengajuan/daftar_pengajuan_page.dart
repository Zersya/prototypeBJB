import 'package:flutter/material.dart';
import 'progress_pengajuan_page.dart';
import 'package:prototype_bjb/provider/pinjaman_db.dart';
import 'package:prototype_bjb/utils/constant.dart';
import 'package:provider/provider.dart';

import 'manajemen_pinjaman_page.dart';

class DaftarPengajuanPage extends StatefulWidget {
  DaftarPengajuanPage({Key key}) : super(key: key);

  _DaftarPengajuanPageState createState() => _DaftarPengajuanPageState();
}

class _DaftarPengajuanPageState extends State<DaftarPengajuanPage> {
  PinjamanProvider _pinjamanProvider = PinjamanProvider();

  @override
  void initState() {
    super.initState();
    _pinjamanProvider.open();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamProvider.value(
      value: _pinjamanProvider.open().asStream(),
      child: Consumer(
        builder: (_, data, child) {
          if (data == null)
            return CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(COLOR_MAIN)),
            );
          else
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SafeArea(
                top: true,
                bottom: true,
                child: SingleChildScrollView(
                  physics: ScrollPhysics(),
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
                        value: _pinjamanProvider.getPinjaman().asStream(),
                        child: Consumer<List<Pinjaman>>(
                          builder: (_, data, child) {
                            if (data == null) {
                              return CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Color(COLOR_MAIN)),
                              );
                            }
                            if (data.length == 0)
                              return Container(
                                child: Center(
                                  child: Text('Tidak ada data'),
                                ),
                              );
                            return ListView.separated(
                              physics: ScrollPhysics(),
                              separatorBuilder: (context, index) {
                                return Divider(
                                  color: Colors.black54,
                                );
                              },
                              shrinkWrap: true,
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                
                                return ListTile(
                                  trailing: Card(
                                    color: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    elevation: 4,
                                    child: GestureDetector(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                title: Text('Menu'),
                                                content: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: <Widget>[
                                                    ListTile(
                                                      title: Text(
                                                          'Manajemen Pinjaman'),
                                                      onTap: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                        Navigator.of(context)
                                                            .push(
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                ManajemenPinjamanPage(
                                                              pinjaman:
                                                                  data[index],
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                    Divider(
                                                      color: Colors.black87,
                                                    ),
                                                    ListTile(
                                                      title: Text(
                                                          'Progress Pengajuan'),
                                                      onTap: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                        Navigator.of(context)
                                                            .push(
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                ProgressPengajuanPage(
                                                              pinjaman:
                                                                  data[index],
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    )
                                                  ],
                                                ),
                                              );
                                            });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Color(COLOR_MAIN),
                                            borderRadius:
                                                BorderRadius.circular(30)),
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
                                      width: MediaQuery.of(context).size.width /
                                          40,
                                    ),
                                  ),
                                  title: Text(
                                      data[index].tujuanPinjaman.toString()),
                                  subtitle: Text(data[index].statusPinjaman),
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ManajemenPinjamanPage(
                                                  pinjaman: data[index],
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
        },
      ),
    ));
  }
}

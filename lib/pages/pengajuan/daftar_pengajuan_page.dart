import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prototype_bjb/pages/pengajuan/pengajuan_page.dart';
import 'package:prototype_bjb/provider/profile_db.dart';
import 'package:prototype_bjb/utils/colors.dart';
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
  ProfileProvider _profileProvider;
  final _dateFormater = new DateFormat('dd MMM yyyy', 'id');

  @override
  void initState() {
    super.initState();
    _pinjamanProvider.open();
  }

  @override
  Widget build(BuildContext context) {
    _profileProvider = Provider.of<ProfileProvider>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.orange,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => Provider.value(
                  value: _profileProvider, child: PengajuanPage())));
        },
      ),
      body: StreamProvider.value(
        value: _pinjamanProvider.open().asStream(),
        child: Consumer(
          builder: (_, data, child) {
            if (data == null)
              return CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(kColorMain)),
              );
            else
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SafeArea(
                  top: true,
                  bottom: true,
                  child: StreamProvider.value(
                    value: _pinjamanProvider.getPinjaman().asStream(),
                    child: Consumer<List<Pinjaman>>(
                      builder: (_, data, child) {
                        if (data == null) {
                          return CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Color(kColorMain)),
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
                            return Card(
                              child: InkWell(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      (MediaQuery.of(context).size.width <
                                              kSmallPhone)
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                    data[index]
                                                        .jenisPinjaman
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 18)),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                    _dateFormater.format(DateTime
                                                        .fromMillisecondsSinceEpoch(
                                                            int.parse(data[
                                                                    index]
                                                                .waktuDiajukan))),
                                                    style: TextStyle(
                                                        fontSize: 18)),
                                              ],
                                            )
                                          : Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Text(
                                                    data[index]
                                                        .jenisPinjaman
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 18)),
                                                Text(
                                                    _dateFormater.format(DateTime
                                                        .fromMillisecondsSinceEpoch(
                                                            int.parse(data[
                                                                    index]
                                                                .waktuDiajukan))),
                                                    style: TextStyle(
                                                        fontSize: 18)),
                                              ],
                                            ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          data[index]
                                              .nominalPinjaman
                                              .toString(),
                                          style: TextStyle(
                                              color: kcolorPrimary[900],
                                              fontSize: 25.0),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          data[index].statusPinjaman.toString(),
                                          style: TextStyle(
                                              color: _selectColorStatus(
                                                  data[index].statusPinjaman),
                                              fontSize: 18.0),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          title: Text('Menu'),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              ListTile(
                                                title: Text('Detail Pinjaman'),
                                                onTap: () {
                                                  Navigator.of(context).pop();
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          ManajemenPinjamanPage(
                                                        pinjaman: data[index],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                              Divider(
                                                color: Colors.black87,
                                              ),
                                              ListTile(
                                                title:
                                                    Text('Progress Pengajuan'),
                                                onTap: () {
                                                  Navigator.of(context).pop();
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          ProgressPengajuanPage(
                                                        pinjaman: data[index],
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
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              );
          },
        ),
      ),
    );
  }

  MaterialColor _selectColorStatus(String status) {
    status = status.toLowerCase();
    switch (status) {
      case 'pengajuan':
        return Colors.orange;
      case 'vertifikasi data':
        return Colors.orange;
      case 'tinjauan':
        return Colors.orange;
      case 'survey':
        return Colors.orange;
      case 'akad':
        return Colors.green;
      case 'pencairan':
        return Colors.green;
      case 'ditolak':
        return Colors.red;
    }
  }
}

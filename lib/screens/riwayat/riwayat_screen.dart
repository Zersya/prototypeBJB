import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prototype_bjb/pages/pengajuan/manajemen_pinjaman_page.dart';
import 'package:prototype_bjb/pages/pengajuan/pengajuan_page.dart';
import 'package:prototype_bjb/provider/profile_db.dart';
import 'package:prototype_bjb/utils/colors.dart';
import 'package:prototype_bjb/provider/pinjaman_db.dart';
import 'package:prototype_bjb/utils/constant.dart';
import 'package:provider/provider.dart';

class RiwayatPinjamanPage extends StatefulWidget {
  RiwayatPinjamanPage({Key key}) : super(key: key);

  _RiwayatPinjamanPageState createState() => _RiwayatPinjamanPageState();
}

class _RiwayatPinjamanPageState extends State<RiwayatPinjamanPage> {
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
      body: StreamProvider.value(
        value: _pinjamanProvider.open().asStream(),
        child: Consumer(
          builder: (_, data, child) {
            if (data == null)
              return CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(kColorMain)),
              );
            else
              return SafeArea(
                top: true,
                bottom: true,
                child: StreamProvider.value(
                  value: _pinjamanProvider.getPinjaman().asStream(),
                  child: Consumer<List<Pinjaman>>(
                    builder: (_, data, child) {
                      if (data == null) {
                        return CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Color(kColorMain)),
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
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        shrinkWrap: true,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => ManajemenPinjamanPage(
                                      pinjaman: data[index],
                                    ),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                                  style:
                                                      TextStyle(fontSize: 18)),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                  _dateFormater.format(DateTime
                                                      .fromMillisecondsSinceEpoch(
                                                          int.parse(data[index]
                                                              .waktuDiajukan))),
                                                  style:
                                                      TextStyle(fontSize: 18)),
                                            ],
                                          )
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                  data[index]
                                                      .jenisPinjaman
                                                      .toString(),
                                                  style:
                                                      TextStyle(fontSize: 18)),
                                              Text(
                                                  _dateFormater.format(DateTime
                                                      .fromMillisecondsSinceEpoch(
                                                          int.parse(data[index]
                                                              .waktuDiajukan))),
                                                  style:
                                                      TextStyle(fontSize: 18)),
                                            ],
                                          ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        data[index].nominalPinjaman.toString(),
                                        style: TextStyle(
                                            color: kcolorPrimary[900],
                                            fontSize: 25.0),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              );
          },
        ),
      ),
    );
  }
}

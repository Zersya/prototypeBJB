import 'package:flutter/material.dart';
import 'package:prototype_bjb/provider/pengajuan_db.dart';
import 'package:prototype_bjb/utils/constant.dart';

class ProgressPengajuanPage extends StatefulWidget {
  ProgressPengajuanPage({Key key, this.pengajuan}) : super(key: key);

  final Pengajuan pengajuan;

  _ProgressPengajuanPageState createState() => _ProgressPengajuanPageState();
}

class _ProgressPengajuanPageState extends State<ProgressPengajuanPage> {
  static const double customPadding = 30;
  static const double edgeWidth = 1.5;
  int currentStep = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        bottom: true,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: customPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 25,
              ),
              Text(
                'Progress Pengajuan',
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
              _step('Pengajuan dibuat', 1),
              _line(),
              _step('Pengajuan direview', 2),
              _line(),
              _step('Pengajuan dalam proses vertfikasi', 3),
              _line(),
              _step('Pengajuan berhasil', 4),
            ],
          ),
        ),
      ),
    );
  }

  Row _step(
    String str,
    int index,
  ) {
    return Row(
      children: <Widget>[
        CircleAvatar(
          backgroundColor:
              index == currentStep ? Colors.green : Color(COLOR_MAIN),
          radius: customPadding,
          child: Text(index.toString()),
        ),
        SizedBox(
          width: 30,
        ),
        Text(str)
      ],
    );
  }

  Widget _line() {
    return Expanded(
      flex: 1,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.all(customPadding),
          child: Container(
            width: edgeWidth,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}

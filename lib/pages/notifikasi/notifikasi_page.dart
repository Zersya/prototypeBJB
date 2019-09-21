import 'package:flutter/material.dart';
import 'package:prototype_bjb/utils/colors.dart';

class NotifikasiPage extends StatefulWidget {
  NotifikasiPage({Key key}) : super(key: key);

  _NotifikasiPageState createState() => _NotifikasiPageState();
}

class _NotifikasiPageState extends State<NotifikasiPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Image.asset(
          'assets/images/bank_bjb.png',
          height: MediaQuery.of(context).size.width / 7,
        ),
        centerTitle: true,
        leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(Icons.arrow_back_ios, color: kcolorPrimary[900])),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
          child: Card(
        elevation: 2,
        child: ListTile(
          title: Text('Notifikasi-1'),
          subtitle: Text('Deskripsi-1'),
        ),
      )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:prototype_bjb/pages/dashboard_page.dart';
import 'package:prototype_bjb/provider/profile_db.dart';
import 'package:prototype_bjb/utils/constant.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  ProfileProvider _provider = ProfileProvider();
  @override
  void initState() {
    super.initState();
    _provider.open().whenComplete(() async {
      await _provider.getAccount();

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) =>
              Provider.value(value: _provider, child: DashboardPage()),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/images/bank_bjb.png',
            scale: MediaQuery.of(context).size.width / 100,
          ),
          SizedBox(
            height: 32,
          ),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(COLOR_MAIN)),
          )
        ],
      )),
    );
  }
}

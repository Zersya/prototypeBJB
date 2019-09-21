import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:prototype_bjb/pages/notifikasi/notifikasi_page.dart';
import 'package:prototype_bjb/pages/pengajuan/daftar_pengajuan_page.dart';
import 'package:prototype_bjb/pages/profile/profile_page.dart';
import 'package:prototype_bjb/provider/profile_db.dart';
import 'package:prototype_bjb/screens/riwayat/riwayat_screen.dart';
import 'package:prototype_bjb/utils/colors.dart';
import 'package:prototype_bjb/utils/constant.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage({Key key}) : super(key: key);

  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  ProfileProvider _profileProvider;
  PageController _pageController = PageController();
  bool isAlreadyshowed = false;
  int currentScreen = 0;

  @override
  void initState() {
    super.initState();
    _profileProvider = Provider.of<ProfileProvider>(context, listen: false);

    initializeDateFormatting();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () async {
      if (_profileProvider.profile == null && !isAlreadyshowed)
        showDialog(
          context: context,
          builder: (context) {
            isAlreadyshowed = true;
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              content: FlatButton(
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () async {
                    setState(() {
                      _pageController.animateToPage(4,
                          duration: Duration(milliseconds: 200),
                          curve: Curves.easeInOut);
                      currentScreen = 4;
                      Navigator.of(context).pop();
                    });
                    // await Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (context) => Provider.value(
                    //         value: _profileProvider, child: ProfilePage())));
                  },
                  child: Text('Silahkan isi data profil')),
            );
          },
        );
    });
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(100, 120),
        child: SafeArea(
          top: true,
          child: Container(
            padding: EdgeInsets.all(16.0),
            height: MediaQuery.of(context).size.height / 8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Image.asset(
                  'assets/images/bank_bjb.png',
                  height: MediaQuery.of(context).size.width / 7,
                ),
                Badge(
                  badgeContent: Text(
                    '1',
                    style: TextStyle(color: Colors.white),
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => NotifikasiPage()));
                    },
                    child: Icon(
                      Icons.notifications,
                      size: MediaQuery.of(context).size.width / 12,
                      color: kcolorPrimary[900],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        child: Theme(
          data: Theme.of(context).copyWith(
              canvasColor: kcolorPrimary[900],
              primaryColor: Colors.white,
              textTheme: Theme.of(context)
                  .textTheme
                  .copyWith(caption: new TextStyle(color: Colors.black))),
          child: BottomNavigationBar(
            onTap: (index) {
              setState(() {
                currentScreen = index;
                _pageController.animateToPage(currentScreen,
                    duration: Duration(milliseconds: 200),
                    curve: Curves.easeInOut);
              });
            },
            currentIndex: currentScreen,
            type: MediaQuery.of(context).size.width < kSmallPhone
                ? BottomNavigationBarType.shifting
                : BottomNavigationBarType.fixed,
            backgroundColor: kcolorPrimary[900],
            selectedFontSize: 16,
            items: [
              BottomNavigationBarItem(
                  icon: Image.asset("assets/icons/home.png"),
                  title:
                      Text('Beranda', style: TextStyle(color: Colors.white))),
              BottomNavigationBarItem(
                  icon: Image.asset("assets/icons/money.png"),
                  title:
                      Text('Pinjaman', style: TextStyle(color: Colors.white))),
              BottomNavigationBarItem(
                  icon: Image.asset("assets/icons/credit-card.png"),
                  title:
                      Text('Rekening', style: TextStyle(color: Colors.white))),
              BottomNavigationBarItem(
                  icon: Image.asset("assets/icons/history.png"),
                  title:
                      Text('Riwayat', style: TextStyle(color: Colors.white))),
              BottomNavigationBarItem(
                  icon: Image.asset("assets/icons/user.png"),
                  title: Text('Profil', style: TextStyle(color: Colors.white)))
            ],
          ),
        ),
      ),
      body: SafeArea(
        top: true,
        child: PageView(
          controller: _pageController,
          pageSnapping: true,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            new Home(
              smallPhone: kSmallPhone,
            ),
            DaftarPengajuanPage(),
            Container(child: Center(child: Text('Rekening'))),
            RiwayatPinjamanPage(),
            ProfilePage()
          ],
        ),
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({
    Key key,
    @required this.smallPhone,
  }) : super(key: key);

  final double smallPhone;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (_, index) {
        return Card(
          elevation: 2,
          margin: EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                columnOne(context),
                Divider(color: Colors.black26, height: 20),
                columnTwo()
              ],
            ),
          ),
        );
      },
    );
  }

  Padding columnTwo() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Angsuran Bulan ini',
              style: TextStyle(color: Colors.black54, fontSize: 18.0),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Cicilan ke-14',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Rp475.940',
                    style: TextStyle(color: kcolorPrimary[900], fontSize: 16.0),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Batas akhir bayar',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    '23 Sep 2019',
                    style: TextStyle(color: kcolorPrimary[900], fontSize: 16.0),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Widget columnOne(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'BJB Kredit Mikro Utama',
              style: TextStyle(color: kcolorPrimary[900], fontSize: 18.0),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'Belum Terbayar',
              style: TextStyle(color: Colors.black54, fontSize: 14.0),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'Rp5.000.000',
              style: TextStyle(color: kcolorPrimary[900], fontSize: 25.0),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          rowBuild(context),
          SizedBox(
            height: 12,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: SmoothStarRating(
                allowHalfRating: false,
                onRatingChanged: (v) {},
                starCount: 5,
                rating: 4,
                size: 25.0,
                color: Colors.orange,
                borderColor: Colors.orange,
                spacing: 0.0),
          ),
        ],
      ),
    );
  }

  Widget rowBuild(BuildContext context) {
    if (MediaQuery.of(context).size.width < smallPhone)
      return Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                  width: 20,
                  height: 20,
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: kcolorPrimary[900]),
                  child: Icon(
                    Icons.refresh,
                    color: Colors.white,
                    size: 14,
                  )),
              SizedBox(
                width: 8,
              ),
              Text(
                '11 Kali angsuran lagi',
                style: TextStyle(color: Colors.black54, fontSize: 14.0),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: <Widget>[
              Container(
                width: 20,
                height: 20,
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: kcolorPrimary[900]),
                child: Text(
                  'Rp',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                'Rp475.940/bulan',
                style: TextStyle(color: Colors.black54, fontSize: 14.0),
              ),
            ],
          )
        ],
      );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: kcolorPrimary[900]),
                child: Icon(
                  Icons.refresh,
                  color: Colors.white,
                  size: MediaQuery.of(context).size.width / 25,
                )),
            SizedBox(
              width: 8,
            ),
            Text(
              '11 Kali angsuran lagi',
              style: TextStyle(color: Colors.black54, fontSize: 14.0),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: kcolorPrimary[900]),
              child: Text(
                'Rp',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              'Rp475.940/bulan',
              style: TextStyle(color: Colors.black54, fontSize: 14.0),
            ),
          ],
        )
      ],
    );
  }
}

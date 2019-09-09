import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:prototype_bjb/pages/pengajuan_page.dart';
import 'package:prototype_bjb/pages/profile_page.dart';
import 'package:prototype_bjb/provider/profile_db.dart';
import 'package:prototype_bjb/utils/constant.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage({Key key}) : super(key: key);

  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  ProfileProvider _provider;
  bool isAlreadyshowed = false;

  @override
  void initState() {
    super.initState();
    _provider = Provider.of<ProfileProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () async {
      if (_provider.profile == null && !isAlreadyshowed)
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
                    await Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Provider.value(
                            value: _provider, child: ProfilePage())));
                    Profile _profile = await _provider.getAccount();
                    if (_profile != null) Navigator.of(context).pop();
                  },
                  child: Text('Silahkan isi data profil')),
            );
          },
        );
    });
    return Scaffold(
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: <Widget>[
            SafeArea(
              top: true,
              child: Container(
                padding: EdgeInsets.all(16.0),
                height: MediaQuery.of(context).size.height / 8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Image.asset(
                      'assets/images/bank_bjb.png',
                      scale: MediaQuery.of(context).size.width / 45,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Provider.value(
                                value: _provider, child: ProfilePage())));
                      },
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(color: Colors.black),
                          children: [
                            TextSpan(text: 'Selamat datang\n'),
                            TextSpan(
                              text: _provider.profile?.nama ?? '-',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2.5,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(COLOR_MAIN), Color(COLOR_GRAD)],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'NEWS',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Stack(
                    children: <Widget>[
                      CarouselSlider(
                        height: MediaQuery.of(context).size.height / 3.5,
                        aspectRatio: 16 / 9,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        enableInfiniteScroll: true,
                        items: [1, 2, 3, 4, 5, 6].map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.symmetric(horizontal: 5.0),
                                child: GestureDetector(
                                  onTap: () => _launchURL(i),
                                  child: Card(
                                    child: Image.asset(
                                      'assets/images/img-$i.jpeg',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Builder(
              builder: (context) {
                return Container(
                  padding: EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'FITUR UTAMA',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      ListView(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        children: <Widget>[
                          ListTile(
                            leading: Icon(MdiIcons.fileDocumentOutline),
                            title: Text('Pengajuan kredit',
                                style: TextStyle(color: Colors.black54)),
                            trailing: Icon(Icons.arrow_forward_ios),
                            onTap: () async {
                              if (_provider.profile != null) {
                                final isInsert =
                                    await Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => Provider.value(
                                        value: _provider,
                                        child: PengajuanPage()),
                                  ),
                                );
                                if (isInsert != null)
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        'Berhasil mengajukan kredit, silahkan lihat pada daftar pengajuan kredit'),
                                  ));
                              } else {
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      'Silahkan lengkapi profil terlebih dahulu'),
                                ));
                              }
                            },
                          ),
                          Divider(
                            color: Colors.black87,
                          ),
                          ListTile(
                            leading: Icon(MdiIcons.viewList),
                            title: Text('Daftar pengajuan kredit',
                                style: TextStyle(color: Colors.black54)),
                            trailing: Icon(Icons.arrow_forward_ios),
                          ),
                          Divider(
                            color: Colors.black87,
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  _launchURL(index) async {
    String url;
    switch (index) {
      case 1:
        url = 'https://twitter.com/infobankbjb/status/1011553228696137728';
        break;
      case 2:
        url = 'https://twitter.com/infobankbjb/status/1170170804547403776';
        break;
      case 3:
        url = 'https://twitter.com/infobankbjb/status/1168443843915612161';
        break;
      case 4:
        url = 'https://twitter.com/infobankbjb/status/1168003769503633409';
        break;
      case 5:
        url = 'https://twitter.com/infobankbjb/status/1167986472168779776';
        break;
      case 6:
        url = 'https://twitter.com/infobankbjb/status/1166220870152359936';
        break;
      case 8:
        url = 'https://twitter.com/infobankbjb/status/1165912331114536960';
        break;
    }
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

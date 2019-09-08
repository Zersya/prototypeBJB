import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prototype_bjb/provider/profile_db.dart';
import 'package:prototype_bjb/utils/constant.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

enum TypeImage { ktp, npwp }

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key key}) : super(key: key);

  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  PageController _pageController;
  ProfileProvider _provider;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(
      initialPage: currentPage,
      keepPage: true,
    );
    _provider = Provider.of<ProfileProvider>(context, listen: false);

    if (_provider.profile != null) {
      _provider.controllerNama.text = _provider.profile.nama;
      _provider.controllerAlamat.text = _provider.profile.alamat;
      _provider.controllerNIK.text = _provider.profile.nik;
      _provider.controllerNPWP.text = _provider.profile.npwp;
    }
  }

  @override
  Widget build(BuildContext context) {
    _provider = Provider.of<ProfileProvider>(context);

    return Scaffold(
      bottomNavigationBar: Container(
        color: Color(COLOR_MAIN),
        child: SafeArea(
          bottom: true,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              currentPage == 1
                  ? FlatButton(
                      child: Text(
                        'SEBELUMNYA',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: MediaQuery.of(context).size.width / 26),
                      ),
                      onPressed: () {
                        setState(() {
                          currentPage = 0;
                        });
                        _pageController.previousPage(
                            duration: Duration(milliseconds: 200),
                            curve: Curves.easeInOut);
                      },
                    )
                  : SizedBox(),
              currentPage == 0
                  ? FlatButton(
                      child: Text(
                        'BERIKUTNYA',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: MediaQuery.of(context).size.width / 26),
                      ),
                      onPressed: () {
                        setState(() {
                          currentPage = 1;
                        });
                        _pageController.nextPage(
                            duration: Duration(milliseconds: 200),
                            curve: Curves.easeInOut);
                      },
                    )
                  : SizedBox(),
              currentPage == 1
                  ? FlatButton(
                      child: Text(
                        'SUBMIT',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: MediaQuery.of(context).size.width / 26),
                      ),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                title: Text('Anda yakin ?'),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text('TIDAK'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  FlatButton(
                                    child: Text('IYA'),
                                    onPressed: () async {
                                      await _provider.insert();
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pop();
                                    },
                                  )
                                ],
                              );
                            });
                      },
                    )
                  : SizedBox()
            ],
          ),
        ),
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: <Widget>[new ScreenForm(), new ScreenKTPNpwp()],
      ),
    );
  }
}

class ScreenForm extends StatefulWidget {
  ScreenForm({Key key}) : super(key: key);

  _ScreenFormState createState() => _ScreenFormState();
}

class _ScreenFormState extends State<ScreenForm> {
  final _formKey = GlobalKey<FormState>();
  ProfileProvider _provider;

  @override
  Widget build(BuildContext context) {
    _provider = Provider.of<ProfileProvider>(context);

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
                backgroundColor: Color(COLOR_MAIN),
                radius: 70.0,
                child: _provider.profile == null
                    ? Icon(
                        Icons.person,
                        color: Colors.white,
                        size: MediaQuery.of(context).size.width / 5,
                      )
                    : Text(
                        '${_provider.profile.nama[0].toUpperCase()} ${_provider.profile.nama[_provider.profile.nama.length - 1].toUpperCase()}',
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width / 8),
                      )),
            SizedBox(
              height: MediaQuery.of(context).size.width / 8,
            ),
            TextFormField(
              controller: _provider.controllerNama,
              decoration: InputDecoration(labelText: 'Nama'),
            ),
            TextFormField(
              controller: _provider.controllerAlamat,
              decoration: InputDecoration(labelText: 'Alamat'),
            ),
            TextFormField(
              controller: _provider.controllerNIK,
              decoration: InputDecoration(labelText: 'NIK'),
              keyboardType: TextInputType.number,
              inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
            ),
            TextFormField(
              controller: _provider.controllerNPWP,
              decoration: InputDecoration(labelText: 'NPWP'),
              keyboardType: TextInputType.number,
              inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
            )
          ],
        ),
      ),
    );
  }
}

class ScreenKTPNpwp extends StatefulWidget {
  @override
  _ScreenKTPNpwpState createState() => _ScreenKTPNpwpState();
}

class _ScreenKTPNpwpState extends State<ScreenKTPNpwp> {
  ProfileProvider _provider;

  File _imageKTP;
  File _imageNPWP;

  Uint8List bytesKTP;
  Uint8List bytesNPWP;

  @override
  void initState() {
    super.initState();
    _provider = Provider.of<ProfileProvider>(context, listen: false);

    if (_provider.profile != null) {
      bytesKTP = base64Decode(_provider.profile.imgktp);
      bytesNPWP = base64Decode(_provider.profile.imgnpwp);
    }
  }

  _ktpWidget() {
    if (bytesKTP == null) {
      return _imageKTP == null
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.add_a_photo),
                SizedBox(
                  height: 15.0,
                ),
                Text('KTP anda')
              ],
            )
          : Image.file(_imageKTP, fit: BoxFit.cover);
    } else {
      return Image.memory(bytesKTP, fit: BoxFit.cover);
    }
  }

  _npwpWidget() {
    if (bytesKTP == null) {
      return _imageKTP == null
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.add_a_photo),
                SizedBox(
                  height: 15.0,
                ),
                Text('NPWP anda')
              ],
            )
          : Image.file(_imageNPWP, fit: BoxFit.cover);
    } else {
      return Image.memory(bytesKTP, fit: BoxFit.cover);
    }
  }

  @override
  Widget build(BuildContext context) {
    _provider = Provider.of<ProfileProvider>(context);

    return Center(
      child: SafeArea(
        top: true,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    flex: 2,
                    child: Text(
                      'Upload KTP dan NPWP',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 21.0,
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.black,
                    height: 30.0,
                  ),
                  Flexible(
                    flex: 2,
                    child: Card(
                      elevation: 4.0,
                      child: InkWell(
                        onTap: () async {
                          await showChoices(TypeImage.ktp);
                        },
                        child: Center(child: _ktpWidget()),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Card(
                      elevation: 4.0,
                      child: InkWell(
                        onTap: () async {
                          await showChoices(TypeImage.npwp);
                        },
                        child: Center(child: _npwpWidget()),
                      ),
                    ),
                  )
                ],
              ),
              Align(
                alignment: Alignment.topRight,
                child: FloatingActionButton(
                  elevation: 4.0,
                  mini: true,
                  child: Icon(Icons.help),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Text('Silahkan upload KTP dan NPWP anda'),
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

  Future getImage(ImageSource _imageSource) async {
    final image = await ImagePicker.pickImage(source: _imageSource);
    return image;
  }

  Future showChoices(TypeImage _type) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: Text('Pilih sumber'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text('Camera'),
                onTap: () async {
                  Navigator.of(context).pop();

                  if (_type == TypeImage.ktp) {
                    _imageKTP = await getImage(ImageSource.camera);
                    _provider.decodeImage(_imageKTP, TypeImage.ktp);
                  } else if (_type == TypeImage.npwp) {
                    _imageNPWP = await getImage(ImageSource.camera);
                    _provider.decodeImage(_imageNPWP, TypeImage.npwp);
                  }
                  setState(() {});
                },
              ),
              Divider(
                color: Colors.black87,
              ),
              ListTile(
                title: Text('Gallery'),
                onTap: () async {
                  Navigator.of(context).pop();

                  if (_type == TypeImage.ktp) {
                    _imageKTP = await getImage(ImageSource.gallery);
                    _provider.decodeImage(_imageKTP, TypeImage.ktp);
                  } else if (_type == TypeImage.npwp) {
                    _imageNPWP = await getImage(ImageSource.gallery);
                    _provider.decodeImage(_imageNPWP, TypeImage.npwp);
                  }

                  setState(() {});
                },
              )
            ],
          ),
        );
      },
    );
  }
}

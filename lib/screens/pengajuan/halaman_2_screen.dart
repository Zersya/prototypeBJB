import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prototype_bjb/provider/pinjaman_db.dart';
import 'package:prototype_bjb/provider/profile_db.dart';
import 'package:provider/provider.dart';

class Halaman2Screen extends StatefulWidget {
  Halaman2Screen({Key key}) : super(key: key);

  _Halaman2ScreenState createState() => _Halaman2ScreenState();
}

class _Halaman2ScreenState extends State<Halaman2Screen> {
  ProfileProvider _profileProvider;
  PinjamanProvider _pinjamanProvider;


  @override
  Widget build(BuildContext context) {
    _profileProvider = Provider.of<ProfileProvider>(context);
    _pinjamanProvider = Provider.of<PinjamanProvider>(context);

    return Scaffold(
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Unggah Berkas',
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
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Unggah Rekening Koran',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 18.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1.2, color: Colors.black38)),
                  child: Column(
                    children: <Widget>[
                      Card(
                        elevation: 4.0,
                        child: InkWell(
                          onTap: () async {
                            await showChoices(0);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Center(
                              child: _pinjamanProvider.rekeningKoran == null
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(Icons.add_a_photo),
                                        SizedBox(
                                          height: 15.0,
                                        ),
                                        Text('Rekening Koran Anda')
                                      ],
                                    )
                                  : Image.file(_pinjamanProvider.rekeningKoran,
                                      fit: BoxFit.cover),
                            ),
                          ),
                        ),
                      ),
                      Card(
                        elevation: 4.0,
                        child: InkWell(
                          onTap: () async {
                            await showChoices(0);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Center(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.add_box),
                                SizedBox(
                                  height: 15.0,
                                ),
                                Text('Tambah Berkas')
                              ],
                            )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Unggah Surat Keterangan Usaha',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 18.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1.2, color: Colors.black38)),
                  child: Column(
                    children: <Widget>[
                      Card(
                        elevation: 4.0,
                        child: InkWell(
                          onTap: () async {
                            await showChoices(1);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Center(
                              child: _pinjamanProvider.suratKeterangan == null
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(Icons.add_a_photo),
                                        SizedBox(
                                          height: 15.0,
                                        ),
                                        Text('Surat Keterangan Usaha Anda')
                                      ],
                                    )
                                  : Image.file(_pinjamanProvider.suratKeterangan,
                                      fit: BoxFit.cover),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Unggah Surat Ijin Usaha Pedagang',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 18.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1.2, color: Colors.black38)),
                  child: Column(
                    children: <Widget>[
                      Card(
                        elevation: 4.0,
                        child: InkWell(
                          onTap: () async {
                            await showChoices(2);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Center(
                              child: _pinjamanProvider.suratIzinUsaha == null
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(Icons.add_a_photo),
                                        SizedBox(
                                          height: 15.0,
                                        ),
                                        Text('Surat Ijin Usaha anda')
                                      ],
                                    )
                                  : Image.file(_pinjamanProvider.suratIzinUsaha,
                                      fit: BoxFit.cover),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future getImage(ImageSource _imageSource) async {
    final image = await ImagePicker.pickImage(source: _imageSource);
    return image;
  }

  Future showChoices(int type) {
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
                  switch (type) {
                    case 0:
                      _pinjamanProvider.rekeningKoran = await getImage(ImageSource.camera);
                      break;
                    case 1:
                      _pinjamanProvider.suratKeterangan = await getImage(ImageSource.camera);
                      break;
                    case 2:
                      _pinjamanProvider.suratIzinUsaha = await getImage(ImageSource.camera);
                      break;
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

                  switch (type) {
                    case 0:
                      _pinjamanProvider.rekeningKoran = await getImage(ImageSource.gallery);
                      break;
                    case 1:
                      _pinjamanProvider.suratKeterangan = await getImage(ImageSource.gallery);
                      break;
                    case 2:
                      _pinjamanProvider.suratIzinUsaha = await getImage(ImageSource.gallery);
                      break;
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

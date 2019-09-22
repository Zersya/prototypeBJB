import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prototype_bjb/provider/pinjaman_db.dart';
import 'package:provider/provider.dart';

class Halaman2Screen extends StatefulWidget {
  Halaman2Screen({Key key}) : super(key: key);

  _Halaman2ScreenState createState() => _Halaman2ScreenState();
}

class _Halaman2ScreenState extends State<Halaman2Screen> {
  PinjamanProvider _pinjamanProvider;

  @override
  Widget build(BuildContext context) {
    _pinjamanProvider = Provider.of<PinjamanProvider>(context);

    return Scaffold(
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                
                InkWell(
                  onTap: () async {
                    await showChoices(0);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                        child: _pinjamanProvider.rekeningKoran == null
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text('Rekening Koran Anda'),
                                  SizedBox(
                                    width: 15.0,
                                  ),
                                  Image.asset("assets/icons/photo-camera.png"),
                                ],
                              )
                            : Column(
                                children: <Widget>[
                                  Text('Rekening Koran Anda'),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  Image.file(_pinjamanProvider.rekeningKoran,
                                      fit: BoxFit.cover),
                                ],
                              )),
                  ),
                ),
                Divider(
                  height: 20,
                  color: Colors.black38,
                ),
                InkWell(
                  onTap: () async {
                    await showChoices(1);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                        child: _pinjamanProvider.suratKeterangan == null
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text('Surat Keterangan Usaha (SKU)'),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  Image.asset("assets/icons/photo-camera.png"),
                                ],
                              )
                            : Column(
                                children: <Widget>[
                                  Text('Surat Keterangan Usaha (SKU)'),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  Image.file(_pinjamanProvider.suratKeterangan,
                                      fit: BoxFit.cover),
                                ],
                              )),
                  ),
                ),
                Divider(
                  height: 20,
                  color: Colors.black38,
                ),
                InkWell(
                  onTap: () async {
                    await showChoices(2);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                        child: _pinjamanProvider.suratIzinUsaha == null
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text('Surat Ijin Usaha Pedagang (SIUP)'),
                                  SizedBox(
                                    width: 15.0,
                                  ),
                                  Image.asset("assets/icons/photo-camera.png"),
                                ],
                              )
                            : Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text('Surat Ijin Usaha Pedagang (SIUP)'),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  Image.file(_pinjamanProvider.suratIzinUsaha,
                                      fit: BoxFit.cover),
                                ],
                              )),
                  ),
                ),
                Divider(
                  height: 20,
                  color: Colors.black38,
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
                      _pinjamanProvider.rekeningKoran =
                          await getImage(ImageSource.camera);
                      break;
                    case 1:
                      _pinjamanProvider.suratKeterangan =
                          await getImage(ImageSource.camera);
                      break;
                    case 2:
                      _pinjamanProvider.suratIzinUsaha =
                          await getImage(ImageSource.camera);
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
                      _pinjamanProvider.rekeningKoran =
                          await getImage(ImageSource.gallery);
                      break;
                    case 1:
                      _pinjamanProvider.suratKeterangan =
                          await getImage(ImageSource.gallery);
                      break;
                    case 2:
                      _pinjamanProvider.suratIzinUsaha =
                          await getImage(ImageSource.gallery);
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

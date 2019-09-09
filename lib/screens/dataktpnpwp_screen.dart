import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prototype_bjb/provider/profile_db.dart';
import 'package:provider/provider.dart';

enum TypeImage { ktp, npwp }

class DataKtpNpwpScreen extends StatefulWidget {
  @override
  _DataKtpNpwpScreenState createState() => _DataKtpNpwpScreenState();
}

class _DataKtpNpwpScreenState extends State<DataKtpNpwpScreen> {
  ProfileProvider _provider;

  Uint8List bytesKTP;
  Uint8List bytesNPWP;

  @override
  void initState() {
    super.initState();
    _provider = Provider.of<ProfileProvider>(context, listen: false);

    if (_provider.profile != null) {
      if (_provider.profile.imgktp != null)
        bytesKTP = base64Decode(_provider.profile.imgktp);
      if (_provider.profile.imgnpwp != null)
        bytesNPWP = base64Decode(_provider.profile.imgnpwp);
    }
  }

  _ktpWidget() {
    if (_provider.imageKtp == null) {
      return bytesKTP == null
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
          : Image.memory(bytesKTP, fit: BoxFit.cover);
    } else {
      return Image.file(_provider.imageKtp, fit: BoxFit.cover);
    }
  }

  _npwpWidget() {
    if (_provider.imageNpwp == null) {
      return bytesNPWP == null
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
          : Image.memory(bytesNPWP, fit: BoxFit.cover);
    } else {
      return Image.file(_provider.imageNpwp, fit: BoxFit.cover);
    }
  }

  @override
  Widget build(BuildContext context) {
    _provider = Provider.of<ProfileProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Align(
            //   alignment: Alignment.topRight,
            //   child: FloatingActionButton(
            //     elevation: 4.0,
            //     mini: true,
            //     child: Icon(Icons.help),
            //     onPressed: () {
            //       showDialog(
            //         context: context,
            //         builder: (context) {
            //           return AlertDialog(
            //             content: Text('Silahkan upload KTP dan NPWP anda'),
            //           );
            //         },
            //       );
            //     },
            //   ),
            // ),
            Text(
              'Upload KTP dan NPWP',
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
            Card(
              elevation: 4.0,
              child: InkWell(
                onTap: () async {
                  await showChoices(TypeImage.ktp);
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(child: _ktpWidget()),
                ),
              ),
            ),
            Card(
              elevation: 4.0,
              child: InkWell(
                onTap: () async {
                  await showChoices(TypeImage.npwp);
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(child: _npwpWidget()),
                ),
              ),
            )
          ],
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
                    _provider.setImageKtp = await getImage(ImageSource.camera);
                  } else if (_type == TypeImage.npwp) {
                    _provider.setImageNpwp = await getImage(ImageSource.camera);
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
                    _provider.setImageKtp = await getImage(ImageSource.gallery);
                  } else if (_type == TypeImage.npwp) {
                    _provider.setImageNpwp =
                        await getImage(ImageSource.gallery);
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

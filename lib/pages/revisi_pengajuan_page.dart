import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prototype_bjb/provider/pengajuan_db.dart';
import 'package:prototype_bjb/provider/profile_db.dart';
import 'package:prototype_bjb/screens/pengajuan/termsandcondition_screen.dart';
import 'package:prototype_bjb/utils/constant.dart';
import 'package:provider/provider.dart';

class RevisiPengajuanPage extends StatefulWidget {
  RevisiPengajuanPage({Key key}) : super(key: key);

  _RevisiPengajuanPageState createState() => _RevisiPengajuanPageState();
}

class _RevisiPengajuanPageState extends State<RevisiPengajuanPage> {
  ProfileProvider _profileProvider;
  PengajuanProvider _pengajuanProvider;

  final _controllerTujuan = TextEditingController();

  int currentStep = 0;
  bool isTermsAgree = false;

  Future getImage(ImageSource _imageSource) async {
    final image = await ImagePicker.pickImage(source: _imageSource);
    return image;
  }

  Future showChoices() {
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

                  _pengajuanProvider.image = await getImage(ImageSource.camera);

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

                  _pengajuanProvider.image =
                      await getImage(ImageSource.gallery);

                  setState(() {});
                },
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _profileProvider = Provider.of<ProfileProvider>(context);
    _pengajuanProvider = Provider.of<PengajuanProvider>(context);

    return Scaffold(
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 25,
              ),
              Text(
                'Pengajuan Kredit',
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
              Stepper(
                currentStep: currentStep,
                controlsBuilder: (BuildContext context,
                    {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
                  return Row(
                    children: <Widget>[
                      FlatButton(
                        onPressed: currentStep == 4
                            ? () {
                                if (isTermsAgree) {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return _alertDialog();
                                      });
                                } else {
                                  Scaffold.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'Harap setujui syarat dan ketentuan'),
                                    ),
                                  );
                                }
                              }
                            : onStepContinue,
                        color: Color(COLOR_MAIN),
                        child: Text(
                          currentStep == 4 ? 'Konfirmasi' : 'Berikutnya',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      if (currentStep != 0)
                        FlatButton(
                          onPressed: onStepCancel,
                          child: const Text('Kembali'),
                        ),
                    ],
                  );
                },
                physics: ScrollPhysics(),
                onStepTapped: (index) {
                  setState(() {
                    currentStep = index;
                  });
                },
                onStepContinue: () {
                  setState(() {
                    currentStep++;
                  });
                },
                onStepCancel: () {
                  if (currentStep > 0)
                    setState(() {
                      currentStep--;
                    });
                },
                steps: [
                  Step(
                    title: Text('Produk Pinjaman'),
                    isActive: currentStep == 0,
                    state: StepState.indexed,
                    content: SizedBox(
                      width: double.infinity,
                      child: DropdownButton(
                        underline: Divider(
                          height: 1.5,
                          color: Colors.black87,
                        ),
                        hint: Text('Pilih Produk'),
                        value: _pengajuanProvider.productSelected,
                        items: <DropdownMenuItem>[
                          DropdownMenuItem(
                            child: Text('Produk-1'),
                            value: 'Produk-1',
                          ),
                          DropdownMenuItem(
                            child: Text('Produk-2'),
                            value: 'Produk-2',
                          ),
                          DropdownMenuItem(
                            child: Text('Produk-3'),
                            value: 'Produk-3',
                          )
                        ],
                        onChanged: (value) {
                          setState(() {
                            _pengajuanProvider.productSelected = value;
                          });
                        },
                      ),
                    ),
                  ),
                  Step(
                    title: Text('Tujuan Pinjaman'),
                    isActive: currentStep == 1,
                    state: StepState.indexed,
                    content: TextFormField(
                      controller: _controllerTujuan,
                      decoration:
                          InputDecoration(hintText: 'Masukan Tujuan Pinjaman'),
                    ),
                  ),
                  Step(
                    title: Text('Nominal Pinjaman'),
                    isActive: currentStep == 2,
                    state: StepState.indexed,
                    content: TextFormField(
                      controller: _pengajuanProvider.controllerNominal,
                      inputFormatters: [
                        WhitelistingTextInputFormatter.digitsOnly
                      ],
                      keyboardType: TextInputType.number,
                      decoration:
                          InputDecoration(hintText: 'Masukan Nominal Pinjaman'),
                    ),
                  ),
                  Step(
                    title: Text('Upload Rekening Koran'),
                    isActive: currentStep == 3,
                    state: StepState.indexed,
                    content: Card(
                      elevation: 4.0,
                      child: InkWell(
                        onTap: () async {
                          await showChoices();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Center(
                            child: _pengajuanProvider.image == null
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(Icons.add_a_photo),
                                      SizedBox(
                                        height: 15.0,
                                      ),
                                      Text('Rekening Koran Anda')
                                    ],
                                  )
                                : Image.file(_pengajuanProvider.image,
                                    fit: BoxFit.cover),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Step(
                    title: Text('Syarat dan Ketentuan'),
                    isActive: currentStep == 4,
                    state: StepState.indexed,
                    content: Column(
                      children: <Widget>[
                        Card(
                          elevation: 4.0,
                          child: InkWell(
                            onTap: () async {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      contentPadding: EdgeInsets.all(8),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                      content: SingleChildScrollView(
                                        child: Container(
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              border: Border.all(
                                                  color: Colors.black87)),
                                          child: Text(
                                            LOREM_IPSUM_TERMS,
                                            textAlign: TextAlign.justify,
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                      '${LOREM_IPSUM_TERMS.substring(0, 400)}....',
                                      textAlign: TextAlign.justify,
                                    ),
                                  ),
                                  Divider(
                                    height: 16.0,
                                  ),
                                  Icon(Icons.open_in_new)
                                ],
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Checkbox(
                              onChanged: (bool value) {
                                setState(() {
                                  isTermsAgree = value;
                                });
                              },
                              value: isTermsAgree,
                            ),
                            Text('Saya setuju dengan syarat dan ketentuan')
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  AlertDialog _alertDialog() {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: Text('Konfrimasi'),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          color: Colors.grey,
          child: Text(
            'Batal',
            style: TextStyle(color: Colors.white),
          ),
        ),
        FlatButton(
          onPressed: () {
            _pengajuanProvider.insert(
                _profileProvider.profile,
                _controllerTujuan.text,
                _pengajuanProvider.controllerNominal.text);
            Navigator.of(context).pop();
            Navigator.of(context).pop(true);
          },
          color: Color(COLOR_MAIN),
          child: Text(
            'Ajukan',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          itemRekap(
            1,
            'Produk Pinjaman',
            Text(
              _pengajuanProvider.productSelected,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Divider(
            color: Colors.black54,
          ),
          itemRekap(
            2,
            'Tujuan Pinjaman',
            Text(
              _controllerTujuan.text,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Divider(
            color: Colors.black54,
          ),
          itemRekap(
              3,
              'Nominal Pinjaman',
              Text(
                _pengajuanProvider.controllerNominal.text,
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
          Divider(
            color: Colors.black54,
          ),
          itemRekap(
            4,
            'Rekening Koran',
            Card(
              elevation: 4.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child:
                      Image.file(_pengajuanProvider.image, fit: BoxFit.cover),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  ListTile itemRekap(int index, String title, Widget child) {
    return ListTile(
        leading: CircleAvatar(
          radius: 12,
          backgroundColor: Color(COLOR_MAIN),
          child: Text(index.toString()),
        ),
        title: Text(title),
        subtitle: child);
  }
}

import 'package:flutter/material.dart';
import 'package:prototype_bjb/provider/pinjaman_db.dart';
import 'package:prototype_bjb/utils/constant.dart';

class ProgressPengajuanPage extends StatefulWidget {
  ProgressPengajuanPage({Key key, this.pinjaman}) : super(key: key);

  final Pinjaman pinjaman;

  _ProgressPengajuanPageState createState() => _ProgressPengajuanPageState();
}

class _ProgressPengajuanPageState extends State<ProgressPengajuanPage> {
  static const double customPadding = 30;
  static const double edgeWidth = 1.5;
  int currentStep = 1;

  @override
  Widget build(BuildContext context) {
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
                'Progress Status',
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
              Theme(
                data: ThemeData(primaryColor: Colors.green),
                child: Stepper(
                  currentStep: currentStep,
                  controlsBuilder: (BuildContext context,
                      {VoidCallback onStepContinue,
                      VoidCallback onStepCancel}) {
                    return Container();
                  },
                  physics: ScrollPhysics(),
                  steps: [
                    Step(
                      isActive: true,
                      state: StepState.complete,
                      title: Text('Pengajuan'),
                      subtitle: Text('10 Sep 2019',
                          style:
                              TextStyle(fontSize: 12, color: Colors.black54)),
                      content: Container(),
                    ),
                    Step(
                      isActive: true,
                      state: StepState.error,
                      title: Text('Vertifikasi Data'),
                      subtitle: Text('10 Sep 2019',
                          style:
                              TextStyle(fontSize: 12, color: Colors.black54)),
                      content: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.red,
                          ),
                          child: Text('Lengkapi Data',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white)),
                        ),
                      ),
                    ),
                    Step(
                      isActive: true,
                      state: StepState.complete,
                      title: Text('Tinjauan'),
                      subtitle: Text('10 Sep 2019',
                          style:
                              TextStyle(fontSize: 12, color: Colors.black54)),
                      content: Container(),
                    ),
                    Step(
                      title: Text('Survey'),
                      content: Container(),
                    ),
                    Step(
                      title: Text('Akad'),
                      content: Container(),
                    ),
                    Step(
                      title: Text('Pencairan'),
                      content: Container(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  LayoutBuilder oldProgress() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SafeArea(
          top: true,
          bottom: true,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: customPadding),
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    minWidth: constraints.maxWidth,
                    minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
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
            ),
          ),
        );
      },
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
              index == currentStep ? Colors.green : Color(kColorMain),
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

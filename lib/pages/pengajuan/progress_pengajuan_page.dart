import 'package:flutter/material.dart';
import 'package:prototype_bjb/provider/pinjaman_db.dart';
import 'package:prototype_bjb/utils/colors.dart';
import 'package:prototype_bjb/utils/constant.dart';

enum ProgressState { progress, done, error }

class ProgressPengajuanPage extends StatefulWidget {
  ProgressPengajuanPage({Key key, this.pinjaman}) : super(key: key);

  final Pinjaman pinjaman;

  _ProgressPengajuanPageState createState() => _ProgressPengajuanPageState();
}

class _ProgressPengajuanPageState extends State<ProgressPengajuanPage> {
  double customPadding = 10;
  double edgeWidth = 1;
  int currentStep = 2;

  @override
  Widget build(BuildContext context) {
    customPadding = MediaQuery.of(context).size.width / 25;

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
        body: oldProgress());
  }

  Theme newProgress() {
    return Theme(
      data: ThemeData(primaryColor: Colors.green),
      child: Stepper(
        currentStep: currentStep,
        controlsBuilder: (BuildContext context,
            {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
          return Container();
        },
        physics: ScrollPhysics(),
        steps: [
          Step(
            isActive: true,
            state: StepState.complete,
            title: Text('Pengajuan'),
            subtitle: Text('10 Sep 2019',
                style: TextStyle(fontSize: 12, color: Colors.black54)),
            content: Container(),
          ),
          Step(
            isActive: true,
            state: StepState.error,
            title: Text('Vertifikasi Data'),
            subtitle: Text('10 Sep 2019',
                style: TextStyle(fontSize: 12, color: Colors.black54)),
            content: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.red,
                ),
                child: Text('Lengkapi Data',
                    style: TextStyle(fontSize: 12, color: Colors.white)),
              ),
            ),
          ),
          Step(
            isActive: true,
            state: StepState.complete,
            title: Text('Tinjauan'),
            subtitle: Text('10 Sep 2019',
                style: TextStyle(fontSize: 12, color: Colors.black54)),
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
    );
  }

  LayoutBuilder oldProgress() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: customPadding),
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
                    _step('Pengajuan', 1, ProgressState.done),
                    _step('Vertifikasi Data', 2, ProgressState.error),
                    _step('Tinjauan', 3, ProgressState.done),
                    _step('Taksasi', 4, ProgressState.progress),
                    _step('Akad', 5, ProgressState.progress),
                    _step('Pencairan', 6, ProgressState.progress),
                    SizedBox(
                      height: 25,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _step(String str, int index, ProgressState state) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              width: customPadding * 2,
              height: customPadding * 2,
              decoration: BoxDecoration(
                  color: colorState(state),
                  borderRadius: BorderRadius.circular(30)),
              child: Align(
                  alignment: Alignment.center,
                  child: circleState(state, index)),
            ),
            if(index != 6)_line()
          ],
        ),
        SizedBox(
          width: 15,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(str,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(
              '10 Sep 2019',
              style: TextStyle(fontSize: 12, color: Colors.black54),
            ),
            state == ProgressState.error
                ? FlatButton(
                    color: Colors.orange,
                    textColor: Colors.white,
                    child: Text(
                      'Lengkapi Data',
                    ),
                    onPressed: () {},
                  )
                : Container()
          ],
        )
      ],
    );
  }

  Widget circleState(ProgressState state, index) {
    if (state == ProgressState.done)
      return Icon(
        Icons.check,
        color: Colors.white,
      );
    if (state == ProgressState.error)
      return Icon(
        Icons.info,
        color: Colors.white,
      );
    else
      return Text(
        index.toString(),
        style: TextStyle(color: Colors.white),
      );
  }

  Color colorState(ProgressState state) {
    if (state == ProgressState.done) return Colors.green;
    if (state == ProgressState.error)
      return Colors.orange;
    else
      return Colors.grey;
  }

  Widget _line() {
    return Container(
      height: 100,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.all(customPadding),
          child: Container(
            width: edgeWidth,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }
}

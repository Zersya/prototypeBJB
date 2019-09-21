import 'package:flutter/material.dart';
import 'package:prototype_bjb/provider/pinjaman_db.dart';
import 'package:provider/provider.dart';

class TermsAndConditionScreen extends StatefulWidget {
  TermsAndConditionScreen({Key key}) : super(key: key);

  _TermsAndConditionScreenState createState() =>
      _TermsAndConditionScreenState();
}

class _TermsAndConditionScreenState extends State<TermsAndConditionScreen> {
  PinjamanProvider _pinjamanProvider;

  @override
  Widget build(BuildContext context) {
    _pinjamanProvider = Provider.of<PinjamanProvider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 25,
            ),
            Text(
              'Ketentuan Layanan',
              style: TextStyle(fontSize: 21),
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                LOREM_IPSUM_TERMS,
                textAlign: TextAlign.justify,
              ),
            ),
            Row(
              children: <Widget>[
                Checkbox(
                  onChanged: (bool value) {
                    setState(() {
                      _pinjamanProvider.isTermsAgree = value;
                    });
                  },
                  value: _pinjamanProvider.isTermsAgree,
                ),
                Text('Saya menyetujuinya')
              ],
            )
          ],
        ),
      ),
    );
  }
}

const LOREM_IPSUM_TERMS = '''
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Condimentum vitae sapien pellentesque habitant morbi. At ultrices mi tempus imperdiet nulla. Odio aenean sed adipiscing diam donec adipiscing tristique. Vitae congue mauris rhoncus aenean vel elit scelerisque mauris pellentesque. Nec ultrices dui sapien eget. Potenti nullam ac tortor vitae. Egestas integer eget aliquet nibh praesent tristique magna sit. Semper risus in hendrerit gravida rutrum quisque non. Sed blandit libero volutpat sed. Non curabitur gravida arcu ac. Tristique senectus et netus et malesuada fames ac turpis egestas. Nec ultrices dui sapien eget mi proin sed libero. Id leo in vitae turpis massa sed elementum tempus egestas. Posuere ac ut consequat semper viverra nam libero. Aliquam nulla facilisi cras fermentum odio.

Nec ultrices dui sapien eget. Eu nisl nunc mi ipsum faucibus. Odio euismod lacinia at quis risus sed vulputate odio ut. Elementum facilisis leo vel fringilla est ullamcorper eget nulla. Sit amet justo donec enim diam vulputate ut. Consectetur purus ut faucibus pulvinar elementum integer enim neque volutpat. Metus dictum at tempor commodo ullamcorper a lacus. Id donec ultrices tincidunt arcu non sodales. Diam volutpat commodo sed egestas egestas fringilla. Etiam tempor orci eu lobortis. Id interdum velit laoreet id donec ultrices tincidunt arcu non. Nibh mauris cursus mattis molestie a iaculis.

Dignissim convallis aenean et tortor at risus viverra adipiscing at. Molestie nunc non blandit massa enim nec dui nunc mattis. Sed risus ultricies tristique nulla aliquet enim tortor at. Morbi non arcu risus quis varius quam quisque. Mattis aliquam faucibus purus in. Laoreet id donec ultrices tincidunt arcu non sodales. Sodales neque sodales ut etiam sit. Nulla facilisi nullam vehicula ipsum a. Ornare aenean euismod elementum nisi quis eleifend. Nibh praesent tristique magna sit amet. Risus at ultrices mi tempus. Dui nunc mattis enim ut tellus elementum.

Et egestas quis ipsum suspendisse. Rhoncus aenean vel elit scelerisque mauris pellentesque pulvinar pellentesque. In tellus integer feugiat scelerisque varius morbi. Dictum fusce ut placerat orci nulla pellentesque dignissim enim sit. Sed risus pretium quam vulputate dignissim suspendisse in est ante. Est ullamcorper eget nulla facilisi etiam. Pellentesque diam volutpat commodo sed egestas egestas. Sed viverra ipsum nunc aliquet. Ornare arcu dui vivamus arcu felis. Neque laoreet suspendisse interdum consectetur libero id faucibus nisl. Amet porttitor eget dolor morbi. Elit pellentesque habitant morbi tristique senectus et netus et. Donec et odio pellentesque diam volutpat commodo sed egestas egestas. Aenean euismod elementum nisi quis eleifend quam adipiscing. Elementum sagittis vitae et leo duis ut diam quam. Quis enim lobortis scelerisque fermentum dui faucibus. Tellus cras adipiscing enim eu.

Vivamus arcu felis bibendum ut. Aliquet bibendum enim facilisis gravida neque. Ac odio tempor orci dapibus ultrices in. Senectus et netus et malesuada fames ac. In iaculis nunc sed augue lacus viverra vitae congue. Neque viverra justo nec ultrices dui sapien. Quisque sagittis purus sit amet. Cursus sit amet dictum sit amet justo. Urna duis convallis convallis tellus id interdum velit. Adipiscing vitae proin sagittis nisl rhoncus mattis rhoncus. Nec feugiat in fermentum posuere urna nec tincidunt praesent semper. Eu non diam phasellus vestibulum lorem sed. Viverra maecenas accumsan lacus vel facilisis volutpat est velit egestas. Non curabitur gravida arcu ac. Donec enim diam vulputate ut pharetra sit amet aliquam. Rhoncus est pellentesque elit ullamcorper dignissim cras tincidunt lobortis. Eget dolor morbi non arcu risus quis varius.

Donec ultrices tincidunt arcu non sodales. Ut sem viverra aliquet eget sit amet tellus. Ipsum dolor sit amet consectetur adipiscing elit ut aliquam. Lorem ipsum dolor sit amet consectetur adipiscing elit ut aliquam. Nisl nisi scelerisque eu ultrices vitae auctor eu augue ut. Tincidunt augue interdum velit euismod in pellentesque massa placerat. Facilisis leo vel fringilla est ullamcorper. Gravida neque convallis a cras. Quam vulputate dignissim suspendisse in. Eget nunc lobortis mattis aliquam faucibus purus in massa tempor. Turpis egestas sed tempus urna et pharetra pharetra. Lorem sed risus ultricies tristique nulla aliquet enim tortor at. Elementum tempus egestas sed sed risus pretium. Sit amet consectetur adipiscing elit duis tristique.

Vestibulum rhoncus est pellentesque elit ullamcorper. Dapibus ultrices in iaculis nunc sed. Sit amet cursus sit amet dictum. Convallis tellus id interdum velit laoreet id donec. Urna porttitor rhoncus dolor purus. Egestas congue quisque egestas diam in. Eget nulla facilisi etiam dignissim diam quis enim lobortis scelerisque. Massa placerat duis ultricies lacus sed turpis tincidunt. A cras semper auctor neque vitae tempus quam pellentesque nec. Ut pharetra sit amet aliquam id. Vestibulum morbi blandit cursus risus at ultrices mi tempus. Eget lorem dolor sed viverra ipsum nunc aliquet. A iaculis at erat pellentesque adipiscing commodo elit at. Sed ullamcorper morbi tincidunt ornare massa eget egestas. Tristique risus nec feugiat in fermentum posuere urna.

Elit scelerisque mauris pellentesque pulvinar pellentesque habitant morbi tristique senectus. Adipiscing elit pellentesque habitant morbi tristique. Nunc sed blandit libero volutpat sed cras ornare. Imperdiet nulla malesuada pellentesque elit eget gravida cum sociis. Ac tortor dignissim convallis aenean et tortor. Senectus et netus et malesuada fames ac turpis egestas integer. Rhoncus aenean vel elit scelerisque mauris pellentesque pulvinar. Molestie a iaculis at erat. Sed risus ultricies tristique nulla aliquet enim tortor at. Porta nibh venenatis cras sed felis. Viverra aliquet eget sit amet tellus.

Sed elementum tempus egestas sed sed. Placerat in egestas erat imperdiet. Viverra accumsan in nisl nisi scelerisque eu ultrices vitae auctor. Donec adipiscing tristique risus nec feugiat in. Mi in nulla posuere sollicitudin aliquam ultrices sagittis orci a. Tristique et egestas quis ipsum. Sed nisi lacus sed viverra tellus. Tincidunt arcu non sodales neque. Eu mi bibendum neque egestas. Suspendisse faucibus interdum posuere lorem ipsum dolor sit. Sagittis eu volutpat odio facilisis mauris sit amet massa. Non pulvinar neque laoreet suspendisse interdum consectetur libero. Sed augue lacus viverra vitae. Enim lobortis scelerisque fermentum dui faucibus.

Phasellus vestibulum lorem sed risus ultricies. Et magnis dis parturient montes. Quis viverra nibh cras pulvinar mattis nunc sed blandit libero. Volutpat maecenas volutpat blandit aliquam etiam erat velit. Elementum nibh tellus molestie nunc non blandit massa. Facilisis sed odio morbi quis commodo odio aenean sed adipiscing. Dolor sit amet consectetur adipiscing elit pellentesque habitant morbi tristique. Id aliquet lectus proin nibh nisl condimentum id venenatis. Odio tempor orci dapibus ultrices in iaculis nunc. Nibh venenatis cras sed felis eget velit aliquet sagittis id. Blandit volutpat maecenas volutpat blandit aliquam etiam erat.

''';

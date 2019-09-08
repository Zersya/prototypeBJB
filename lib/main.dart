import 'package:flutter/material.dart';
import 'package:prototype_bjb/screens/dashboard_screen.dart';
import 'package:prototype_bjb/screens/splash_screen.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          DashboardScreen(),
          Container(
            child: Center(child: Text('2')),
          ),
          Container(
            child: Center(child: Text('3')),
          ),
          Container(
            child: Center(child: Text('4')),
          ),
          Container(
            child: Center(child: Text('5')),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        currentIndex: pageIndex,
        onTap: (index) {
          setState(() {
            pageIndex = index;

            _pageController.animateToPage(
              pageIndex,
              curve: Curves.easeInOut,
              duration: Duration(milliseconds: 300),
            );
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.black),
              title: Text('Home', textAlign: TextAlign.center, style: TextStyle(color: Colors.black))),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today, color: Colors.black),
              title:
                  Text('My Organizer', textAlign: TextAlign.center, style: TextStyle(color: Colors.black))),
          BottomNavigationBarItem(
              icon: Icon(Icons.person, color: Colors.black),
              title: Text('Profile', textAlign: TextAlign.center, style: TextStyle(color: Colors.black))),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.message,
                color: Colors.black,
              ),
              title: Text('Pesan', textAlign: TextAlign.center, style: TextStyle(color: Colors.black))),
          BottomNavigationBarItem(
              icon: Icon(Icons.help, color: Colors.black),
              title: Text('Bantuan', textAlign: TextAlign.center, style: TextStyle(color: Colors.black))),
        ],
      ),
    );
  }
}

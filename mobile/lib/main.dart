import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'var.dart';
import 'pages/home.dart';
import 'pages/scan.dart';
import 'pages/send.dart';

void main() async {
  // Be sure to add this line if `PackageInfo.fromPlatform()`,`availableCameras()` is called before runApp()
  WidgetsFlutterBinding.ensureInitialized();
  PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
    appName = packageInfo.appName;
    version = packageInfo.version;
  });
  cameras = await availableCameras();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName, // used by the OS task switcher
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _curPageIndex = 0;
  List<Widget> bodyList_ = [];

  @override
  void initState() {
    bodyList_
      ..add(const HomePage())
      ..add(const ScanPage())
      ..add(const SendPage());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            _curPageIndex = index;
          });
        },
        selectedIndex: _curPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          NavigationDestination(
            icon: Icon(Icons.camera_alt),
            selectedIcon: Icon(Icons.camera_alt_outlined),
            label: 'Scan',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.qr_code_rounded),
            icon: Icon(Icons.qr_code_rounded),
            label: 'Send',
          ),
        ],
      ),
      body: Center(
        child: bodyList_[_curPageIndex],
      ),
    );
  }
}

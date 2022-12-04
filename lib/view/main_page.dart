import 'package:flutter/material.dart';
import 'package:here/view/activity/activity_page.dart';
import 'package:here/view/activity/badge_widget.dart';
import 'package:here/view/calendar/calendar_page.dart';
import 'package:here/view/home/home_page.dart';
import 'package:here/view/profile/profile_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _pageIndex = 0; // for indexed stack
  int _selectedIndex = 0; // for navigation bar
  bool hasNotifications = false; // TODO: make it functional

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      bottomNavigationBar: _bottomBar,
      body: SafeArea(
        child: IndexedStack(
          index: _pageIndex,
          children: const <Widget>[
            HomePage(),
            CalendarPage(),
            ActivityPage(),
            ProfilePage(),
          ],
        ),
      ),
    );
  }

  AppBar get _appBar => AppBar(
        title: const Text('Here!'),
        centerTitle: true,
      );

  void _onTapNavigationBar(int value) {
    setState(() {
      _selectedIndex = value;

      if (value > 2) value--; // skip qr button
      _pageIndex = value;
    });
  }

  Widget get _bottomBar => NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onTapNavigationBar,
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        destinations: [
          const NavigationDestination(
              icon: Icon(Icons.home_filled), label: 'Home'),
          const NavigationDestination(
              icon: Icon(Icons.calendar_month), label: 'Calendar'),
          _qrScannerButton,
          NavigationDestination(
              icon: hasNotifications
                  ? const Badge(child: Icon(Icons.notifications))
                  : const Icon(Icons.notifications),
              label: 'Activity'),
          const NavigationDestination(
              icon: Icon(Icons.person_rounded), label: 'Profile'),
        ],
      );

  void _handleQrScanButton() {
    Navigator.of(context).pushNamed('/qr_scan');
  }

  Widget get _qrScannerButton => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: FloatingActionButton(
            elevation: 0,
            onPressed: _handleQrScanButton,
            child: const Icon(Icons.qr_code_scanner)),
      );
}

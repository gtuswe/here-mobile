import 'package:flutter/material.dart';
import 'package:here/view/activity/activity_page.dart';
import 'package:here/view/authenticate/wrapper.dart';
import 'package:here/view/calendar/calendar_page.dart';
import 'package:here/view/home/home_page.dart';
import 'package:here/view/main_page.dart';
import 'package:here/view/profile/profile_page.dart';
import 'package:here/view/qr/qr_scan_view.dart';

const rootURL = '/';
const homeURL = '/home';
const calendarURL = '/calendar';
const qrScanURL = '/qr_scan';
const activityURL = '/activity';
const profileURL = '/profile';
const mainURL = '/main';

class Routes {
  static final routes = <String, WidgetBuilder>{
    rootURL: (context) => Wrapper(),
    mainURL: (context) => const MainPage(),
    homeURL: (context) => const HomePage(),
    calendarURL: (context) => const CalendarPage(),
    qrScanURL: (context) => const QrScanView(),
    activityURL: (context) => const ActivityPage(),
    profileURL: (context) => const ProfilePage(),
  };
}

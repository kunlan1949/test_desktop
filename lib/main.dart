import 'dart:io';
import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:path/path.dart' as p;
import 'package:system_tray/system_tray.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_desktop/pages/download_page.dart';
import 'package:test_desktop/pages/local_music_page.dart';
import 'package:test_desktop/pages/main_page.dart';
import 'package:test_desktop/pages/music_playing_page.dart';
import 'package:test_desktop/pages/music_sheet_page.dart';
import 'package:test_desktop/pages/top_list_page.dart';
import 'AnimatedButton/transition_types.dart';
import 'HYSizeFit.dart';
import 'Windows/app_window.dart';
import 'Windows/widgets/window_border.dart';
import 'Windows/widgets/window_button.dart';
import 'Windows/widgets/window_caption.dart';
import 'AnimatedButton/animated_but.dart';
import 'flip/flip_num_text.dart';
import 'fluttery_audio.dart';
import 'model/LocalModel/menu_bar_title_model.dart';
import 'pages/ratio_page.dart';
import 'r.dart';
import 'visualizer_painter.dart';

void main() async {
  runApp(const MyApp());

  doWhenWindowReady(() {
    final win = appWindow;
    // const initialSize = Size(1225.w, 750.h);
    win.minSize = Size(1600.w, 1000.h);
    win.size = Size(1600.w, 1000.h);
    win.alignment = Alignment.center;
    win.title = "How to use system tray with Flutter";
    win.show();
  });
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final SystemTray _systemTray = SystemTray();
  Timer? _timer;
  bool _toogleTrayIcon = true;

  @override
  void initState() {
    super.initState();
    initSystemTray();
  }

  @override
  void dispose() {
    super.dispose();
    // _timer?.cancel();
  }

  Future<void> initSystemTray() async {
    String path;
    if (Platform.isWindows) {
      path = p.joinAll([
        p.dirname(Platform.resolvedExecutable),
        'data\\flutter_assets\\assets',
        'app_icon.ico'
      ]);
    } else if (Platform.isMacOS) {
      path = p.joinAll(['AppIcon']);
    } else {
      path = p.joinAll([
        p.dirname(Platform.resolvedExecutable),
        'data\\flutter_assets\\assets',
        'music.png'
      ]);
    }

    print(path);
    // We first init the systray menu and then add the menu entries
    await _systemTray.initSystemTray("system tray",
        iconPath: path, toolTip: "菜菜音乐");

    await _systemTray.setContextMenu(
      [
        MenuItem(
          label: 'Show',
          onClicked: () {
            appWindow.show();
          },
        ),
        MenuSeparator(),
        SubMenu(
          label: "SubMenu",
          children: [
            MenuItem(
              label: 'SubItem1',
              enabled: false,
              onClicked: () {
                print("click SubItem1");
              },
            ),
            MenuItem(label: 'SubItem2'),
            MenuItem(label: 'SubItem3'),
          ],
        ),
        MenuSeparator(),
        MenuItem(
          label: 'Exit',
          onClicked: () {
            appWindow.close();
          },
        ),
      ],
    );

    // flash tray icon
    // _timer = Timer.periodic(
    //   const Duration(milliseconds: 500),
    //       (timer) {
    //     _toogleTrayIcon = !_toogleTrayIcon;
    //     _systemTray.setSystemTrayInfo(
    //       iconPath: _toogleTrayIcon ? "" : path,
    //     );
    //   },
    // );

    // handle system tray event
    _systemTray.registerSystemTrayEventHandler((eventName) {
      print("eventName: $eventName");
    });
  }

  @override
  Widget build(BuildContext context) {
    HYSizeFit.initialize();
    return ScreenUtilInit(
        designSize: const Size(1920, 1080),
        builder: () => MaterialApp(
          theme: ThemeData(
              scrollbarTheme: ScrollbarThemeData(
                  isAlwaysShown: false,
                  trackBorderColor:MaterialStateProperty.all(Color(0xff8df8d8)),
                  thickness: MaterialStateProperty.all(10),
                  thumbColor: MaterialStateProperty.all(Color(0xffe1e1e1)),
                  radius: Radius.circular(10),
                  minThumbLength: 100)),

              debugShowCheckedModeBanner: false,
              home: MainPage()
            ));
  }


}

// class LeftSide extends StatefulWidget {
//   int? position;
//   LeftSide(position, {Key? key}) : super(key: key);
//
//   @override
//   _LeftSideState createState() {
//     return _LeftSideState();
//   }
// }
//
// class _LeftSideState extends State<LeftSide> {
//
//
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return ;
//   }
//
//
// }

Widget mainPageView(int selectedIndex) {
  Widget? mainPage;
  switch (selectedIndex) {
    case 0:
      mainPage = MusicPlayingPage();
      break;
    case 1:
      mainPage =  MusicSheetPage();
      break;
    case 2:
      mainPage = TopListPage();
      //NotifictionPage();
      break;
    case 3:
      mainPage = RadioPage();
      break;
    case 4:
      mainPage = DownLoadPage();
      break;
    case 5:
      mainPage = LocalMusicPage();
      break;
  }
  return mainPage!;
}




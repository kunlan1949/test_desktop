import 'dart:io';
import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:path/path.dart' as p;
import 'package:system_tray/system_tray.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'HYSizeFit.dart';
import 'Windows/app_window.dart';
import 'Windows/widgets/window_border.dart';
import 'Windows/widgets/window_button.dart';
import 'Windows/widgets/window_caption.dart';
import 'flip/flip_num_text.dart';

void main() async {
  runApp(const MyApp());

  doWhenWindowReady(() {
    final win = appWindow;
    // const initialSize = Size(1225.w, 750.h);
    win.minSize = Size(1600.w, 900.h);
    win.size = Size(1600.w, 900.h);
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
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                body: WindowBorder(
                    color: const Color(0xFF805306),
                    width: 1,
                    child: Stack(children: [
                      ConstrainedBox(
                        constraints: const BoxConstraints.expand(),
                        child: Image.network(
                          'https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=2496571732,442429806&fm=26&gp=0.jpg',
                        fit: BoxFit.fill,
                        ),
                      ),
                      Center(
                          child: ClipRect(
                        // 可裁切矩形
                        child: BackdropFilter(
                          // 背景过滤器
                          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                          child: Opacity(
                            opacity: 0.5,
                            child: Container(
                              alignment: Alignment.center,
                              height: double.infinity,
                              width: double.infinity,
                              decoration:
                                  BoxDecoration(color: Colors.grey.shade500),
                              child: Text(
                                'Janise',
                              ),
                            ),
                          ),
                        ),
                      )),
                      Row(
                        children: [
                          LeftSide(),
                          const RightSide(),
                        ],
                      ),
                    ])),
              ),
            ));
  }
}

class LeftSide extends StatefulWidget {
  LeftSide({Key? key}) : super(key: key);

  @override
  _LeftSideState createState() {
    return _LeftSideState();
  }
}

class _LeftSideState extends State<LeftSide> {
  late Duration time;
  int seconds = 0;
  Timer? countdownTimer;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SizedBox(
      width: 200,
      child: Container(
        child: Column(
          children: [
            WindowTitleBarBox(
              child: Container(
                child: MoveWindow(),
              ),
            ),
            Expanded(
              child: Container(
                child: Column(
                  children: [
                    RaisedButton(
                      child: Text("开始"),
                      onPressed: () {
                        setState(() {
                          seconds = 10;
                        });
                        countdownTimer =
                            Timer.periodic(const Duration(seconds: 1), (timer) {
                          if (seconds > 0) {
                            setState(() {
                              seconds--;
                            });
                          } else {
                            countdownTimer!.cancel();
                            countdownTimer = null;
                          }
                        });
                      },
                    ),
                    Text(
                      seconds.toString(),
                      style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                    //FlipNumText(seconds, 10),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class RightSide extends StatelessWidget {
  const RightSide({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Column(
          children: [
            WindowTitleBarBox(
              child: Container(
                child: Row(
                  children: [
                    Expanded(
                      child: MoveWindow(),
                    ),
                    const WindowButtons()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final buttonColors = WindowButtonColors(
    iconNormal: const Color(0xFF805306),
    mouseOver: const Color(0xFFF6A00C),
    mouseDown: const Color(0xFF805306),
    iconMouseOver: const Color(0xFF805306),
    iconMouseDown: const Color(0xFFFFD500));

final closeButtonColors = WindowButtonColors(
    mouseOver: const Color(0xFFD32F2F),
    mouseDown: const Color(0xFFB71C1C),
    iconNormal: const Color(0xFF805306),
    iconMouseOver: Colors.white);

class WindowButtons extends StatelessWidget {
  const WindowButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MinimizeWindowButton(colors: buttonColors),
        MaximizeWindowButton(colors: buttonColors),
        HideWindowButton(
          colors: closeButtonColors,
        )
        //CloseWindowButton(colors: closeButtonColors),
      ],
    );
  }
}

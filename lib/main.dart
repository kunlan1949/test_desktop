import 'dart:io';
import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:path/path.dart' as p;
import 'package:system_tray/system_tray.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_desktop/pages/download_page.dart';
import 'package:test_desktop/pages/local_music_page.dart';
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
  late Duration time;
  int seconds = 0;
  Timer? countdownTimer;
  bool isEnter = false;
  bool f = false;
  int? selectIndex;
  List<MenuBarTitleModel> titleList = [
    MenuBarTitleModel("正在播放", R.assetsImgNowplaying),
    MenuBarTitleModel("歌单", R.assetsImgMusicsheet),
    MenuBarTitleModel("榜单", R.assetsImgToplist),
    MenuBarTitleModel("电台", R.assetsImgRadio),
    MenuBarTitleModel("下载", R.assetsImgDownload),
    MenuBarTitleModel("本地", R.assetsImgLocalmusic)
  ];
  @override
  void initState() {
    super.initState();
    initSystemTray();
    selectIndex = 0;
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
              home: Scaffold(
                body: WindowBorder(
                    color: const Color(0xFF805306),
                    width: 1,
                    child: Stack(
                        children: [
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
                          filter: ImageFilter.blur(sigmaX: 45.0, sigmaY: 15.0),
                          child: Opacity(
                            opacity: 0.7,
                            child: Container(
                              alignment: Alignment.center,
                              height: double.infinity,
                              width: double.infinity,
                              decoration:
                                  BoxDecoration(color: Color(0xff4c4949)),
                              child: const Text(
                                'Janise',
                              ),
                            ),
                          ),
                        ),
                      )),
                      Row(
                          children: [
                            MouseRegion(
                              onEnter: (event) {
                                setState(() {
                                  isEnter = true;
                                });
                              },
                              onExit: (event) {
                                setState(() {
                                  isEnter = false;
                                });
                              },
                              child: SizedBox(
                                width: 130.w,
                                child: Container(
                                  child: Column(
                                    children: [
                                      // WindowTitleBarBox(
                                      //   child: Container(
                                      //     child: MoveWindow(),
                                      //   ),
                                      // ),
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            gradient: isEnter
                                                ? const LinearGradient(
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.bottomRight,
                                                    colors: [
                                                      Color(0x52B4B6B4),
                                                      Color(0x23B4B6B4),
                                                    ],
                                                  )
                                                : const LinearGradient(
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.bottomRight,
                                                    colors: [
                                                      Color(0x52646665),
                                                      Color(0x207D7D7D),
                                                    ],
                                                  ),
                                          ),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 35.0),
                                                child: ListView.builder(
                                                  shrinkWrap: true,
                                                  physics: NeverScrollableScrollPhysics(),
                                                  itemBuilder: (context, index) {
                                                    return _fileItemBuilder(
                                                        index);
                                                  },
                                                  itemCount: titleList.length,
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
                              ),
                            ),
                            Expanded(
                                child: ListView(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
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

                                    Container(
                                      height: 1200.h,
                                        child:  mainPageView(selectIndex!)),

                                  ],

                              ),
                            )
                          ],
                        ),

                    ])),
              ),
            ));
  }

  Widget _fileItemBuilder(int index) {
    return GestureDetector(
      onTapDown: (e) {
        setState(() {
          selectIndex = index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Column(
            children: [
              ImageIcon(
                AssetImage(titleList[index].iconPath!),
                size: selectIndex == index ? 50.r : 30.r,
                color: selectIndex == index
                    ? Color(0xCD53D4FF)
                    : Color(0xC8303132),
              ),
              Container(
                child: Text(
                  titleList[index].title!,
                  style: TextStyle(
                    color: selectIndex == index
                        ? Color(0xCD53D4FF)
                        : Color(0x6A71B2C4),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
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

class RightSide extends StatefulWidget {
  RightSide({Key? key}) : super(key: key);

  @override
  _RightSideState createState() {
    return _RightSideState();
  }
}

class _RightSideState extends State<RightSide> {
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
    return Expanded(
      child: Container(
        child: Stack(
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Flexible(fit: FlexFit.loose, child: mainPageView(0)),
            ),
            // Container(
            //   width: double.infinity,
            //   height: 125.0,
            //   child:  Visualizer(
            //       builder: (BuildContext context, List<int> fft) {
            //         return  CustomPaint(
            //           painter:  VisualizerPainter(
            //             fft: fft,
            //             height: 125.0,
            //             color: Colors.red,
            //           ),
            //           child: new Container(),
            //         );
            //       }),
            // ),
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

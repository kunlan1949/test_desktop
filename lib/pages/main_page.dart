import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:test_desktop/Windows/widgets/window_border.dart';
import 'package:test_desktop/Windows/widgets/window_button.dart';
import 'package:test_desktop/Windows/widgets/window_caption.dart';
import 'package:test_desktop/model/LocalModel/menu_bar_title_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../r.dart';
import 'package:navigation_history_observer/navigation_history_observer.dart';

import 'bar/music_player_bar.dart';
import 'download_page.dart';
import 'local_music_page.dart';
import 'music_playing_page.dart';
import 'music_sheet_page.dart';
import 'ratio_page.dart';
import 'top_list_page.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() {
    return _MainPageState();
  }
}

extension on Page {
  String get route => describeEnum(this);
}

enum Page {
  mpp,
  msp,
  tlp,
  rp,
  dlp,
  lmp,
}

class _MainPageState extends State<MainPage> {
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
    MenuBarTitleModel("下载", R.assetsImgDownloads),
    MenuBarTitleModel("本地", R.assetsImgLocalmusic)
  ];

  int historyCount = 0;
  int poppedCount = 0;

  int moveIndex = 0;
  List<String>? adddList;
  final NavigationHistoryObserver historyObserver = NavigationHistoryObserver();
  @override
  void initState() {
    super.initState();
    selectIndex = 0;
  }

  @override
  void dispose() {
    super.dispose();
  }

  final Map<Page, Widget> _fragments = {
    Page.mpp: MusicPlayingPage(),
    Page.msp: MusicSheetPage(),
    Page.tlp: TopListPage(),
    Page.rp: RadioPage(),
    Page.dlp: DownLoadPage(),
    Page.lmp: LocalMusicPage(),
  };

  void moveToPage(GlobalObjectKey<NavigatorState> navigatorKey, int index) {
    navigatorKey.currentState!.pushReplacementNamed(adddList![index]);
  }

  void AddPage() {
    if (!historyObserver.history[0].settings.name!
        .toString()
        .contains(adddList![adddList!.length - 1])) {
      adddList!.add(historyObserver.history[0].settings.name!);
      moveIndex = adddList!.length - 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    final navigatorKey = GlobalObjectKey<NavigatorState>(context);
    // TODO: implement build
    return Scaffold(
      body: WindowBorder(
          color: const Color(0xFF805306),
          width: 1,
          child: Stack(alignment: Alignment.topCenter, children: [
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
                    decoration: BoxDecoration(color: Color(0xff4c4949)),
                    child: const Text(
                      'Janise',
                    ),
                  ),
                ),
              ),
            )),
            Container(
              height: 80,
              child: Stack(
                children: [
                  WindowTitleBarBox(
                    height: 80.h,
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
                    height: 100.h,
                    child: Row(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 120.0, top: 5),
                              child: ConstrainedBox(
                                constraints: const BoxConstraints(
                                    maxHeight: 30, maxWidth: 250),
                                child: TextField(
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 4.0),
                                    hintText: '请输入搜索内容',
                                    prefixIcon: const Icon(Icons.search),
                                    // contentPadding: EdgeInsets.all(10),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: BorderSide.none),
                                    filled: true,
                                    fillColor: const Color(0xffaaaaaa),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        ConstrainedBox(
                          constraints: BoxConstraints.tightFor(
                              width: 35.w, height: 35.h),
                          child: ElevatedButton(
                            child: const Text(
                              'GO',
                              style: TextStyle(fontSize: 18),
                            ),
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              shadowColor: Colors.transparent,
                              shape: const CircleBorder(),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 40.w,
                        ),
                        ConstrainedBox(
                          constraints: BoxConstraints.tightFor(
                              width: 35.w, height: 35.h),
                          child: ElevatedButton(
                            child: const Text(
                              'GO',
                              style: TextStyle(fontSize: 18),
                            ),
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              shadowColor: Colors.transparent,
                              shape: CircleBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:EdgeInsets.only(bottom: 120.0.h),
              child: Row(
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
                                      padding: const EdgeInsets.only(top: 35.0),
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return _fileItemBuilder(
                                              navigatorKey, index);
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
                        Padding(
                          padding: const EdgeInsets.only(left: 18.0, right: 8),
                          child: Container(
                            height: 900.h,
                            child: Navigator(
                              key: navigatorKey,
                              observers: [NavigationHistoryObserver()],
                              initialRoute: Page.mpp.route,
                              onGenerateRoute: (settings) {
                                final pageName = settings.name;

                                final page = _fragments.keys.firstWhere(
                                    (element) =>
                                        describeEnum(element) == pageName);

                                return MaterialPageRoute(
                                    settings: settings,
                                    builder: (context) => _fragments[page]!);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 120.h,
                child: MusicPlayerBar()
              ),
            )
          ])),
    );
  }

  Widget _fileItemBuilder(
      GlobalObjectKey<NavigatorState> navigatorKey, int index) {
    return GestureDetector(
      onTapDown: (e) {
        setState(() {
          selectIndex = index;
          navigatorKey.currentState!
              .pushReplacementNamed(Page.values[selectIndex!].route);
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

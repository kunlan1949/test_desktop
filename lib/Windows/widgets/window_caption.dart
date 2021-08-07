import 'package:flutter/widgets.dart';
import '../app_window.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class _MoveWindow extends StatelessWidget {
  _MoveWindow({Key? key, this.child}) : super(key: key);
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onPanStart: (details) {
          appWindow.startDragging();
        },
        onDoubleTap: () => appWindow.maximizeOrRestore(),
        child: this.child ?? Container());
  }
}

class MoveWindow extends StatelessWidget {
  final Widget? child;
  MoveWindow({Key? key, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (child == null) return _MoveWindow();
    return _MoveWindow(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Expanded(child: this.child!)]),
    );
  }
}

class WindowTitleBarBox extends StatelessWidget {
  final Widget? child;
  double? height = 0;
  WindowTitleBarBox({Key? key, this.child,this.height}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return Container();
    }
    double titlebarHeight = 0;
    if(height!.toInt()<= 0){
       titlebarHeight = appWindow.titleBarHeight ;
    }else{
      titlebarHeight = height!;
    }
    return SizedBox(height: titlebarHeight, child: this.child ?? Container());
  }
}

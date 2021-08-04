import 'dart:ui';

class HYSizeFit {
  static double? physicalWidth;
  static double? physicalHeight;
  static double? screenWidth;
  static double? screenHeight;
  static double? dpr;
  static double? statusHeight;

  static double? rpx;
  static double? px;

  static void initialize({standardSize = 750}) {
//    1. 手机的物理分辨率
    physicalWidth = window.physicalSize.width; // 拿到物理的宽度
    physicalHeight = window.physicalSize.height;

//    2. 求出dpr
    dpr = window.devicePixelRatio;

//    3. 求出逻辑的宽高
    screenWidth = physicalWidth! / dpr!;
    screenHeight = physicalHeight! /dpr!;

//    4. 状态栏高度
    statusHeight = window.padding.top / dpr!;

//    5. 计算rpx
    rpx = screenWidth! / standardSize;
    px = screenWidth! / standardSize * 2;
  }

  static double setRpx(double size) {
    return size * rpx!;
  }

  static double setPx(double size) {
    return size * px!;
  }
}

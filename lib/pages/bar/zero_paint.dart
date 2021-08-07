import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'audio_video_progress_bar.dart';
class ZeroPaint extends StatefulWidget {
  double? radius;
  ZeroPaint({Key? key, this.radius}) : super(key: key);

  @override
  _ZeroPaintState createState() {
    return _ZeroPaintState();
  }
}

num degToRad(num deg) => deg * (pi / 180.0);
num radToDeg(num rad) => rad * (180.0 / pi);

class _ZeroPaintState extends State<ZeroPaint> {
  double? x, y;
  @override
  void initState() {
    super.initState();
    x = 0;
    y = 0;
  }

  double height = 40;
  @override
  void dispose() {
    super.dispose();
  }

  void _updateLocation(PointerEvent details) {
    setState(() {
      x = details.position.dx;
      y = details.position.dy;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            child: Column(
              children: [
                Text("x=" + x!.toStringAsFixed(2)),
                Text("y=" + y!.toStringAsFixed(2))
              ],
            ),
          ),
        ),
        Expanded(
          flex: 8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ProgressBar(progress:  Duration(minutes: 1), total: Duration(minutes: 3),),
              MouseRegion(
                  onEnter: (e) {
                    setState(() {
                      height = 100;
                    });
                  },
                  onHover: (e) {
                    _updateLocation(e);
                  },
                  child: Container(
                    color: Colors.grey,
                    width: double.infinity,
                    height: 200,
                    child: Padding(
                      padding: const EdgeInsets.only(top:10.0,bottom: 10),
                      child: MouseRegion(
                        onExit:  (e) {
                          setState(() {
                            height = 40;
                          });
                        },
                        child: Container(
                          color: Colors.red,
                          height: height,
                          child: height>40 ? CustomPaint(
                            painter: ClockPainter(
                              x: x,
                              y: y,
                              borderWidth: 5,
                              borderColor: Colors.black,
                              radius: widget.radius!,
                            ),
                            size: Size(widget.radius! * 2, widget.radius! * 2),
                          ):Container(),
                        ),
                      ),
                    ),
                  )),
              Container()
            ],
          ),
        ),
      ],
    );
  }
}

class ClockPainter extends CustomPainter {
  Color? borderColor;
  double? borderWidth;
  double? radius;
  double? x, y;

  ClockPainter(
      {this.borderWidth, this.radius, this.borderColor, this.x, this.y});

  double? w, h;
  @override
  void paint(Canvas canvas, Size size) {
    //draw border
    final borderPaint = Paint()
      ..color = borderColor!
      ..style = PaintingStyle.fill
      ..strokeWidth = borderWidth!;
    // canvas.drawCircle(
    //     Offset(radius!.r, radius!.r), radius!.r - borderWidth!.r / 2, borderPaint);
    w = x!.toInt() - 100;
    h = y!;
    // canvas.drawCircle(Offset(w!,h!),radius!.r - borderWidth!.r / 2, borderPaint);
    canvas.drawRect(
        Rect.fromCenter(
          center: Offset(w!, size.height / 2),
          width: 30,
          height: size.height,
        ),
        borderPaint);
  }

  @override
  bool shouldRepaint(ClockPainter oldDelegate) {
    return true;
  }
}

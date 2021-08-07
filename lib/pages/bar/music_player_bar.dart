import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class MusicPlayerBar extends StatefulWidget {
  MusicPlayerBar({Key? key}) : super(key: key);

  @override
  _MusicPlayerBarState createState() {
    return _MusicPlayerBarState();
  }
}

class _MusicPlayerBarState extends State<MusicPlayerBar> {
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
      height: 120.h,
      child: Row(
        children:  [
          Container(
            color: Colors.teal,
          ),
          Row(children: [

          ],)
        ],
      ),
    );
  }
}
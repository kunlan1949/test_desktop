import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_seekbar/flutter_advanced_seekbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:octo_image/octo_image.dart';
import 'package:test_desktop/r.dart';
import 'package:test_desktop/widgets/marquee_text.dart';

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
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0x608C96A3),
                Color(0x37505757),
              ],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 70.0.w),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Row(
                      children: [
                        ClipOval(
                          child: SizedBox(
                            width: 85.w,
                            height: 85.h,
                            child: OctoImage(
                              image: const CachedNetworkImageProvider(
                                  'https://blurha.sh/assets/images/img2.jpg'),
                              placeholderBuilder: OctoPlaceholder.blurHash(
                                'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
                              ),
                              errorBuilder: OctoError.icon(color: Colors.red),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 30.w,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: const MarqueeText(
                                  child: Text(
                                    "This is a really longer and useless text",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              MarqueeText(
                                child: Text("无名/wingsssssadadadasasas"),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                    flex: 4,
                    child: Padding(
                      padding: EdgeInsets.only(top:24.0.r),
                      child: Column(
                        children: [
                          Container(),
                          Expanded(
                            flex: 7,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: ImageIcon(
                                      AssetImage(R.assetsImgSingleLoop),size: 55.r,color: Color(
                                      0xbfd5d5d5),),
                                ),
                                SizedBox(
                                  width: 35.w,
                                ),
                                Container(
                                  child: ImageIcon(AssetImage(R.assetsImgBack),size: 60.r,color: Color(
                                      0xbfd5d5d5),),
                                ),
                                SizedBox(
                                  width: 35.w,
                                ),
                                Container(
                                  child: ImageIcon(AssetImage(R.assetsImgPlay),size: 75.r,color: Color(
                                      0xbfd5d5d5),),
                                ),
                                SizedBox(
                                  width: 35.w,
                                ),
                                Container(
                                  child: ImageIcon(AssetImage(R.assetsImgNext),size: 60.r,color: Color(
                                      0xbfd5d5d5),),
                                ),
                                SizedBox(
                                  width: 35.w,
                                ),
                                Container(
                                  child: ImageIcon(AssetImage(R.assetsImgLyric,),size: 55.r,color: Color(
                                      0xbfd5d5d5),),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 6,
                            child: Padding(
                              padding:
                                  EdgeInsets.only(left: 88.0.r, right: 88.0.r),
                              child: AdvancedSeekBar(
                                Color(0xbfd5d5d5),
                                10,
                                Color(0xffb2e5e2),
                                lineHeight: 5,
                                defaultProgress: 0,
                                scaleWhileDrag: true,
                                percentSplit: 0,
                                percentSplitColor: Colors.green,
                                percentSplitWidth: 1,
                                seekBarStarted: () {},
                                seekBarProgress: (v) {},
                                seekBarFinished: (v) {},
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
                Expanded(
                  flex: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      border: new Border.all(width: 1, color: Colors.green),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

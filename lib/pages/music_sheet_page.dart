import 'dart:convert';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:async/async.dart' show AsyncMemoizer;
import 'package:test_desktop/http/address.dart';
import 'package:test_desktop/http/data_helper.dart';
import 'package:test_desktop/http/http_manager.dart';
import 'package:test_desktop/http/result_data.dart';
import 'package:test_desktop/model/ApiModel/personal_song_sheet.dart';
class MusicSheetPage extends StatefulWidget {
  const MusicSheetPage({Key? key}) : super(key: key);

  @override
  _MusicSheetPageState createState() {
    return _MusicSheetPageState();
  }
}

class _MusicSheetPageState extends State<MusicSheetPage> {
  final AsyncMemoizer _memoization = AsyncMemoizer<PersonalSongSheet>();

  PersonalSongSheet? songSheetList;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
  Future<PersonalSongSheet> _getSongSheetList() async {
    var params = DataHelper.getBaseMap();
    params.clear();
    ResultData res = await HttpManager.getInstance().get(
        Address.getMusicSheet,withLoading: false
    );
    Map userMap = json.decode(res.data.toString());
    songSheetList = PersonalSongSheet.fromJson(userMap);
    return songSheetList!;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Column(
      children: [
        FutureBuilder(
            builder: _songSheetListFuture,
            future: _memoization.runOnce(_getSongSheetList),
          ),
        SizedBox(
          height: 10.h,
        )
      ],
    );
  }
  Widget _songSheetListFuture(BuildContext context, AsyncSnapshot snapshot) {
    switch (snapshot.connectionState) {
      case ConnectionState.none:
        return const Text('还没开始网络请求');
      case ConnectionState.active:
        return const Text('ConnectionState.active');
      case ConnectionState.waiting:
        return const Center(child: Text("加载中...") //CircularProgressIndicator(),
        );
      case ConnectionState.done:
        if (snapshot.hasError) {
          print("File Get Data ERROR=>" + snapshot.error.toString());
          return const Center(child: Text("错误"));
        } //return Text('Error: ${snapshot.error}');
        return _createSongSheetListView(context, snapshot);
      default:
        return const Center(
          child: Text("yes"),
        );
    }
  }
  Widget _createSongSheetListView(BuildContext context, AsyncSnapshot snapshot) {
    Widget? SongSheetWidget;

    if (snapshot.hasData) {
      PersonalSongSheet? list = snapshot.data;
      SongSheetWidget =  Container(
        height: 980.h,
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 1
          ),
          itemCount: list!.result!.length,
          itemBuilder: (BuildContext context,int index){
            //如果显示到最后一个并且总数小于100时继续获取数据
            // if(index == list.result!.length-1 && list.result!.length < 100){
            //   //getImages();
            // }
            return Card(
              //z轴的高度，设置card的阴影
              elevation: 20.0,
              //设置shape，这里设置成了R角
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),),
              //对Widget截取的行为，比如这里 Clip.antiAlias 指抗锯齿
              clipBehavior: Clip.antiAlias,
              semanticContainer: false,
              child:Column(
                children: [Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.network(list.result![index].picUrl! ,fit: BoxFit.fill,),
                    Positioned(child: Text(list.result![index].copywriter!,maxLines: 2,overflow: TextOverflow.fade,),bottom: 0,)
                  ],
                ),],
              )
            );
          },

        ),
      );
    }
    return SongSheetWidget!;
  }

}
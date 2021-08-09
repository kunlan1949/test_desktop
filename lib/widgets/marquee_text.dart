import 'package:flutter/material.dart';

class MarqueeText extends StatefulWidget {
  final Widget? child;
  final Axis direction;
  final Duration animationDuration, backDuration, pauseDuration;

  const MarqueeText({
    Key? key,
    @required this.child,
    this.direction = Axis.horizontal,
    this.animationDuration = const Duration(milliseconds: 3000),
    this.backDuration = const Duration(milliseconds: 800),
    this.pauseDuration = const Duration(milliseconds: 800),
  }) : super(key: key);

  @override
  _MarqueeTextState createState() => _MarqueeTextState();
}

class _MarqueeTextState extends State<MarqueeText> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    scroll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: widget.child,
      scrollDirection: widget.direction,
      controller: scrollController,
    );
  }

  void scroll() async {
    while (true) {
      //延时
      await Future.delayed(widget.pauseDuration);
      //执行正向动画
      await scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: widget.animationDuration,
          curve: Curves.easeIn);
      //延时
      await Future.delayed(widget.pauseDuration);
      //执行反向动画
      await scrollController.animateTo(0.0,
          duration: widget.backDuration, curve: Curves.easeOut);
    }
  }
}

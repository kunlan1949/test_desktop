import 'package:flutter/widgets.dart';

import 'package:logging/logging.dart';

import '../fluttery_audio.dart';
import '_audio_visualizer.dart';

final _log = new Logger('Visualizer');

class Visualizer extends StatefulWidget {

  final Function(BuildContext context, List<int> fft)? builder;

  Visualizer({
    this.builder,
  });

  @override
  _VisualizerState createState() => new _VisualizerState();
}

class _VisualizerState extends State<Visualizer> {

  AudioVisualizer? visualizer;
  List<int> fft = const [];

  @override
  void initState() {
    super.initState();
    visualizer = FlutteryAudio.audioVisualizer()
      ..activate()
      ..addListener(
          fftCallback: (List<int> samples) {
            _log.fine('Got FFT samples: $samples');
            setState(() => fft = samples);
          }
      );
  }

  @override
  void dispose() {
    visualizer!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder!(context, fft);
  }
}
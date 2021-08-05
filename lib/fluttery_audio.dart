import 'package:flutter/services.dart';

import 'src/_audio_visualizer.dart';
export 'src/_visualizer.dart';

class FlutteryAudio {

  static const MethodChannel _visualizerChannel =
      MethodChannel('fluttery_audio_visualizer');

  static AudioVisualizer audioVisualizer() {
    return AudioVisualizer(
      channel: _visualizerChannel,
    );
  }
}
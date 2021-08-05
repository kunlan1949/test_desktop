import 'package:flutter/material.dart';

class VisualizerPainter extends CustomPainter {
  final List<int>? fft;
  final double? height;
  final Color? color;
  final Paint? wavePaint;

  VisualizerPainter({this.fft, this.height, this.color})
      : wavePaint = new Paint()
    ..color = color!.withOpacity(.5)
    ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    _renderWaves(canvas, size);
  }

  void _renderWaves(Canvas canvas, Size size) {
    final histgramLow =
    _createHistogram(fft!, 15, 2, ((fft!.length) / 4).floor());
    final histogramHigh = _createHistogram(
        fft!, 15, (fft!.length).ceil(), (fft!.length / 2).floor());

    _renderHistogram(canvas, size, histgramLow!);
    _renderHistogram(canvas, size, histogramHigh!);
  }

  void _renderHistogram(Canvas canvas, Size size, List<int> histogram) {
    if (histogram.length == 0) {
      return;
    }
    final pointsToGraph = histogram.length;
    // The First and Last point is useless, so -2
    final widthPerSample = (size.width) / (pointsToGraph - 2).floor();

    final points = new List<double>.filled(pointsToGraph * 4, 0.0);

    for (int i = 0; i < histogram.length - 1; ++i) {
      points[i * 4] = (i * widthPerSample).toDouble();
      points[i * 4 + 1] = size.height - histogram[i].toDouble();

      points[i * 4 + 2] = ((i + 1) * widthPerSample).toDouble();
      points[i * 4 + 3] = size.height - (histogram[i + 1].toDouble());
    }

    Path path = new Path();
    path.moveTo(0.0, size.height);
    path.lineTo(points[0], points[1]);
    for (int i = 2; i < points.length - 4; i += 2) {
      path.cubicTo(points[i - 2] + 10.0, points[i - 1], points[i] - 10.0,
          points[i + 1], points[i], points[i + 1]);
    }
    path.lineTo(size.width, size.height);
    path.close();
    canvas.drawPath(path, wavePaint!);
  }

  List<int>? _createHistogram(List<int> samples, int bucketCount,
      [int? start, int? end]) {
    if (start == end) {
      return const [];
    }
    start = start ?? 0;
    end = end ?? samples.length - 1;
    final sampleCount = end - start + 1;

    final samplesPerBucket = (sampleCount / bucketCount).floor();
    if (samplesPerBucket == 0) {
      return const [];
    }
    final actualSampleCount = sampleCount - (sampleCount % samplesPerBucket);
    List<int> histogram = new List<int>.filled(bucketCount, 0);

    // Add up the Frequency ammounts for each bucket.
    for (int i = start; i <= start + actualSampleCount; ++i) {
      //Ignore the imaginary half of each FFT sample
      if ((i - start) % 2 == 1) {
        continue;
      }

      int bucketIndex = ((i - start) / samplesPerBucket).floor();
      histogram[bucketIndex] += samples[i];

      // Massage the data for visualization
      for (var i = 0; i < histogram.length; ++i) {
        histogram[i] = (histogram[i] / samplesPerBucket).abs().round();
      }
      return histogram;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
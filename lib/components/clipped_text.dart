import 'dart:async';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class ClippedText extends StatefulWidget {
  const ClippedText({super.key, required this.text});

  final Text text;

  @override
  _ClippedTextState createState() => _ClippedTextState();
}

class _ClippedTextState extends State<ClippedText> {
  ui.Image? _image;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  Future<void> _loadImage() async {
    final Completer<ui.Image> completer = Completer();
    final ImageStream stream = AssetImage(
      "assets/images/Basilique.jpg",
    ).resolve(ImageConfiguration());

    stream.addListener(
      ImageStreamListener((ImageInfo info, bool _) {
        completer.complete(info.image);
      }),
    );

    _image = await completer.future;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_image == null) {
      return const CircularProgressIndicator();
    }

    return ShaderMask(
      shaderCallback: (Rect bounds) {
        // Calculate proper scaling to cover the text area
        final double scaleX = bounds.width / _image!.width;
        final double scaleY = bounds.height / _image!.height;
        final double scale = math.max(scaleX, scaleY);

        // Create transformation matrix
        final Matrix4 matrix =
            Matrix4.identity()
              ..scale(scale, scale, 1.0)
              ..translate(
                -(scale * _image!.width - bounds.width) / 2 / scale,
                -(scale * _image!.height - bounds.height) / 2 / scale,
              );

        return ImageShader(
          _image!,
          TileMode.clamp,
          TileMode.clamp,
          matrix.storage,
        );
      },
      blendMode: BlendMode.srcIn, // Better for text clipping
      child: widget.text,
    );
  }
}

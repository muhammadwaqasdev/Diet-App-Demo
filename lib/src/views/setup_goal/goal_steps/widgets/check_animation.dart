import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class CheckAnimation extends StatefulWidget {
  @override
  _CheckAnimationState createState() => _CheckAnimationState();
}

class _CheckAnimationState extends State<CheckAnimation> {
  /// Tracks if the animation is playing by whether controller is running.
  bool get isPlaying => _controller?.isActive ?? false;

  Artboard? _riveArtboard;
  RiveAnimationController? _controller;

  @override
  void initState() {
    super.initState();

    // Load the animation file from the bundle, note that you could also
    // download this. The RiveFile just expects a list of bytes.
    rootBundle.load('assets/animations/tick.riv').then(
      (data) async {
        // Load the RiveFile from the binary data.
        final file = RiveFile.import(data);
        // The artboard is the root of the animation and gets drawn in the
        // Rive widget.
        final artboard = file.mainArtboard;
        // Add a controller to play back a known animation on the main/default
        // artboard.We store a reference to it so we can toggle playback.
        artboard.addController(_controller = SimpleAnimation('idle'));
        setState(() => _riveArtboard = artboard);
        _controller?.isActive = true;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: _riveArtboard == null
          ? const SizedBox()
          : Rive(artboard: _riveArtboard!),
    );
  }
}

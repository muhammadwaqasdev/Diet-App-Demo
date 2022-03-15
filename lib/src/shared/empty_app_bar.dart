import 'package:flutter/material.dart';

class EmptyAppBar extends PreferredSize {
  final Brightness brightness;
  final Color color;

  const EmptyAppBar(
      {this.brightness = Brightness.light, this.color = Colors.transparent})
      : super(
            child: const SizedBox.shrink(),
            preferredSize: const Size.fromHeight(0));

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 0,
      elevation: 0,
      backgroundColor: color,
      brightness: brightness,
    );
  }
}

import 'package:diet_app/src/base/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrawerContainerController {
  GestureTapCallback toggleDrawer = () {};
}

enum DrawerGestureMode { NONE, OPEN_AND_CLOSE, CLOSE_ONLY, OPEN_ONLY }

class DrawerContainer extends StatefulWidget {
  final Widget drawer;
  final Widget body;
  final DrawerContainerController? controller;
  final double width;
  final Duration animationDuration;
  final DrawerGestureMode gestureMode;
  final Curve animationCurve;
  final bool enableSwipe;

  DrawerContainer(
      {required this.body,
      required this.drawer,
      this.controller,
      this.width = 100,
      this.enableSwipe = false,
      this.animationDuration = const Duration(milliseconds: 250),
      this.animationCurve = Curves.easeInOutQuint,
      this.gestureMode = DrawerGestureMode.OPEN_AND_CLOSE});

  @override
  _DrawerContainerState createState() => _DrawerContainerState();
}

class _DrawerContainerState extends State<DrawerContainer>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  late Animation<double> animationDrawer;

  @override
  void initState() {
    initAnimationControllers();
    setupDrawerController();
    super.initState();
  }

  void initAnimationControllers() {
    controller =
        new AnimationController(duration: widget.animationDuration, vsync: this)
          ..addListener(() => setState(() {}));
    animation = Tween(begin: 0.0, end: -widget.width).animate(
        CurvedAnimation(parent: controller, curve: widget.animationCurve));
    animationDrawer = Tween(begin: -widget.width, end: 0.0).animate(
        CurvedAnimation(parent: controller, curve: widget.animationCurve));
  }

  @override
  Widget build(BuildContext context) {
    var content = SizedBox(
        width: context.screenSize().width,
        height: context.screenSize().height,
        child: widget.body);
    return SizedBox(
      width: context.screenSize().width + widget.width,
      height: context.screenSize().height,
      child: Stack(
        children: [
          Positioned(
            left: animationDrawer.value,
            child: Material(
                child: SizedBox(
              child: widget.drawer,
              width: widget.width,
              height: context.screenSize().height,
            )),
          ),
          if (widget.enableSwipe)
            Positioned(
              right: animation.value,
              child: GestureDetector(
                onHorizontalDragUpdate: onSwipe,
                child: content,
              ),
            ),
          if (!widget.enableSwipe)
            Positioned(child: content, right: animation.value)
        ],
      ),
    );
  }

  void onSwipe(DragUpdateDetails details) {
    if (widget.gestureMode == DrawerGestureMode.NONE) {
      return;
    }
    // Note: Sensitivity is integer used when you don't want to mess up vertical drag
    int sensitivity = 8;
    if (details.delta.dx > sensitivity) {
      // Right Swipe
      controller.forward();
    } else if (details.delta.dx < -sensitivity) {
      //Left Swipe
      controller.reverse();
    }
  }

  void setupDrawerController() {
    if (widget.controller != null) {
      widget.controller!.toggleDrawer = () =>
          (animation.value < 0) ? controller.reverse() : controller.forward();
    }
  }
}

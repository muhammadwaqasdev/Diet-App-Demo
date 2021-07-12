import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_starter_app/src/shared/spacing.dart';

class PageEndSpacer extends StatelessWidget {
  const PageEndSpacer();

  @override
  Widget build(BuildContext context) {
    return VerticalSpacing(Platform.isIOS ? 10 : 30);
  }
}

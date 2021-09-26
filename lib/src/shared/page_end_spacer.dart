import 'dart:io';

import 'package:diet_app/src/shared/spacing.dart';
import 'package:flutter/material.dart';

class PageEndSpacer extends StatelessWidget {
  const PageEndSpacer();

  @override
  Widget build(BuildContext context) {
    return VerticalSpacing(Platform.isIOS ? 10 : 30);
  }
}

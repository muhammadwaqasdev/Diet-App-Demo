import 'package:diet_app/src/models/video.dart';
import 'package:diet_app/src/services/remote/videos_service.dart';
import 'package:diet_app/src/shared/video_sheet.dart';
import 'package:flutter/cupertino.dart';

import '../configs/app_setup.locator.dart';

mixin VideoPopupScreenViewModelMixin {
  init(BuildContext context, Screen screen) {
    var video = locator<VideosService>().getVideoByScreen(screen);
    if (video != null) {
      VideoSheet.show(context, video);
    }
  }
}

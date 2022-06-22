import 'package:diet_app/src/models/video.dart';
import 'package:diet_app/src/services/remote/videos_service.dart';
import 'package:diet_app/src/shared/video_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

import '../configs/app_setup.locator.dart';

mixin VideoPopupScreenViewModelMixin on BaseViewModel {
  init(BuildContext context, Screen screen) {
    var video = getVideo(screen);
    if (video != null) {
      VideoSheet.show(context, video);
    }
  }

  getVideo(Screen screen) => locator<VideosService>().getVideoByScreen(screen);
}

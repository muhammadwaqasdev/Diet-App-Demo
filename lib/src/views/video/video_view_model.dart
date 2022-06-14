import 'package:diet_app/src/base/video_popup_screen_view_model_mixin.dart';
import 'package:diet_app/src/configs/app_setup.locator.dart';
import 'package:diet_app/src/models/video.dart';
import 'package:diet_app/src/services/remote/videos_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class VideoViewModel extends ReactiveViewModel
    with VideoPopupScreenViewModelMixin {
  VideosService _videosService = locator<VideosService>();

  List<Video> get videos => _videosService.videos.toList();

  init(BuildContext context, Screen screen) {
    super.init(context, screen);
    runBusyFuture(_videosService.fetch());
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_videosService];
}

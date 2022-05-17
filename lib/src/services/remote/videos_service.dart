import 'package:diet_app/src/configs/app_setup.locator.dart';
import 'package:diet_app/src/models/video.dart';
import 'package:diet_app/src/services/remote/api_service.dart';
import 'package:flutter/foundation.dart';
import 'package:stacked/stacked.dart';

class VideosService with ReactiveServiceMixin {
  ReactiveList<Video> _videos = ReactiveList();

  List<Video> get videos => _videos.toList();

  VideosService() {
    listenToReactiveValues([_videos]);
  }

  Video? getVideoByScreen(Screen screen) {
    var videoIndex = _videos.indexWhere((p0) => p0.screen == screen);
    if (videoIndex >= 0) {
      return _videos[videoIndex];
    }
    return null;
  }

  Future<void> fetch() async {
    var api = locator<ApiService>();
    try {
      var videos = await api.getVideos();
      _videos.clear();
      _videos.addAll(videos ?? []);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}

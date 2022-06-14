import 'package:diet_app/src/configs/app_setup.locator.dart';
import 'package:diet_app/src/models/video.dart';
import 'package:diet_app/src/services/remote/videos_service.dart';
import 'package:stacked/stacked.dart';

class VideoViewModel extends BaseViewModel {

  VideosService videosService = locator<VideosService>();

  List<Video> videos = [];
  init(){
    videosService.fetch();
    videos = videosService.videos.toList();
  }

}

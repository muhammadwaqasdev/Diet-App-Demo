import 'package:diet_app/src/models/video.dart';
import 'package:diet_app/src/services/local/navigation_service.dart';
import 'package:diet_app/src/shared/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'app_progress_indicator.dart';

class VideoSheet extends StatefulWidget {
  late YoutubePlayerController _controller;

  final Video _video;

  VideoSheet(this._video) {
    _controller = YoutubePlayerController(
      initialVideoId: _video.videoId!,
      flags:
          YoutubePlayerFlags(autoPlay: true, mute: false, hideControls: true),
    );
  }

  @override
  State<VideoSheet> createState() => _VideoSheetState();

  static show(BuildContext context, Video video) async {
    var videoPlayer = VideoSheet(video);
    await Future.delayed(Duration(milliseconds: 100));
    await showModalBottomSheet(
        context: context,
        builder: (ctx) => videoPlayer,
        backgroundColor: Colors.transparent);
    videoPlayer._controller.reset();
  }
}

class _VideoSheetState extends State<VideoSheet> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 380,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          )),
      padding: EdgeInsets.only(
        left: 25,
        right: 25,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VerticalSpacing(25),
          Center(
            child: SvgPicture.string(
              '<svg viewBox="194.5 564.5 39.0 1.0" ><path transform="translate(194.5, 564.5)" d="M 0 0 L 39 0" fill="none" stroke="#ebebeb" stroke-width="5" stroke-miterlimit="4" stroke-linecap="round" /></svg>',
              allowDrawingOutsideViewBox: true,
              fit: BoxFit.fill,
            ),
          ),
          VerticalSpacing(),
          Row(
            children: [
              Expanded(
                child: Text(
                  widget._video.title!,
                  style: TextStyle(
                    fontSize: 25,
                    color: const Color(0xff000000),
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              GestureDetector(
                onTap: NavService.pop,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(Icons.close),
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Container(
              height: 181.90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: const Color(0xffEAEAEA),
              ),
              child: AnimatedCrossFade(
                duration: Duration(milliseconds: 250),
                crossFadeState: isLoading
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                firstChild: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppProgressIndicator(
                          size: 20, brightness: Brightness.dark),
                      VerticalSpacing(5),
                      Text("Please wait")
                    ],
                  ),
                ),
                secondChild: YoutubePlayer(
                  onEnded: (data) => NavService.pop(),
                  controller: widget._controller,
                  showVideoProgressIndicator: true,
                  progressIndicatorColor: Colors.amber,
                  onReady: () async {
                    await Future.delayed(Duration(milliseconds: 5000));
                    setState(() {
                      isLoading = false;
                    });
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

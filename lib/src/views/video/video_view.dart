import 'package:diet_app/src/base/utils/utils.dart';
import 'package:diet_app/src/shared/app_bar_action_button.dart';
import 'package:diet_app/src/shared/empty_app_bar.dart';
import 'package:diet_app/src/shared/spacing.dart';
import 'package:diet_app/src/shared/video_card_tile.dart';
import 'package:diet_app/src/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import 'video_view_model.dart';

class VideoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: ViewModelBuilder<VideoViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.white,
          appBar: EmptyAppBar(color: AppColors.semiWhite),
          body: Stack(
            children: [
              Container(
                height: 230,
                color: AppColors.fatsBlue.withOpacity(0.5),

              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      VerticalSpacing(10),
                      AppBarActionButton(),
                      VerticalSpacing(20),
                      Text(
                        "Video List",
                        style: context.textTheme().headline3,
                      ),
                      Text(
                        "Lorem Ipsum is simply dummy text ",
                        style: context.textTheme().headline5,
                      ),
                      VerticalSpacing(20),
                      Column(
                        children: model.videos
                            .map((e) => VideoCardTile(
                                videoId: e.videoId.toString(),
                                title: e.title.toString(),
                                onTap: () {
                                  showDialogVideo(context, e.url.toString());
                                }))
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        viewModelBuilder: () => VideoViewModel(),
        onModelReady: (model) => model.init(),
      ),
    );
  }

  showDialogVideo(context, url) {
    //YoutubePlayerController? controller;
    return showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: context.screenSize().height / 2.5,
                    width: context.screenSize().width,
                    child: YoutubePlayerControllerProvider(
                      controller: YoutubePlayerController(
                          initialVideoId:
                              YoutubePlayerController.convertUrlToId(
                                  url.toString())!,
                          params: YoutubePlayerParams(
                              loop: false, color: 'transparent')),
                      child: YoutubePlayerIFrame(
                        controller: YoutubePlayerController(
                            initialVideoId:
                                YoutubePlayerController.convertUrlToId(
                                    url.toString())!,
                            params: YoutubePlayerParams(
                                loop: false, color: 'transparent')),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: AppColors.greyBgLight),
                      height: 50,
                      width: 50,
                      margin: EdgeInsets.only(top: 25),
                      child: Icon(Icons.close),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

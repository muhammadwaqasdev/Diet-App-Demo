import 'package:diet_app/src/base/utils/utils.dart';
import 'package:diet_app/src/models/video.dart';
import 'package:diet_app/src/shared/app_bar_action_button.dart';
import 'package:diet_app/src/shared/empty_app_bar.dart';
import 'package:diet_app/src/shared/spacing.dart';
import 'package:diet_app/src/shared/video_card_tile.dart';
import 'package:diet_app/src/shared/video_sheet.dart';
import 'package:diet_app/src/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

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
                color: AppColors.semiWhite.withOpacity(0.5),
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
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: model.videos.length,
                        itemBuilder: (_, index) => ((Video video) =>
                            VideoCardTile(
                                videoId: video.videoId.toString(),
                                title: video.title.toString(),
                                onTap: () => showDialogVideo(
                                    context, video)))(model.videos[index]),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        viewModelBuilder: () => VideoViewModel(),
        onModelReady: (model) => model.init(context, Screen.VIDEOS),
      ),
    );
  }

  showDialogVideo(context, Video video) {
    VideoSheet.show(context, video);
  }
}

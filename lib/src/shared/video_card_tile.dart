import 'package:diet_app/src/base/utils/utils.dart';
import 'package:diet_app/src/shared/load_image.dart';
import 'package:diet_app/src/styles/app_colors.dart';
import 'package:flutter/material.dart';

class VideoCardTile extends StatelessWidget {
  final String videoId;
  final String title;
  final Function onTap;

  const VideoCardTile(
      {Key? key,
      required this.videoId,
      required this.title,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        decoration: BoxDecoration(color: AppColors.greyBgLight,borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.only(bottom: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LoadImage(
                "https://img.youtube.com/vi/$videoId/hqdefault.jpg",
                size: Size(context.screenSize().width, 200)),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Text(
                title,
                style: context.textTheme().headline5,
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:diet_app/src/base/utils/utils.dart';
import 'package:diet_app/src/shared/app_progress_indicator.dart';
import 'package:diet_app/src/styles/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:image_picker/image_picker.dart';

class _ImagePickOptions {
  static const String camera = 'Camera';
  static const String gallery = 'Gallery';
}

class LoadImage extends StatefulWidget {
  final dynamic url;
  final bool isCircle;
  final Size? size;
  final ValueChanged<File>? pickedImage;
  final bool isUploadLoader;
  final bool hasPickOption;

  LoadImage(
    this.url, {
    this.isCircle = false,
    @required this.size,
    this.pickedImage,
    this.isUploadLoader = false,
    this.hasPickOption = false,
  });

  @override
  _LoadImageState createState() => _LoadImageState();
}

class _LoadImageState extends State<LoadImage> {
  final imagePicker = ImagePicker();
  File? picketImage;
  final GlobalKey _menuKey = new GlobalKey();

  void _openOptions() async {
    dynamic state = _menuKey.currentState;
    state.showButtonMenu();
  }

  void _pickImage(ImageSource source) async {
    try {
      final data = await imagePicker.pickImage(
        source: source,
        maxHeight: 500,
        maxWidth: 500,
      );
      if (data != null) {
        final image = File(data.path);
        if (widget.pickedImage != null) {
          widget.pickedImage!(image);
        }
        setState(() => picketImage = image);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final button = new PopupMenuButton(
      key: _menuKey,
      child: SizedBox(),
      itemBuilder: (_) => <PopupMenuItem<String>>[
        PopupMenuItem<String>(
            child: Text('Camera',
                style: context
                    .textTheme()
                    .subtitle2
                    ?.copyWith(fontWeight: FontWeight.w300)),
            value: 'Camera'),
        PopupMenuItem<String>(
            child: Text('Gallery',
                style: context
                    .textTheme()
                    .subtitle2
                    ?.copyWith(fontWeight: FontWeight.w300)),
            value: 'Gallery'),
      ],
      onSelected: (val) {
        switch (val) {
          case _ImagePickOptions.camera:
            _pickImage(ImageSource.camera);
            break;
          case _ImagePickOptions.gallery:
            _pickImage(ImageSource.gallery);
            break;
          default:
            print('Invalid value');
        }
      },
    );
    var fallBackImage = Container(
      width: widget.size?.width,
      height: widget.size?.height,
      decoration: BoxDecoration(
        borderRadius: widget.isCircle
            ? BorderRadius.all(Radius.circular((widget.size?.width ?? 2) / 2))
            : null,
        color: Colors.black,
      ),
      child: Center(
        child: Icon(
          Icons.add_a_photo_outlined,
          color: Colors.white,
          size: (widget.size?.width ?? 2) / 2,
        ),
      ),
    );

    final pickImageOption = widget.hasPickOption
        ? GestureDetector(
            onTap: _openOptions,
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      width: 26,
                      height: 26,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black,
                      ),
                      child: Icon(
                        Icons.add_a_photo,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ],
                ),
                button,
              ],
            ),
          )
        : SizedBox();

    if (picketImage != null) {
      return Stack(
        alignment: Alignment.bottomRight,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              if (picketImage != null)
                ClipRRect(
                  borderRadius: BorderRadius.all(
                      Radius.circular((widget.size?.width ?? 2) / 2)),
                  child: Image.file(
                    picketImage!,
                    height: widget.size?.height,
                    width: widget.size?.width,
                    fit: BoxFit.cover,
                  ),
                ),
              if (widget.isUploadLoader)
                AppProgressIndicator(
                  size: 25,
                ),
            ],
          ),
          pickImageOption,
        ],
      );
    }
    return (widget.url is String)
        ? CachedNetworkImage(
            imageUrl: widget.url ?? "http://kkkkkkk.ca",
            imageBuilder: (context, imageProvider) => Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  height: widget.size?.height,
                  width: widget.size?.width,
                  decoration: BoxDecoration(
                    borderRadius: widget.isCircle
                        ? BorderRadius.all(
                            Radius.circular((widget.size?.width ?? 2) / 2))
                        : BorderRadius.zero,
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                pickImageOption,
              ],
            ),
            placeholder: (context, url) => Container(
              width: widget.size?.width,
              height: widget.size?.height,
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
              ),
            ),
            errorWidget: (context, url, error) => GestureDetector(
              onTap: _openOptions,
              child: Center(
                child: widget.isCircle
                    ? Stack(
                        alignment: Alignment.center,
                        children: [
                          ClipRRect(
                            child: fallBackImage,
                            borderRadius: BorderRadius.all(
                              Radius.circular((widget.size?.width ?? 2) / 2),
                            ),
                          ),
                          button,
                        ],
                      )
                    : fallBackImage,
              ),
            ),
          )
        : widget.url is File
            ? ClipRRect(
                child: Image.file(widget.url),
                borderRadius: widget.isCircle
                    ? BorderRadius.all(
                        Radius.circular((widget.size?.width ?? 2) / 2),
                      )
                    : BorderRadius.zero)
            : SizedBox.shrink();
  }
}

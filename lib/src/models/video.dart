import 'package:flutter/foundation.dart';

enum Screen {
  GET_STARTED,
  GOAL_STEP_1,
  GOAL_STEP_2,
  GOAL_STEP_3,
  GOAL_STEP_4,
  GOAL_STEP_5,
  DASHBOARD,
  ACHIEVEMENTS,
  GROCERY_LIST,
  PROFILE,
  SETTINGS,
  VIDEOS,
  SIGN_IN,
  SIGN_UP,
  MEAL_PLAN_COMPLETE
}

class Video {
  int? id;
  String? title;
  Screen? screen;
  String? url;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? videoId;

  Video(
      {this.id,
      this.title,
      this.screen,
      this.url,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.videoId});

  Video.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    screen = Screen.values[Screen.values
        .map((e) => describeEnum(e))
        .toList()
        .indexOf(json['screen'])];
    url = json['url'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    videoId = json['video_id'];
  }

  static List<Video> fromJsonList(List<dynamic> jsonList) {
    List<Video> videos = [];
    for (var videoJson in jsonList) {
      videos.add(Video.fromJson(videoJson as Map<String, dynamic>));
    }
    return videos;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['screen'] = describeEnum(this.screen!);
    data['url'] = this.url;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['video_id'] = this.videoId;
    return data;
  }
}

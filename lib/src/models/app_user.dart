import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';

class AppUser {
  String? id;
  String? fullName;
  String? email;
  String? displayImageUrl;
  String? gender;
  DateTime? dateOfBirth;

  AppUser(
      {this.id,
      this.fullName,
      this.email,
      this.displayImageUrl,
      this.gender,
      this.dateOfBirth});

  AppUser.fromJson(Map<String, Object?> json)
      : this(
            id: json['id']! as String,
            fullName: json['full_name']! as String,
            dateOfBirth:
                DateTime.parse((json['date_of_birth'] as String?) ?? ''),
            email: json['email']! as String,
            displayImageUrl: json['display_image_url'] as String?,
            gender: json['gender']! as String);

  Map<String, Object?> toJson() {
    return {
      "id": id,
      "full_name": fullName,
      "email": email,
      "display_image_url": displayImageUrl,
      "gender": gender,
      "date_of_birth": dateOfBirth.toString(),
    };
  }
}

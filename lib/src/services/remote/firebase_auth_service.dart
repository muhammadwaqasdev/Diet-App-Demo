import 'dart:io';

import 'package:diet_app/src/configs/app_setup.locator.dart';
import 'package:diet_app/src/configs/app_setup.router.dart';
import 'package:diet_app/src/models/app_user.dart';
import 'package:diet_app/src/services/local/auth_service.dart';
import 'package:diet_app/src/services/local/goal_creation_steps_service.dart';
import 'package:diet_app/src/services/local/local_database_service.dart';
import 'package:diet_app/src/services/local/local_notification_service.dart';
import 'package:diet_app/src/services/local/navigation_service.dart';
import 'package:diet_app/src/views/achievements/achievements_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'firestore_service.dart';

class FirebaseAuthService {
  FirebaseService() {
    Firebase.initializeApp();
  }

  Future<bool> init() async {
    await Firebase.initializeApp();
    if (FirebaseAuth.instance.currentUser != null) {
      try {
        var snap = (await FirestoreService.users
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get());
        if (!snap.exists) {
          return false;
        }
        locator<AuthService>().user = snap.data();
      } catch (e) {
        print(e);
      }
    }
    return (locator<AuthService>().user ?? AppUser()).id != null;
  }

  signUpWithEmail(BuildContext context, AppUser appUser, String password,
      File? profileImage) async {
    try {
      if (profileImage != null) {
        var file = await FirebaseStorage.instance
            .ref(
                "${DateTime.now().millisecondsSinceEpoch}.${profileImage.path.split("/").last.split(".").last}")
            .putFile(profileImage);
        appUser.displayImageUrl = await file.ref.getDownloadURL();
      }
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: appUser.email!, password: password);
      if (appUser.displayImageUrl != null) {
        userCredential.user!.updatePhotoURL(appUser.displayImageUrl);
      }
      userCredential.user!.updateDisplayName(appUser.fullName);
      appUser.id = userCredential.user!.uid;
      FirestoreService.users.doc(userCredential.user?.uid).set(appUser);
      await setupAppUser(context);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw FlutterError('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw FlutterError('The account already exists for that email.');
      }
    } catch (e) {
      throw FlutterError(e.toString());
    }
  }

  signInWithEmail(BuildContext context, String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      await setupAppUser(context);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw FlutterError('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw FlutterError('Wrong password provided for that user.');
      }
    } catch (e) {
      throw FlutterError(e.toString());
    }
  }

  Future<void> setupAppUser(BuildContext? context) async {
    try {
      var isLoggedIn = await init();
      if (isLoggedIn) {
        var isLoaded = await (locator<GoalCreationStepsService>()).fetch();
        if (!isLoaded) {
          NavService.getStarted(shouldClear: true);
        } else {
          if (context != null) {
            AchievementsViewModel.showWeightSheet(context, isForProgress: true);
            locator<GoalCreationStepsService>().loadingStep = 0;
            await locator<GoalCreationStepsService>().save();
          }
          await NavService.dashboard(
              arguments: DashboardViewArguments(isFromSetup: false));
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> signOut() async {
    await locator<LocalNotificationService>().clear();
    await FirebaseAuth.instance.signOut();
    NavService.splash(isInit: false);
    locator<AuthService>().user = null;
    await locator<LocalDatabaseService>().clearIntakes();
  }

  updateProfile(AppUser appUser, File? profileImage) async {
    if (profileImage != null) {
      var lastImgUrl = appUser.displayImageUrl;
      var file = await FirebaseStorage.instance
          .ref(
              "${DateTime.now().millisecondsSinceEpoch}.${profileImage.path.split("/").last.split(".").last}")
          .putFile(profileImage);
      appUser.displayImageUrl = await file.ref.getDownloadURL();
      //await FirebaseStorage.instance.ref(lastImgUrl).delete();
    }
    var firebaseUser = FirebaseAuth.instance.currentUser;
    if (appUser.displayImageUrl != null) {
      firebaseUser!.updatePhotoURL(appUser.displayImageUrl);
    }
    firebaseUser?.updateDisplayName(appUser.fullName);
    await FirestoreService.users.doc(firebaseUser?.uid).set(appUser);
    locator<AuthService>().user = appUser;
  }

  updatePassword(String email, String oldPassword, String newPassword) async {
    AuthCredential credential =
        EmailAuthProvider.credential(email: email, password: oldPassword);
    await FirebaseAuth.instance.currentUser
        ?.reauthenticateWithCredential(credential);
    await FirebaseAuth.instance.currentUser?.updatePassword(newPassword);
  }
}

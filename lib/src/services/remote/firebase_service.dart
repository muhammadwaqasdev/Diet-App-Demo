import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diet_app/src/configs/app_setup.locator.dart';
import 'package:diet_app/src/models/app_user.dart';
import 'package:diet_app/src/services/local/auth_service.dart';
import 'package:diet_app/src/services/local/navigation_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class FireDatabase {
  static CollectionReference<AppUser> get users =>
      FirebaseFirestore.instance.collection('users').withConverter<AppUser>(
            fromFirestore: (snapshot, _) =>
                AppUser.fromJson(snapshot.data() ?? {}),
            toFirestore: (movie, _) => movie.toJson(),
          );
}

class FirebaseService {
  FirebaseService() {
    Firebase.initializeApp();
  }

  Future<bool> init() async {
    await Firebase.initializeApp();
    if (FirebaseAuth.instance.currentUser != null) {
      try {
        var snap = (await FireDatabase.users
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

  signUpWithEmail(AppUser appUser, String password, File? profileImage) async {
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
      FireDatabase.users.doc(userCredential.user?.uid).set(appUser);
      await setupAppUser();
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

  signInWithEmail(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      await setupAppUser();
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

  Future<void> setupAppUser() async {
    try {
      var snap = (await FireDatabase.users
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get());
      if (!snap.exists) {
        return;
      }
      locator<AuthService>().user = snap.data();
      NavService.getStarted(shouldClear: true);
    } catch (e) {
      print(e);
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    locator<AuthService>().user = null;
    await NavService.splash(isInit: false);
  }
}

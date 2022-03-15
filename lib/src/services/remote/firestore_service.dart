import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diet_app/src/models/app_user.dart';
import 'package:diet_app/src/models/goal.dart';

class FirestoreService {
  static CollectionReference<AppUser> get users =>
      FirebaseFirestore.instance.collection('users').withConverter<AppUser>(
            fromFirestore: (snapshot, _) =>
                AppUser.fromJson(snapshot.data() ?? {}),
            toFirestore: (movie, _) => movie.toJson(),
          );

  static CollectionReference<Goal> get goals =>
      FirebaseFirestore.instance.collection('goals').withConverter<Goal>(
            fromFirestore: (snapshot, _) =>
                Goal.fromJson(snapshot.data() ?? {}),
            toFirestore: (goal, _) => goal.toJson(),
          );
}

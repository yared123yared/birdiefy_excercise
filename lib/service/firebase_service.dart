import 'package:app/model/holes.dart';
import 'package:app/preference/user_preference_data.dart';
import 'package:app/service/injection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/round.dart';
import 'package:app/model/user_entity.dart';
import 'package:app/utils/apputils.dart';

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

Future<UserEntity> signInWithEmailAndPassword({
  required String email,
  required String password,
}) async {
  UserEntity returned_user = UserEntity.empty();
  try {
    await _firebaseAuth
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((user) async {
      final users = await FirebaseFirestore.instance
          .collection("users")
          .doc(user.user!.uid)
          .get()
          .then((value) => value)
          .then((value) => value.data());
      returned_user = UserEntity.fromJson(users!);
      returned_user.id = user.user!.uid;

      final prefs = getIt<UserPreferences>();
      await prefs.storeUserInformation(returned_user);
    });
    return returned_user;
  } on FirebaseAuthException catch (e) {
    throw determineError(e);
  }
}

Future<UserEntity?> createUserWithEmailAndPassword(
    {required String email,
    required String password,
    required UserEntity userEntity}) async {
  try {
    final userCredential = await _firebaseAuth
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((user) async {
      userEntity.id = user.user!.uid;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.user!.uid)
          .set({
            "email": userEntity.email,
            "firstname": userEntity.firstName,
            "lastname": userEntity.lastName,
            "password": userEntity.password,
            "handicap": userEntity.handicap,
            "role": userEntity.role.toString() //
          })
          .then((value) {})
          .catchError((error) => throw Exception("Failed to add user: $error"));
    });
  } on FirebaseAuthException catch (e) {
    throw determineError(e);
  }
}

Future<Round?> addHolesToRound(
    {required Round? round, required Holes holes}) async {
  try {
    UserEntity? userEntity =
        await getIt<UserPreferences>().getUserInformation();
    if (round == null) {
      throw Exception("Round is null");
    }

    await FirebaseFirestore.instance
        .collection('users')
        .doc(userEntity!.id)
        .collection('rounds')
        .doc(round.id)
        .collection('holes')
        .add({
          "pars": holes.pars,
          "hits": holes.hits, //
        })
        .then((value) {})
        .catchError((error) => throw Exception("Failed to add user: $error"));
  } on FirebaseAuthException catch (e) {
    throw determineError(e);
  }
}

Future<Round?> createNewRound(
    {required Round? round, required Holes holes}) async {
  try {
    UserEntity? userEntity =
        await getIt<UserPreferences>().getUserInformation();
    if (round == null) {
      throw Exception("Round is null");
    }
    final db = FirebaseFirestore.instance
        .collection('users')
        .doc(userEntity!.id)
        .collection('rounds');
    await db.add(round.toJson()).then((round) async {
      print("round created with id: ${round.id}");
      await db
          .doc(round.id)
          .collection('holes')
          .add(holes.toJson())
          .then((hole) {
        print("Holes created with id : ${hole.id}");
      });
    }).catchError((error) => throw Exception("Failed to add user: $error"));
  } on FirebaseAuthException catch (e) {
    throw determineError(e);
  }
}

Future<Round?> finishRound({required Round? round}) async {
  try {
    UserEntity? userEntity =
        await getIt<UserPreferences>().getUserInformation();
    if (round == null) {
      throw Exception("Round is null");
    }
    round.is_finished = true;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userEntity!.id)
        .collection('rounds')
        .doc(round.id)
        .set(round.toJson())
        .then((value) {})
        .catchError((error) => throw Exception("Failed to add user: $error"));
  } on FirebaseAuthException catch (e) {
    throw determineError(e);
  }
}

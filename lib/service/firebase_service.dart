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
      print("User : $users");
      returned_user = UserEntity.fromJson(users!);
      returned_user.id = user.user!.uid;

      final prefs = getIt<UserPreferences>();
      await prefs.storeUserInformation(returned_user);
    });
    return returned_user;
    // return _mapFirebaseUser(userCredential.user!);
  } on FirebaseAuthException catch (e) {
    print("Eception: $e");
    throw determineError(e);
  }
}

Future<UserEntity?> createUserWithEmailAndPassword(
    {required String email,
    required String password,
    required UserEntity userEntity}) async {
  try {
    // _firebaseAuth.sendSignInLinkToEmail(actionCodeSettings: acs, email: email);
    final userCredential = await _firebaseAuth
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((user) async {
      print("Users ${user.user!.uid}");
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
      }).then((value) {
        print("user created");
      }).catchError((error) => throw Exception("Failed to add user: $error"));
    });
    // print(userCredential.user);
    // return _mapFirebaseUser(userCredential.user!);
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
    }).then((value) {
      print("holes created $value");
    }).catchError((error) => throw Exception("Failed to add user: $error"));
  } on FirebaseAuthException catch (e) {
    throw determineError(e);
  }
}

Future<Round?> createNewRound({required Round? round}) async {
  try {
    // _firebaseAuth.sendSignInLinkToEmail(actionCodeSettings: acs, email: email);
    // final userCredential = await _firebaseAuth
    //     .createUserWithEmailAndPassword(
    //   email: email,
    //   password: password,
    // )
    //     .then((user) async {
    //   print("Users ${user.user!.uid}");
    //   userEntity.id = user.user!.uid;
    //   await FirebaseFirestore.instance
    //       .collection('users')
    //       .doc(user.user!.uid)
    //       .set({
    //     "email": userEntity.email,
    //     "firstname": userEntity.firstName,
    //     "lastname": userEntity.lastName,
    //     "password": userEntity.password,
    //     "handicap": userEntity.handicap,
    //     "role": userEntity.role //
    //   }).then((value) {
    //     print("user created");
    //   }).catchError((error) => throw Exception("Failed to add user: $error"));
    // });
  } on FirebaseAuthException catch (e) {
    throw determineError(e);
  }
}

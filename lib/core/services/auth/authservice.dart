import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:travelgo_organizer/data/models/organizer_data.dart';

class Authservice {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  String getUserUid() {
    User? user = firebaseAuth.currentUser;
    return user!.uid;
  }

  ///----- Signin With Email and Password
  Future<UserCredential> signInWithEmailAndPassword(
    String email,
    password,
  ) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<void> signOut() async {
    return await firebaseAuth.signOut();
  }

  ///--- Sigin with Google
  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    UserCredential userCredential = await firebaseAuth.signInWithCredential(
      credential,
    );
    log(userCredential.user!.displayName.toString());
    // UserDataModel userModel = UserDataModel(
    //   uid: userCredential.user!.uid,
    //   email: userCredential.user!.email!,
    //   name: userCredential.user!.displayName ?? 'User',
    //   password: 'GoogleID',
    //   phoneNumber: userCredential.user!.phoneNumber ?? '0000000000',
    //   imageUrl:
    //       userCredential.user!.photoURL ??
    //       'https://static.vecteezy.com/system/resources/thumbnails/013/360/247/small/default-avatar-photo-icon-social-media-profile-sign-symbol-vector.jpg',
    // );
    // await firestore
    //     .collection("Organizers")
    //     .doc(userModel.uid)
    //     .set(userModel.toMap());
    // // firestore.collection('Users').doc(userCredential.user!.uid).set({
    // //   'uid': userCredential.user!.uid,
    // //   'email': userCredential.user!.email,
    // //   'role': 'user',
    // // });
    return userCredential;
  }

  Future<UserCredential> signUpWithEmailAndPassword(
    String imagePublicId,
    name,
    email,
    password,
    role,
    phoneNumber,
    imageUrl,
    company,
    designation,
    about,
    experience,
  ) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      OrganizerDataModel userDataModel = OrganizerDataModel(
        imagePublicId: imagePublicId,
        followersCount: 0,
        name: name,
        uid: userCredential.user!.uid,
        email: email,
        password: password,
        phoneNumber: phoneNumber,
        imageUrl: imageUrl,
        company: company,
        designation: designation,
        about: about,
        experience: experience,
        eventHosted: 0,
      );
      firestore
          .collection("Organizers")
          .doc(userCredential.user!.uid)
          .set(userDataModel.toMap());
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }
}

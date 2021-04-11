import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:social_login_flitter/core/error/exceptions/exceptions.dart';
import 'package:social_login_flitter/feature/auth/data/models/auth_user_model.dart';
import 'package:social_login_flitter/feature/auth/domain/entities/auth_user.dart';

abstract class UserRemoteDataSource {
  /// Throws a [AuthException] for all error codes.
  Future<AuthUserModel> getCurrentUser();

  /// Throws a [AuthException] for all error codes.
  Future<AuthUserModel> signIn();

  /// Throws a [AuthException] for all error codes.
  Future<AuthUserModel> signOut();

  /// Throws a [DataBaseException] for all error codes.
  Future<AuthUserModel> getUserById(String userId);

  /// Throws a [DataBaseException] for all error codes.
  Future<AuthUserModel> updateUser(AuthUserModel authUser);

  Future<AuthUserModel> authLogin(LoginData data);

  Future<AuthUserModel> fblogin();
  Future<AuthUserModel> linkedinLogin();
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  static const String USERS_COLLECTION_NAME = "Users";

  final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;
  final FacebookLogin fbLogin;
  final FirebaseFirestore firebaseFirestore;
  final FacebookLoginResult facebookLoginResult;

  UserRemoteDataSourceImpl(
      {@required this.firebaseAuth,
      @required this.googleSignIn,
      @required this.firebaseFirestore,
      @required this.fbLogin,
      @required this.facebookLoginResult});

  @override
  Future<AuthUserModel> getCurrentUser() async {
    var firebaseUser = firebaseAuth.currentUser;

    if (firebaseUser != null) {
      AuthUserModel authUserModel = await getUserById(firebaseUser.uid);
      return Future.value(authUserModel);
    } else {
      throw AuthException();
    }
  }

  @override
  Future<AuthUserModel> signIn() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final UserCredential authResult =
        await firebaseAuth.signInWithCredential(credential);

    if (authResult.user != null) {
      AuthUserModel _userModel = AuthUserModel(
          email: authResult.user.email,
          displayName: authResult.user.displayName,
          profileImage: authResult.user.photoURL,
          userId: authResult.user.uid,
          address: "",
          dob: DateTime.now().toUtc().millisecondsSinceEpoch,
          gender: GenderType.MALE,
          mobile: 0);

      DocumentSnapshot userDocumentSnapshot = await firebaseFirestore
          .collection(USERS_COLLECTION_NAME)
          .doc(authResult.user.uid)
          .get();
      if (!userDocumentSnapshot.exists) {
        firebaseFirestore
            .collection(USERS_COLLECTION_NAME)
            .doc(authResult.user.uid)
            .set(_userModel.toJson());
      }
      return Future.value(
        _userModel,
      );
    } else {
      throw AuthException();
    }
  }

  @override
  Future<AuthUserModel> signOut() async {
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signOut();
    await firebaseAuth.signOut();

    if (googleSignInAccount != null) {
      AuthUserModel authUserModel = await getUserById(googleSignInAccount.id);
      return Future.value(authUserModel);
    } else {
      throw AuthException();
    }
  }

  @override
  Future<AuthUserModel> getUserById(String userId) async {
    try {
      DocumentSnapshot userDocumentSnapshot = await firebaseFirestore
          .collection(USERS_COLLECTION_NAME)
          .doc(userId)
          .get();

      return Future.value(
        AuthUserModel.fromJson(userDocumentSnapshot.data()),
      );
    } on Exception {
      throw DataBaseException();
    }
  }

  @override
  Future<AuthUserModel> updateUser(AuthUserModel authUser) async {
    try {
      await firebaseFirestore
          .collection(USERS_COLLECTION_NAME)
          .doc(authUser.userId)
          .update(authUser.toJson());

      return Future.value(authUser);
    } on Exception {
      throw DataBaseException();
    }
  }

  @override
  Future<AuthUserModel> authLogin(LoginData data) async {
    String message;
    try {
      final mAuth = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: data.name, password: data.password)
          .catchError((error) {
        String errorMessage = error.message;
        message = errorMessage;
      });

      return Future.value(
          AuthUserModel(userId: mAuth.user.uid, email: mAuth.user.email));
    } on Exception {
      throw DataBaseException();
    }
  }

  @override
  Future<AuthUserModel> fblogin() async {
    final FacebookLoginResult result = await fbLogin.logIn(['email']);
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final FacebookAccessToken accessToken = result.accessToken;
        final AuthCredential credential =
            FacebookAuthProvider.credential(accessToken.token);
        final UserCredential authResult =
            await FirebaseAuth.instance.signInWithCredential(credential);
        if (authResult.user != null) {
          AuthUserModel _userModel = AuthUserModel(
              email: authResult.user.email,
              displayName: authResult.user.displayName,
              profileImage: authResult.user.photoURL,
              userId: authResult.user.uid,
              address: "",
              dob: DateTime.now().toUtc().millisecondsSinceEpoch,
              gender: GenderType.MALE,
              mobile: 0);

          DocumentSnapshot userDocumentSnapshot = await firebaseFirestore
              .collection(USERS_COLLECTION_NAME)
              .doc(authResult.user.uid)
              .get();
          if (!userDocumentSnapshot.exists) {
            firebaseFirestore
                .collection(USERS_COLLECTION_NAME)
                .doc(authResult.user.uid)
                .set(_userModel.toJson());
          }
          return Future.value(
            _userModel,
          );
        } else {
          throw AuthException();
        }
    }
  }

  @override
  Future<AuthUserModel> linkedinLogin() {}
}

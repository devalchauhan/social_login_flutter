import 'package:flutter/material.dart';
import 'package:social_login_flitter/feature/auth/domain/entities/auth_user.dart';

class AuthUserModel extends AuthUser {
  AuthUserModel({
    @required String email,
    @required String displayName,
    @required String profileImage,
    @required String userId,
    @required int dob,
    @required GenderType gender,
    @required String address,
    @required int mobile,
  }) : super(
          email: email,
          displayName: displayName,
          profileImage: profileImage,
          userId: userId,
          address: address,
          dob: dob,
          gender: gender,
          mobile: mobile,
        );

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'email': email,
      'displayName': displayName,
      'profileImage': profileImage,
      'address': address,
      'dob': dob,
      'gender': gender.index,
      'mobile': mobile,
    };
  }

  factory AuthUserModel.fromJson(Map<String, dynamic> json) {
    return AuthUserModel(
      email: json['email'],
      displayName: json['displayName'],
      profileImage: json['profileImage'],
      userId: json['userId'],
      gender: GenderType.values[json['gender']],
      dob: json['dob'],
      address: json['address'],
      mobile: json['mobile'],
    );
  }
}

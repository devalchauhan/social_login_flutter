import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum GenderType {
  MALE,
  FEMALE,
  OTHER
}
class AuthUser extends Equatable {
  final String email;
  final String displayName;
  final String profileImage;
  final String userId;
  final int dob;
  final GenderType gender;
  final String address;
  final int mobile;
  AuthUser({
    @required this.email,
    @required this.displayName,
    @required this.profileImage,
    @required this.userId,
    @required this.dob,
    @required this.gender,
    @required this.address,
    @required this.mobile
  });

  @override
  List<Object> get props => [
    email,
    displayName,
    profileImage,
    userId,
    dob,
    gender,
    address,
    mobile,
  ];
}

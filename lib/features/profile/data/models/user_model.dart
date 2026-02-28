import 'package:supabase_flutter/supabase_flutter.dart';

class UserModel {
  final String username;
  final String email;
  String? profileImage;
  UserModel({
    required this.username,
    required this.email,
    this.profileImage,
  });

  UserModel copyWith({
    String? username,
    String? email,
    String? profileImage,
  }) {
    return UserModel(
      username: username ?? this.username,
      email: email ?? this.email,
      profileImage: profileImage ?? this.profileImage,
    );
  }
  factory UserModel.fromJson(Map<String, dynamic> json) {
      return UserModel(
        username: json['username'],
        email: json['email'],
        profileImage: json['profileImage'] ?? 'https://faoxofyuwkyzuhbtjguk.supabase.co/storage/v1/object/public/images/default_profile.jpeg',
      );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'profileImage': profileImage,
    };
  }
    
}
import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'name.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User extends Equatable {
  @HiveField(0)
  final String? id;

  @HiveField(1)
  final Name name;

  @HiveField(2)
  final String email;

  @HiveField(3)
  final String avatarUrl;

  User({
    this.id,
    required this.name,
    required this.email,
    this.avatarUrl = '',
  });

  @override
  List<Object?> get props => [id, name, email];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      ...name.toMap(),
      'email': email,
      'avatar': avatarUrl,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    final user = map['user'];
    return User(
      id: user['id'] ?? '',
      name: Name.fromMap(user),
      email: user['email'] as String,
      avatarUrl: user['avatar'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}

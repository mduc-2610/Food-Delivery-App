import 'dart:convert';

import 'package:food_delivery_app/data/services/reflect.dart';

@reflector
@jsonSerializable
class DirectRoom {
  final String id;
  final String? name;
  final int user1Id;
  final int user2Id;

  DirectRoom({
    required this.id,
    this.name,
    required this.user1Id,
    required this.user2Id,
  });

  DirectRoom.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      name = json['name'],
      user1Id = json['user1'],
      user2Id = json['user2'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'user1': user1Id,
      'user2': user2Id,
    };
  }
}

@reflector
@jsonSerializable
class GroupRoom {
  final String id;
  final String? name;
  final List<int> memberIds;

  GroupRoom({
    required this.id,
    this.name,
    required this.memberIds,
  });

  GroupRoom.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      name = json['name'],
      memberIds = List<int>.from(json['members']);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'members': memberIds,
    };
  }
}

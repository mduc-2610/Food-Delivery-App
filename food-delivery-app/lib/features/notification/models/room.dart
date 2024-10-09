import 'dart:convert';

import 'package:food_delivery_app/data/services/reflect.dart';
import 'package:food_delivery_app/features/notification/models/message.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

@reflector
@jsonSerializable
class DirectRoom {
  final String? id;
  final String? name;
  final String? avatar;
  final String? user1;
  final String? user2;
  final String? messages;
  DirectMessage? latestMessage;

  DirectRoom({
    this.id,
    this.name,
    this.avatar,
    this.user1,
    this.user2,
    this.messages,
    this.latestMessage,
  });

  DirectRoom.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      name = json['name'],
      avatar = json['avatar'],
      user1 = json['user1'],
      user2 = json['user2'],
      messages = json['messages'],
      latestMessage = json['latest_message'] != null ? DirectMessage.fromJson(json['latest_message']) : null;

  Map<String, dynamic> toJson({ bool patch = false }) {
    Map<String, dynamic> data = {
      'id': id,
      'name': name,
      'avatar': avatar,
      'user1': user1,
      'user2': user2,
      'latest_message': latestMessage,
    };

    if(patch) {
      data.removeWhere((key, value) => value == null);
    }

    return data;
  }

  @override
  String toString() {
    return THelperFunction.formatToString(this);
  }
}

@reflector
@jsonSerializable
class GroupRoom {
  final String? id;
  final String? name;
  final List<String> memberIds;
  final String? messages;
  GroupMessage? latestMessage;

  GroupRoom({
    this.id,
    this.name,
    this.memberIds = const [],
    this.messages,
    this.latestMessage,
  });

  GroupRoom.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      name = json['name'],
      memberIds = List<String>.from(json['members']),
      messages = json['messages'],
      latestMessage = json['latest_message'] != null ? GroupMessage.fromJson(json['latest_message']) : null;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'members': memberIds,
    };
  }

  @override
  String toString() {
    return THelperFunction.formatToString(this);
  }
}

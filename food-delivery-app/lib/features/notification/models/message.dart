
import 'package:food_delivery_app/data/services/reflect.dart';

@reflector
class BaseMessage {
  final String id;
  final int userId;
  final String? content;
  final double? latitude;
  final double? longitude;
  final DateTime createdAt;

  BaseMessage({
    required this.id,
    required this.userId,
    this.content,
    this.latitude,
    this.longitude,
    required this.createdAt,
  });

  BaseMessage.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      userId = json['user'],
      content = json['content'],
      latitude = json['latitude'] != null ? (json['latitude'] as num).toDouble() : null,
      longitude = json['longitude'] != null ? (json['longitude'] as num).toDouble() : null,
      createdAt = DateTime.parse(json['created_at']);


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': userId,
      'content': content,
      'latitude': latitude,
      'longitude': longitude,
      'created_at': createdAt.toIso8601String(),
    };
  }

}

@reflector
@jsonSerializable
class DirectMessage extends BaseMessage {
  final String? room;

  DirectMessage({
    required String id,
    required int userId,
    String? content,
    double? latitude,
    double? longitude,
    required DateTime createdAt,
    this.room,
  }) : super(
    id: id,
    userId: userId,
    content: content,
    latitude: latitude,
    longitude: longitude,
    createdAt: createdAt,
  );

  DirectMessage.fromJson(Map<String, dynamic> json)
    : room = json['room'],
      super.fromJson(json);

  @override
  Map<String, dynamic> toJson() {
    final data = super.toJson();
    data['room'] = room;
    return data;
  }
}

@reflector
@jsonSerializable
class GroupMessage extends BaseMessage {
  final String? room;

  GroupMessage({
    required String id,
    required int userId,
    String? content,
    double? latitude,
    double? longitude,
    required DateTime createdAt,
    this.room,
  }) : super(
    id: id,
    userId: userId,
    content: content,
    latitude: latitude,
    longitude: longitude,
    createdAt: createdAt,
  );

  GroupMessage.fromJson(Map<String, dynamic> json)
      : room = json['room'],
        super.fromJson(json);

  @override
  Map<String, dynamic> toJson() {
    final data = super.toJson();
    data['room'] = room;
    return data;
  }
}


@reflector
class BaseImageMessage {
  final String id;
  final int userId;
  final String? imageUrl;
  final DateTime createdAt;

  BaseImageMessage({
    required this.id,
    required this.userId,
    this.imageUrl,
    required this.createdAt,
  });

  BaseImageMessage.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json['user'],
        imageUrl = json['image'],
        createdAt = DateTime.parse(json['created_at']);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': userId,
      'image': imageUrl,
      'created_at': createdAt.toIso8601String(),
    };
  }

  String getMessageContent() {
    return imageUrl ?? 'No Image';
  }
}

@reflector
@jsonSerializable
class DirectImageMessage extends BaseImageMessage {
  final String? room;

  DirectImageMessage({
    required String id,
    required int userId,
    String? imageUrl,
    required DateTime createdAt,
    this.room,
  }) : super(
    id: id,
    userId: userId,
    imageUrl: imageUrl,
    createdAt: createdAt,
  );

  DirectImageMessage.fromJson(Map<String, dynamic> json)
      : room = json['room'],
        super.fromJson(json);

  @override
  Map<String, dynamic> toJson() {
    final data = super.toJson();
    data['room'] = room;
    return data;
  }
}

@reflector
@jsonSerializable
class GroupImageMessage extends BaseImageMessage {
  final String? room;

  GroupImageMessage({
    required String id,
    required int userId,
    String? imageUrl,
    required DateTime createdAt,
    this.room,
  }) : super(
    id: id,
    userId: userId,
    imageUrl: imageUrl,
    createdAt: createdAt,
  );

  GroupImageMessage.fromJson(Map<String, dynamic> json)
      : room = json['room'],
        super.fromJson(json);

  @override
  Map<String, dynamic> toJson() {
    final data = super.toJson();
    data['room'] = room;
    return data;
  }
}


@reflector
class BaseVideoMessage {
  final String id;
  final int userId;
  final String? videoUrl;
  final DateTime createdAt;

  BaseVideoMessage({
    required this.id,
    required this.userId,
    this.videoUrl,
    required this.createdAt,
  });

  BaseVideoMessage.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json['user'],
        videoUrl = json['video'],
        createdAt = DateTime.parse(json['created_at']);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': userId,
      'video': videoUrl,
      'created_at': createdAt.toIso8601String(),
    };
  }

  String getMessageContent() {
    return videoUrl ?? 'No Video';
  }
}

@reflector
@jsonSerializable
class DirectVideoMessage extends BaseVideoMessage {
  final String? room;

  DirectVideoMessage({
    required String id,
    required int userId,
    String? videoUrl,
    required DateTime createdAt,
    this.room,
  }) : super(
    id: id,
    userId: userId,
    videoUrl: videoUrl,
    createdAt: createdAt,
  );

  DirectVideoMessage.fromJson(Map<String, dynamic> json)
      : room = json['room'],
        super.fromJson(json);

  @override
  Map<String, dynamic> toJson() {
    final data = super.toJson();
    data['room'] = room;
    return data;
  }
}

@reflector
@jsonSerializable
class GroupVideoMessage extends BaseVideoMessage {
  final String? room;

  GroupVideoMessage({
    required String id,
    required int userId,
    String? videoUrl,
    required DateTime createdAt,
    this.room,
  }) : super(
    id: id,
    userId: userId,
    videoUrl: videoUrl,
    createdAt: createdAt,
  );

  GroupVideoMessage.fromJson(Map<String, dynamic> json)
      : room = json['room'],
        super.fromJson(json);

  @override
  Map<String, dynamic> toJson() {
    final data = super.toJson();
    data['room'] = room;
    return data;
  }
}




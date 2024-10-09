import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:food_delivery_app/data/services/reflect.dart';
import 'package:food_delivery_app/features/authentication/models/account/user.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';
import 'package:flutter/material.dart';

@reflector
class BaseMessage {
  final String? id;
  final dynamic user;
  final String? room;
  final String? content;
  final double? latitude;
  final double? longitude;
  final DateTime? createdAt;
  final List<dynamic> images;
  final List<dynamic> videos;

  BaseMessage({
    this.id,
    this.user,
    this.room,
    this.content,
    this.latitude,
    this.longitude,
    this.createdAt,
    /*
      Retrieve, List will be BaseVideo and BaseImage
      Create, Update(patch) will be XFile and toFormData will be MultipartFile
    */
    this.images = const [],
    this.videos = const [],
  });

  BaseMessage.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        user = json['user'] is String || json['user'] == null || json['user'] is List
          ? json['user']
          : BasicUser.fromJson(json['user']),
        room = json['room'],
        content = json['content'],
        latitude = THelperFunction.formatDouble(json['latitude']),
        longitude = THelperFunction.formatDouble(json['longitude']),
        createdAt = json['created_at'] != null ? DateTime.parse(json['created_at']).toLocal() : null,
        images = json['images'] != null ? (json['images'] as List<dynamic>).map((instance) => BaseImage.fromJson(instance)).toList() : [],
        videos = json['videos'] != null ? (json['videos'] as List<dynamic>).map((instance) => BaseVideo.fromJson(instance)).toList() : [];


  Future<List<MultipartFile>> get multiPartImageFiles async {
    return await Future.wait(images.map((image) async => MultipartFile.fromFile(
      image.path,
      filename: image.name,
      contentType: MediaType('image', 'jpeg'),
    )).toList());
  }

  Future<List<MultipartFile>> get multiPartVideoFiles async {
    return await Future.wait(videos.map((video) async => MultipartFile.fromFile(
      video.path,
      filename: video.name,
      contentType: MediaType('video', 'mp4'),
    )).toList());
  }

  Future<FormData> toFormData() async {
    return FormData.fromMap({
      'user': user,
      'room': room,
      'content': content,
      'images': await multiPartImageFiles,
      'videos': await multiPartVideoFiles,
    });
  }

  @override
  String toString() {
    return THelperFunction.formatToString(this);
  }
}

@reflector
@jsonSerializable
class DirectMessage extends BaseMessage {
  DirectMessage({
    String? id,
    String? user,
    String? room,
    String? content,
    double? latitude,
    double? longitude,
    DateTime? createdAt,
    List<dynamic> images = const [],
    List<dynamic> videos = const [],
  }) : super(
    id: id,
    user: user,
    room: room,
    content: content,
    latitude: latitude,
    longitude: longitude,
    images: images,
    videos: videos,
    createdAt: createdAt
  );

  DirectMessage.fromJson(Map<String, dynamic> json) : super.fromJson(json);
}

@reflector
@jsonSerializable
class GroupMessage extends BaseMessage {
  GroupMessage({
    String? id,
    String? user,
    String? room,
    String? content,
    double? latitude,
    double? longitude,
    DateTime? createdAt,
    List<dynamic> images = const [],
    List<dynamic> videos = const [],
  }) : super(
    id: id,
    user: user,
    room: room,
    content: content,
    latitude: latitude,
    longitude: longitude,
    images: images,
    videos: videos,
    createdAt: createdAt,
  );

  GroupMessage.fromJson(Map<String, dynamic> json) : super.fromJson(json);
}

@reflector
@jsonSerializable
class BaseImage {
  String? id;
  String? image;
  String? message;

  BaseImage({
    this.id,
    this.image,
    this.message,
  });

  BaseImage.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        image = json['image'],
        message = json['message'];


  @override
  String toString() {
    return THelperFunction.formatToString(this);
  }
}

@reflector
@jsonSerializable
class BaseVideo {
  String? id;
  String? video;
  String? message;

  BaseVideo({
    this.id,
    this.video,
    this.message,
  });

  BaseVideo.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        video = json['video'],
        message = json['message'];

  @override
  String toString() {
    return THelperFunction.formatToString(this);
  }
}



import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'image_model.g.dart';

@JsonSerializable()
class ImageModel {
  String id;
  String? url;
  ImageModel({required this.id, this.url});

  factory ImageModel.fromJson(Map<String, dynamic> json) =>
      _$PrizeFromJson(json);
  Map<String, dynamic> toJson() => _$PrizeToJson(this);
}

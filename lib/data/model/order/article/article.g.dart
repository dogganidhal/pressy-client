// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Article _$ArticleFromJson(Map<String, dynamic> json) {
  return Article(
      id: json['id'] as int,
      name: json['name'] as String,
      laundryPrice: (json['laundryPrice'] as num)?.toDouble(),
      comment: json['comment'] as String,
      photoUrl: json['photoUrl'] as String);
}

Map<String, dynamic> _$ArticleToJson(Article instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'laundryPrice': instance.laundryPrice,
      'photoUrl': instance.photoUrl,
      'comment': instance.comment
    };

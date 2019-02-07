import 'package:json_annotation/json_annotation.dart';

part 'article.g.dart';

@JsonSerializable()
class Article {

  final int id;
  final String name;
  final double laundryPrice;
  final String photoUrl;
  final String comment;

  Article({this.id, this.name, this.laundryPrice, this.comment, this.photoUrl});

  factory Article.fromJson(Map<String, dynamic> json) => _$ArticleFromJson(json);
  Map<String, dynamic> toJson() => _$ArticleToJson(this);

}
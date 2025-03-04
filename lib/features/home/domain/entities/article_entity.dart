import 'package:hive_flutter/adapters.dart';
part 'article_entity.g.dart';

@HiveType(typeId: 0)
class ArticleEntity {
  @HiveField(0)
  String articleTitle;
  @HiveField(1)
  String articleUrl;
  @HiveField(2)
  String? articleUrlToImage;
  @HiveField(3)
  String articlePublishedAt;
  ArticleEntity({
    required this.articleTitle,
    required this.articleUrl,
    required this.articleUrlToImage,
    required this.articlePublishedAt,
  });
}

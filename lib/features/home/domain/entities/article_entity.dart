import 'package:hive_flutter/adapters.dart';

@HiveType(typeId: 0)
class ArticleEntity {
  String articleTitle;
  String articleUrl;
  String? articleUrlToImage;
  String articlePublishedAt;
  String articlAuthor;
  ArticleEntity({
    required this.articleTitle,
    required this.articleUrl,
    required this.articleUrlToImage,
    required this.articlePublishedAt,
    required this.articlAuthor,
  });
}

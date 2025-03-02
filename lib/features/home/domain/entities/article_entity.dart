class ArticleEntity {
  String articleTitle;
  String articleUrl;
  String? articleUrlToImage;
  String articlePublishedAt;
  ArticleEntity({
    required this.articleTitle,
    required this.articleUrl,
    required this.articleUrlToImage,
    required this.articlePublishedAt,
  });
}

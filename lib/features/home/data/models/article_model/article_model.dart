import 'package:newzly/features/home/domain/entities/article_entity.dart';

import 'source.dart';

class ArticleModel extends ArticleEntity {
  Source? source;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? publishedAt;
  String? content;

  ArticleModel({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  }) : super(
         articleTitle: title ?? 'Title',
         articleUrl: url ?? 'Link',
         articleUrlToImage: urlToImage,
         articlePublishedAt: publishedAt ?? 'Date',
         articlAuthor: author ?? 'Author',
       );

  factory ArticleModel.fromJson(Map<String, dynamic> json) => ArticleModel(
    source:
        json['source'] == null
            ? null
            : Source.fromJson(json['source'] as Map<String, dynamic>),
    author: json['author'] as String?,
    title: json['title'] as String?,
    description: json['description'] as String?,
    url: json['url'] as String?,
    urlToImage: json['urlToImage'] as String?,
    publishedAt: json['publishedAt'] as String?,
    content: json['content'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'source': source?.toJson(),
    'author': author,
    'title': title,
    'description': description,
    'url': url,
    'urlToImage': urlToImage,
    'publishedAt': publishedAt,
    'content': content,
  };
}

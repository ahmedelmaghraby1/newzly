import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:newzly/features/home/domain/entities/article_entity.dart';

class ArticleBox extends StatelessWidget {
  final ArticleEntity article;
  const ArticleBox({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        log('/article/${article.articleUrl}');
        context.go('/article/${article}');
      },
      child: SizedBox(
        child: Column(
          spacing: 10.h,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15.r),
              child: CachedNetworkImage(
                imageUrl: article.articleUrlToImage ?? '',
              ),
            ),
            Row(children: [Text(article.articlAuthor)]),
            Text(article.articleTitle, overflow: TextOverflow.visible),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [Text(article.articlePublishedAt)],
            ),
          ],
        ),
      ),
    );
  }
}

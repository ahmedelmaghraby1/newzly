import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newzly/features/home/domain/entities/article_entity.dart';

class ArticleBox extends StatelessWidget {
  final ArticleEntity article;
  const ArticleBox({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 300.h,
      child: Column(
        spacing: 10.h,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15.r),
            child: CachedNetworkImage(
              imageUrl: article.articleUrlToImage ?? '',
              // height: 180.h,
              // width: 350.w,
              // filterQuality: FilterQuality.high,
              // fit: BoxFit.fitWidth,
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
    );
  }
}

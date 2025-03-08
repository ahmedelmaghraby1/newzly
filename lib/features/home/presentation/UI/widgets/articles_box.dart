import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:newzly/core/constants/images.dart';
import 'package:newzly/core/utils/extensions.dart';
import 'package:newzly/features/home/domain/entities/article_entity.dart';

class ArticleBox extends StatelessWidget {
  final ArticleEntity article;
  const ArticleBox({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push('/article/${Uri.encodeComponent(article.articleUrl)}');
      },
      child: SizedBox(
        child: Column(
          spacing: 10.h,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15.r),
              child:
                  (article.articleUrlToImage == null ||
                          (article.articleUrlToImage!).isEmpty ||
                          !Uri.parse(article.articleUrlToImage!).isAbsolute)
                      ? Image.asset(ImageConstants.noImage)
                      : CachedNetworkImage(
                        imageUrl: article.articleUrlToImage!,
                        errorWidget:
                            (context, url, error) =>
                                Image.asset(ImageConstants.noImage),
                        placeholder:
                            (context, url) =>
                                Image.asset(ImageConstants.loading),
                      ),
            ),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(article.articlAuthor),
            ),
            Text(article.articleTitle, overflow: TextOverflow.visible),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [Text(article.articlePublishedAt.timeAgo(context))],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newzly/features/home/domain/entities/article_entity.dart';
import 'package:newzly/features/home/presentation/UI/widgets/articles_box.dart';

class GeneralNewsListView extends StatelessWidget {
  final ScrollController scrollController;
  final List<ArticleEntity> articles;
  const GeneralNewsListView({
    super.key,
    required this.articles,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      controller: scrollController,
      itemBuilder:
          (BuildContext context, int index) =>
              ArticleBox(article: articles[index]),
      separatorBuilder:
          (BuildContext context, int index) => SizedBox(height: 10.h),
      itemCount: articles.length,
    );
  }
}

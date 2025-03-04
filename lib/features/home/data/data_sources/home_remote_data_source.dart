import 'package:newzly/core/utils/dio_helper.dart';
import 'package:newzly/core/utils/enums.dart';
import 'package:newzly/core/utils/initialize_hive.dart';
import 'package:newzly/features/home/data/models/article_model/article_model.dart';
import 'package:newzly/features/home/domain/entities/article_entity.dart';

abstract class HomeRemoteDataSource {
  Future<List<ArticleEntity>> fetchCategoryNews({
    required NewsCategory category,
    // required int page,
    // required int pageSize,
  });
  List<ArticleEntity> getRemoteArticlesList({
    required Map<String, dynamic> data,
  }) {
    late List<ArticleEntity> articles = [];

    for (Map<String, dynamic> articleData in data['articles']) {
      articles.add(ArticleModel.fromJson(articleData));
    }
    return articles;
  }
}

class HomeRemoteDataSourceImplementation extends HomeRemoteDataSource {
  final DioHelper dioHelper;
  HomeRemoteDataSourceImplementation({required this.dioHelper});

  @override
  Future<List<ArticleEntity>> fetchCategoryNews({
    required NewsCategory category,
    // required int page,
    // required int pageSize,
  }) async {
    late String newsCategory = 'general';
    switch (category) {
      case NewsCategory.general:
        newsCategory = 'general';

      case NewsCategory.health:
        newsCategory = 'health';

      case NewsCategory.sports:
        newsCategory = 'sports';

      case NewsCategory.technology:
        newsCategory = 'technology';

      case NewsCategory.business:
        newsCategory = 'business';

      case NewsCategory.entertainment:
        newsCategory = 'entertainment';
    }
    Map<String, dynamic> data = await dioHelper.get(
      endPoint: 'category=$newsCategory',
    );
    late List<ArticleEntity> articles = getRemoteArticlesList(data: data);
    HiveHelper.saveArticles(category: category, articles: articles);
    return articles;
  }
}

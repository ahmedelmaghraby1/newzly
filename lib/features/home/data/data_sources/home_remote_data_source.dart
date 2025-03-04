import 'package:newzly/core/utils/dio_helper.dart';
import 'package:newzly/core/utils/enums.dart';
import 'package:newzly/core/utils/get_category_name_from_enum.dart';
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
    late String categoryName = getCategoryName(category: category);
    Map<String, dynamic> data = await dioHelper.get(
      endPoint: 'category=$categoryName',
    );
    late List<ArticleEntity> articles = getRemoteArticlesList(data: data);
    HiveHelper.saveArticles(category: category, articles: articles);
    return articles;
  }
}

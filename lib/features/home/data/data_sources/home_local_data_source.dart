import 'package:hive_flutter/hive_flutter.dart';
import 'package:newzly/core/utils/enums.dart';
import 'package:newzly/core/utils/get_category_name_from_enum.dart';

import 'package:newzly/features/home/domain/entities/article_entity.dart';

abstract class HomeLocalDataSource {
  List<ArticleEntity> fetchCategoryNews({required NewsCategory category});
}

class HomeLocalDataSourceImplementation extends HomeLocalDataSource {
  @override
  List<ArticleEntity> fetchCategoryNews({required NewsCategory category}) {
    late final String categoryName = getCategoryName(category: category);
    late final String articlesBoxName = '${categoryName}Articles';

    Box<ArticleEntity> box = Hive.box(articlesBoxName);
    return box.values.toList();
  }
}

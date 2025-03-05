import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:newzly/core/utils/enums.dart';
import 'package:newzly/core/utils/get_category_name_from_enum.dart';
import 'package:newzly/features/home/domain/entities/article_entity.dart';

class HiveHelper {
  static Future<void> initHive() async {
    await Hive.initFlutter();
    if (!Hive.isAdapterRegistered(ArticleEntityAdapter().typeId)) {
      Hive.registerAdapter(ArticleEntityAdapter());
    }
    await Future.wait([
      Hive.openBox<ArticleEntity>('generalArticles'),
      Hive.openBox<ArticleEntity>('healthArticles'),
      Hive.openBox<ArticleEntity>('sportsArticles'),
      Hive.openBox<ArticleEntity>('technologyArticles'),
      Hive.openBox<ArticleEntity>('businessArticles'),
      Hive.openBox<ArticleEntity>('entertainmentArticles'),
      Hive.openBox<dynamic>('settings'),
    ]);
  }

  static saveArticles({
    required NewsCategory category,
    required List<ArticleEntity> articles,
  }) {
    late final String categoryName = getCategoryName(category: category);
    late final String articlesBoxName = '${categoryName}Articles';
    Hive.box<ArticleEntity>(articlesBoxName).addAll(articles);
  }

  static ValueListenable<Box<dynamic>> settingsListenable() {
    return Hive.box<dynamic>('settings').listenable();
  }
}

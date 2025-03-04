import 'package:newzly/core/utils/enums.dart';

String getCategoryName({required NewsCategory category}) {
  late String articlesBoxName;
  switch (category) {
    case NewsCategory.general:
      articlesBoxName = 'generalArticles';

    case NewsCategory.health:
      articlesBoxName = 'healthArticles';

    case NewsCategory.sports:
      articlesBoxName = 'sportsArticles';

    case NewsCategory.technology:
      articlesBoxName = 'technologyArticles';

    case NewsCategory.business:
      articlesBoxName = 'businessArticles';

    case NewsCategory.entertainment:
      articlesBoxName = 'entertainmentArticles';
  }
  return articlesBoxName;
}

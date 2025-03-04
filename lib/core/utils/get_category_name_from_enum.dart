import 'package:newzly/core/utils/enums.dart';

String getCategoryName({required NewsCategory category}) {
  late String articlesBoxName;
  switch (category) {
    case NewsCategory.general:
      articlesBoxName = 'general';

    case NewsCategory.health:
      articlesBoxName = 'health';

    case NewsCategory.sports:
      articlesBoxName = 'sports';

    case NewsCategory.technology:
      articlesBoxName = 'technology';

    case NewsCategory.business:
      articlesBoxName = 'business';

    case NewsCategory.entertainment:
      articlesBoxName = 'entertainment';
  }
  return articlesBoxName;
}

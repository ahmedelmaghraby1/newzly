import 'package:dartz/dartz.dart';
import 'package:newzly/core/models/errors/failure_model.dart';
import 'package:newzly/core/utils/enums.dart';
import 'package:newzly/features/home/domain/entities/article_entity.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<ArticleEntity>>> fetchCategoryNews({
    required NewsCategory category,
  });
}

import 'package:dartz/dartz.dart';
import 'package:newzly/core/models/errors/failure_model.dart';
import 'package:newzly/core/use_cases/generic_use_case.dart';
import 'package:newzly/core/utils/enums.dart';
import 'package:newzly/features/home/data/repositories/home_repository_imp.dart';
import 'package:newzly/features/home/domain/entities/article_entity.dart';

class FetchGeneralNewsUseCase
    extends UseCase<List<ArticleEntity>, NoParameters> {
  final HomeRepositoryImplementation _homeRepositoryImplementation;
  FetchGeneralNewsUseCase(this._homeRepositoryImplementation);

  @override
  Future<Either<Failure, List<ArticleEntity>>> call([
    NoParameters? parameters,
  ]) {
    return _homeRepositoryImplementation.fetchCategoryNews(
      category: NewsCategory.general,
    );
  }
}

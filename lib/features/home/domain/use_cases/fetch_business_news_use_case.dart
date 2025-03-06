import 'package:dartz/dartz.dart';
import 'package:newzly/core/models/errors/failure_model.dart';
import 'package:newzly/core/use_cases/generic_use_case.dart';
import 'package:newzly/core/utils/enums.dart';
import 'package:newzly/features/home/domain/entities/article_entity.dart';
import 'package:newzly/features/home/domain/repositories/home_repo.dart';

class FetchBusinessNewsUseCase extends UseCase<List<ArticleEntity>, int> {
  final HomeRepository _homeRepositoryHomeRepository;
  FetchBusinessNewsUseCase(this._homeRepositoryHomeRepository);

  @override
  Future<Either<Failure, List<ArticleEntity>>> call([int? page]) {
    return _homeRepositoryHomeRepository.fetchCategoryNews(
      category: NewsCategory.business,
      page: page,
    );
  }
}

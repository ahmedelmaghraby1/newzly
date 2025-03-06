import 'package:dartz/dartz.dart';
import 'package:newzly/core/models/errors/failure_model.dart';
import 'package:newzly/core/use_cases/generic_use_case.dart';
import 'package:newzly/core/utils/enums.dart';
import 'package:newzly/features/home/domain/entities/article_entity.dart';
import 'package:newzly/features/home/domain/repositories/home_repo.dart';

class FetchHealthNewsUseCase extends UseCase<List<ArticleEntity>, int> {
  final HomeRepository _homeRepository;
  FetchHealthNewsUseCase(this._homeRepository);

  @override
  Future<Either<Failure, List<ArticleEntity>>> call([int? page]) {
    return _homeRepository.fetchCategoryNews(
      category: NewsCategory.health,
      page: page,
    );
  }
}

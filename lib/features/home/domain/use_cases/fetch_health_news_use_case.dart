import 'package:dartz/dartz.dart';
import 'package:newzly/core/models/failure_model.dart';
import 'package:newzly/core/use_cases/generic_use_case.dart';
import 'package:newzly/features/home/domain/entities/article_entity.dart';
import 'package:newzly/features/home/domain/repositories/home_repo.dart';

class FetchHealthNewsUseCase
    extends UseCase<List<ArticleEntity>, NoParameters> {
  final HomeRepository _homeRepository;
  FetchHealthNewsUseCase(this._homeRepository);

  @override
  Future<Either<Failure, List<ArticleEntity>>> call([
    NoParameters? parameters,
  ]) {
    return _homeRepository.fetchHealthtNews();
  }
}

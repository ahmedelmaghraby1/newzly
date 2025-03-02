import 'package:dartz/dartz.dart';
import 'package:newzly/core/models/failure_model.dart';
import 'package:newzly/features/home/domain/entities/article_entity.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<ArticleEntity>>> fetchGeneralNews();
  Future<Either<Failure, List<ArticleEntity>>> fetchSportsNews();
  Future<Either<Failure, List<ArticleEntity>>> fetchBusinessNews();
  Future<Either<Failure, List<ArticleEntity>>> fetchEntertainmentNews();
  Future<Either<Failure, List<ArticleEntity>>> fetchHealthtNews();
  Future<Either<Failure, List<ArticleEntity>>> fetchTechnologyNews();
}

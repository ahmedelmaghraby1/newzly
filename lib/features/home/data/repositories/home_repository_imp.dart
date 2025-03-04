import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:newzly/core/models/errors/failure_model.dart';
import 'package:newzly/core/models/errors/failures_model.dart';
import 'package:newzly/core/utils/enums.dart';
import 'package:newzly/features/home/data/data_sources/home_local_data_source.dart';
import 'package:newzly/features/home/data/data_sources/home_remote_data_source.dart';
import 'package:newzly/features/home/domain/entities/article_entity.dart';
import 'package:newzly/features/home/domain/repositories/home_repo.dart';

class HomeRepositoryImplementation extends HomeRepository {
  final HomeRemoteDataSource _homeRemoteDataSource;
  final HomeLocalDataSource _homeLocalDataSource;

  HomeRepositoryImplementation({
    required HomeRemoteDataSource homeRemoteDataSource,
    required HomeLocalDataSource homeLocalDataSource,
  }) : _homeRemoteDataSource = homeRemoteDataSource,
       _homeLocalDataSource = homeLocalDataSource;

  @override
  Future<Either<Failure, List<ArticleEntity>>> fetchCategoryNews({
    required NewsCategory category,
  }) async {
    List<ArticleEntity> articlesList;
    try {
      articlesList = _homeLocalDataSource.fetchCategoryNews(
        category: NewsCategory.business,
      );
      if (articlesList.isNotEmpty) {
        return right(articlesList);
      }
      articlesList = await _homeRemoteDataSource.fetchCategoryNews(
        category: NewsCategory.business,
      );
      return right(articlesList);
    } catch (e) {
      if (e is DioException) {
        return left(NetworkFailureModel.fromDioError(e));
      } else {
        return left(NetworkFailureModel(errorMessage: 'Unknown error'));
      }
    }
  }
}

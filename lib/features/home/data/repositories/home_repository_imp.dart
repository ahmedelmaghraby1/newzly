import 'dart:developer';

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
  final HomeRemoteDataSource homeRemoteDataSource;
  final HomeLocalDataSource homeLocalDataSource;

  HomeRepositoryImplementation({
    required this.homeRemoteDataSource,
    required this.homeLocalDataSource,
  });

  @override
  Future<Either<Failure, List<ArticleEntity>>> fetchCategoryNews({
    int? page,
    required NewsCategory category,
  }) async {
    List<ArticleEntity> articlesList;
    try {
      articlesList = homeLocalDataSource.fetchCategoryNews(category: category);
      if (articlesList.isNotEmpty) {
        return right(articlesList);
      }
      articlesList = await homeRemoteDataSource.fetchCategoryNews(
        page: page ?? 0,
        category: category,
      );
      return right(articlesList);
    } catch (e) {
      log(e.toString());

      if (e is DioException) {
        return left(NetworkFailureModel.fromDioError(e));
      } else {
        return left(NetworkFailureModel(errorMessage: 'Unknown error'));
      }
    }
  }
}

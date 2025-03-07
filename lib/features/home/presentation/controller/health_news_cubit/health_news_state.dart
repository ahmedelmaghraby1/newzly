part of 'health_news_cubit.dart';

sealed class HealthNewsState {}

final class HealthNewsInitial extends HealthNewsState {}

final class HealthNewsLoading extends HealthNewsState {}

final class HealthNewsPaginationLoading extends HealthNewsState {}

final class HealthNewsLoaded extends HealthNewsState {
  final List<ArticleEntity> articles;
  HealthNewsLoaded({required this.articles});
}

final class HealthNewsFailure extends HealthNewsState {
  final String errorMessage;
  HealthNewsFailure({required this.errorMessage});
}

final class HealthNewsPaginationFailure extends HealthNewsState {
  final String errorMessage;
  HealthNewsPaginationFailure({required this.errorMessage});
}

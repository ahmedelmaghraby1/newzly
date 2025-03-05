part of 'sports_news_cubit.dart';

sealed class SportsNewsState {}

final class SportsNewsInitial extends SportsNewsState {}

final class SportsNewsLoading extends SportsNewsState {}

final class SportsNewsLoaded extends SportsNewsState {
  final List<ArticleEntity> articles;
  SportsNewsLoaded({required this.articles});
}

final class SportsNewsFailure extends SportsNewsState {
  final String errorMessage;
  SportsNewsFailure({required this.errorMessage});
}

part of 'technology_news_cubit.dart';

sealed class TechnologyNewsState {}

final class TechnologyNewsInitial extends TechnologyNewsState {}

final class TechnologyNewsLoading extends TechnologyNewsState {}

final class TechnologyNewsLoaded extends TechnologyNewsState {
  final List<ArticleEntity> articles;
  TechnologyNewsLoaded({required this.articles});
}

final class TechnologyNewsFailure extends TechnologyNewsState {
  final String errorMessage;
  TechnologyNewsFailure({required this.errorMessage});
}

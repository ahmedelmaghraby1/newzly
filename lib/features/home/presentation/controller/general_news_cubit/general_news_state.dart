part of 'general_news_cubit.dart';

sealed class GeneralNewsState {}

final class GeneralNewsInitial extends GeneralNewsState {}

final class GeneralNewsLoading extends GeneralNewsState {}

final class GeneralNewsLoaded extends GeneralNewsState {
  final List<ArticleEntity> articles;
  GeneralNewsLoaded({required this.articles});
}

final class GeneralNewsFailure extends GeneralNewsState {
  final String errorMessage;
  GeneralNewsFailure({required this.errorMessage});
}

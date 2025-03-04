part of 'entertainment_news_cubit.dart';

sealed class EntertainmentNewsState {}

final class EntertainmentNewsInitial extends EntertainmentNewsState {}

final class EntertainmentNewsLoading extends EntertainmentNewsState {}

final class EntertainmentNewsLoaded extends EntertainmentNewsState {
  final List<ArticleEntity> articles;
  EntertainmentNewsLoaded({required this.articles});
}

final class EntertainmentNewsFailure extends EntertainmentNewsState {
  final String errorMessage;
  EntertainmentNewsFailure({required this.errorMessage});
}

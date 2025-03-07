part of 'business_news_cubit.dart';

sealed class BusinessNewsState {}

final class BusinessNewsInitial extends BusinessNewsState {}

final class BusinessNewsLoading extends BusinessNewsState {}

final class BusinessNewsPaginationLoading extends BusinessNewsState {}

final class BusinessNewsLoaded extends BusinessNewsState {
  final List<ArticleEntity> articles;
  BusinessNewsLoaded({required this.articles});
}

final class BusinessNewsFailure extends BusinessNewsState {
  final String errorMessage;
  BusinessNewsFailure({required this.errorMessage});
}

final class BusinessNewsPaginationFailure extends BusinessNewsState {
  final String errorMessage;
  BusinessNewsPaginationFailure({required this.errorMessage});
}

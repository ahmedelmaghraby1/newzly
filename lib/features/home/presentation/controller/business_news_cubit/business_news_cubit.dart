import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newzly/core/models/errors/failure_model.dart';
import 'package:newzly/features/home/domain/entities/article_entity.dart';
import 'package:newzly/features/home/domain/use_cases/fetch_business_news_use_case.dart';
part 'business_news_state.dart';

class BusinessNewsCubit extends Cubit<BusinessNewsState> {
  final FetchBusinessNewsUseCase fetchBusinessNewsUseCase;
  BusinessNewsCubit({required this.fetchBusinessNewsUseCase})
    : super(BusinessNewsInitial());
  Future<void> fetchBusinessNews({int page = 0}) async {
    if (page == 0) {
      emit(BusinessNewsLoading());
    } else {
      emit(BusinessNewsPaginationLoading());
    }
    Either<Failure, List<ArticleEntity>> result = await fetchBusinessNewsUseCase
        .call(page);
    result.fold(
      (failure) {
        if (page == 0) {
          emit(BusinessNewsFailure(errorMessage: failure.errorMessage));
        } else {
          emit(
            BusinessNewsPaginationFailure(errorMessage: failure.errorMessage),
          );
        }
      },
      (articles) {
        emit(BusinessNewsLoaded(articles: articles));
      },
    );
  }
}

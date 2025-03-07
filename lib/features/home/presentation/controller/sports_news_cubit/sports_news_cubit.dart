import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newzly/core/models/errors/failure_model.dart';
import 'package:newzly/features/home/domain/entities/article_entity.dart';
import 'package:newzly/features/home/domain/use_cases/fetch_sports_news_use_case.dart';
part 'sports_news_state.dart';

class SportsNewsCubit extends Cubit<SportsNewsState> {
  final FetchSportsNewsUseCase fetchSportsNewsUseCase;
  SportsNewsCubit({required this.fetchSportsNewsUseCase})
    : super(SportsNewsInitial());
  Future<void> fetchSportsNews({int page = 0}) async {
    if (page == 0) {
      emit(SportsNewsLoading());
    } else {
      emit(SportsNewsPaginationLoading());
    }
    Either<Failure, List<ArticleEntity>> result = await fetchSportsNewsUseCase
        .call(page);
    result.fold(
      (failure) {
        if (page == 0) {
          emit(SportsNewsFailure(errorMessage: failure.errorMessage));
        } else {
          emit(SportsNewsPaginationFailure(errorMessage: failure.errorMessage));
        }
      },
      (articles) {
        emit(SportsNewsLoaded(articles: articles));
      },
    );
  }
}

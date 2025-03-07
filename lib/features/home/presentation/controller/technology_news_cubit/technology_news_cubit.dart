import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newzly/core/models/errors/failure_model.dart';
import 'package:newzly/features/home/domain/entities/article_entity.dart';
import 'package:newzly/features/home/domain/use_cases/fetch_technology_news_use_case.dart';
part 'technology_news_state.dart';

class TechnologyNewsCubit extends Cubit<TechnologyNewsState> {
  final FetchTechnologyNewsUseCase fetchTechnologyNewsUseCase;
  TechnologyNewsCubit({required this.fetchTechnologyNewsUseCase})
    : super(TechnologyNewsInitial());
  Future<void> fetchTechnologyNews({int page = 0}) async {
    if (page == 0) {
      emit(TechnologyNewsLoading());
    } else {
      emit(TechnologyNewsPaginationLoading());
    }
    Either<Failure, List<ArticleEntity>> result =
        await fetchTechnologyNewsUseCase.call(page);
    result.fold(
      (failure) {
        if (page == 0) {
          emit(TechnologyNewsFailure(errorMessage: failure.errorMessage));
        } else {
          emit(
            TechnologyNewsPaginationFailure(errorMessage: failure.errorMessage),
          );
        }
      },
      (articles) {
        emit(TechnologyNewsLoaded(articles: articles));
      },
    );
  }
}

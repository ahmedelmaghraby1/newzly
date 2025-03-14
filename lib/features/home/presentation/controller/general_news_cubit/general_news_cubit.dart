import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newzly/core/models/errors/failure_model.dart';
import 'package:newzly/features/home/domain/entities/article_entity.dart';
import 'package:newzly/features/home/domain/use_cases/fetch_general_news_use_case.dart';
part 'general_news_state.dart';

class GeneralNewsCubit extends Cubit<GeneralNewsState> {
  final FetchGeneralNewsUseCase fetchGeneralNewsUseCase;
  GeneralNewsCubit({required this.fetchGeneralNewsUseCase})
    : super(GeneralNewsInitial());
  Future<void> fetchGeneralNews({int page = 0}) async {
    if (page == 0) {
      emit(GeneralNewsLoading());
    } else {
      emit(GeneralNewsPaginationLoading());
    }
    Either<Failure, List<ArticleEntity>> result = await fetchGeneralNewsUseCase
        .call(page);
    result.fold(
      (failure) {
        if (page == 0) {
          emit(GeneralNewsFailure(errorMessage: failure.errorMessage));
        } else {
          emit(
            GeneralNewsPaginationFailure(errorMessage: failure.errorMessage),
          );
        }
      },
      (articles) {
        emit(GeneralNewsLoaded(articles: articles));
      },
    );
  }
}

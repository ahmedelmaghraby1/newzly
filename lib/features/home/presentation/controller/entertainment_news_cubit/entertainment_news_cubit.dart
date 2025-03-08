import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newzly/core/models/errors/failure_model.dart';
import 'package:newzly/features/home/domain/entities/article_entity.dart';
import 'package:newzly/features/home/domain/use_cases/fetch_entertainment_news_use_case.dart';
part 'entertainment_news_state.dart';

class EntertainmentNewsCubit extends Cubit<EntertainmentNewsState> {
  final FetchEntertainmentNewsUseCase fetchEntertainmentNewsUseCase;
  EntertainmentNewsCubit({required this.fetchEntertainmentNewsUseCase})
    : super(EntertainmentNewsInitial());
  Future<void> fetchEntertainmentNews({int page = 0}) async {
    if (page == 0) {
      emit(EntertainmentNewsLoading());
    } else {
      emit(EntertainmentNewsPaginationLoading());
    }
    Either<Failure, List<ArticleEntity>> result =
        await fetchEntertainmentNewsUseCase.call(page);
    result.fold(
      (failure) {
        if (page == 0) {
          emit(EntertainmentNewsFailure(errorMessage: failure.errorMessage));
        } else {
          emit(
            EntertainmentNewsPaginationFailure(
              errorMessage: failure.errorMessage,
            ),
          );
        }
      },
      (articles) {
        emit(EntertainmentNewsLoaded(articles: articles));
      },
    );
  }
}

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newzly/core/models/errors/failure_model.dart';
import 'package:newzly/features/home/domain/entities/article_entity.dart';
import 'package:newzly/features/home/domain/use_cases/fetch_Entertainment_news_use_case.dart';
part 'entertainment_news_state.dart';

class EntertainmentNewsCubit extends Cubit<EntertainmentNewsState> {
  final FetchEntertainmentNewsUseCase fetchEntertainmentNewsUseCase;
  EntertainmentNewsCubit({required this.fetchEntertainmentNewsUseCase})
    : super(EntertainmentNewsInitial());
  Future<void> fetchEntertainmentNews() async {
    emit(EntertainmentNewsLoading());
    Either<Failure, List<ArticleEntity>> result =
        await fetchEntertainmentNewsUseCase.call();
    result.fold(
      (failure) {
        emit(EntertainmentNewsFailure(errorMessage: failure.errorMessage));
      },
      (articles) {
        emit(EntertainmentNewsLoaded(articles: articles));
      },
    );
  }
}

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
  Future<void> fetchTechnologyNews() async {
    emit(TechnologyNewsLoading());
    Either<Failure, List<ArticleEntity>> result =
        await fetchTechnologyNewsUseCase.call();
    result.fold(
      (failure) {
        emit(TechnologyNewsFailure(errorMessage: failure.errorMessage));
      },
      (articles) {
        emit(TechnologyNewsLoaded(articles: articles));
      },
    );
  }
}

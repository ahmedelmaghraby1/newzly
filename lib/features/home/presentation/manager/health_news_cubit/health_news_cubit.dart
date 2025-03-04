import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newzly/core/models/errors/failure_model.dart';
import 'package:newzly/features/home/domain/entities/article_entity.dart';
import 'package:newzly/features/home/domain/use_cases/fetch_health_news_use_case.dart';
part 'health_news_state.dart';

class HealthNewsCubit extends Cubit<HealthNewsState> {
  final FetchHealthNewsUseCase fetchHealthNewsUseCase;
  HealthNewsCubit({required this.fetchHealthNewsUseCase})
    : super(HealthNewsInitial());
  Future<void> fetchHealthNews() async {
    emit(HealthNewsLoading());
    Either<Failure, List<ArticleEntity>> result =
        await fetchHealthNewsUseCase.call();
    result.fold(
      (failure) {
        emit(HealthNewsFailure(errorMessage: failure.errorMessage));
      },
      (articles) {
        emit(HealthNewsLoaded(articles: articles));
      },
    );
  }
}
